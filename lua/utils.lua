local M = {}
local api = vim.api

function M.blameVirtText()
  local ft = vim.ft.expand('%:h:t') -- get current file extension
  if ft == '' then -- scratch buffer or unknown filetype
    return
  end
  if ft == 'bin' then -- terminal window
    return
  end

  api.nvim_buf_clear_namespace(0, 2, 0, -1) -- clear the buffer in these coordinates

  local currFile = vim.fn.expand('%')
  local line = api.nvim_win_get_cursor(0)
  local blame = vim.fn.system(string.format('git blame -c -L %d,%d %s', line[1], line[1], currFile))
  local hash = vim.split(blame, '%s')[1]
  local cmd = string.format('git show %s', hash).."--format='%an | %ar | %s'"
  if hash == '00000000' then
    text = 'Not commited yet'
  else
    text = vim.fn.system(cmd)
    text = vim.split(text, '\n')[1]
    if text:find('fatal') then -- git command failed
      text = 'Not commited yet'
    end
  end
  api.nvim_buf_set_virtual_text(0, 2, line[1] - 1, {{ text, 'GitLens' }}, {})
end

function M.clearBlameVirtText()
  api.nvim_buf_clear_namespace(0, 2, 0, -1)
end
