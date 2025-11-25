local M = {}

local ns_id = vim.api.nvim_create_namespace('LogNotes')
local config = {
  enabled = true,
  notes_dir = "~/notes/",
}

-- Configure the plugin
-- @param opts table: Configuration options
function M.setup(opts)
  config = vim.tbl_deep_extend("force", config, opts or {})
  -- Create the notes directory if it doesn't exist
  os.execute("mkdir -p " .. config.notes_dir)
  -- Initialize a git repository in the notes directory, if it doesn't exist
  os.execute("git -C " .. config.notes_dir .. " init")
end

--- Get last commit timestamp using git blame
-- @param filename string: The file to check
-- @param line_num number: The line number to check
-- @return string: The timestamp from git blame
local function get_git_timestamp(filename, line_num)
  if vim.fn.filereadable(filename) == 0 then
    return "No timestamp"
  end
  local cmd = "cd " ..
      config.notes_dir ..
      " && git blame -L " .. line_num .. "," .. line_num .. " -- " .. vim.fn.fnameescape(filename) .. " --date=iso"
  local handle = io.popen(cmd)
  if not handle then
    return "No handle"
  end
  local result = handle:read("*a")
  handle:close()
  local timestamp = result:match("(%d%d%d%d%-%d%d%-%d%d %d%d:%d%d:%d%d)")
  return timestamp or "No timestamp"
end

-- Log timestamp as virtual text
-- @param bufnr number: Buffer number
local function log_timestamp(bufnr)
  bufnr = bufnr or vim.api.nvim_get_current_buf()
  local filename = vim.api.nvim_buf_get_name(bufnr)
  local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)

  for i in ipairs(lines) do
    local timestamp = get_git_timestamp(filename, i)
    vim.api.nvim_buf_set_extmark(bufnr, ns_id, i - 1, 0, {
      virt_text = { { timestamp, "Comment" } },
      virt_text_pos = "eol",
    })
  end

  -- Autocommit changes
  os.execute("cd " ..
    config.notes_dir .. " && git add " .. vim.fn.fnameescape(filename) .. "&& git commit -m 'LogNotes: Auto commit'")
end

vim.api.nvim_create_autocmd({ "TextChanged", "TextChangedI" }, {
  callback = function(ev) log_timestamp(ev.buf) end,
})

--- Toggle timestamps visibility
local toggle_timestamps = true
function M.toggle()
  toggle_timestamps = not toggle_timestamps
  if not toggle_timestamps then
    vim.api.nvim_buf_clear_namespace(0, ns_id, 0, -1)
  else
    log_timestamp()
  end
end

vim.api.nvim_create_user_command("ToggleTimestamps", M.toggle, {})

return M
