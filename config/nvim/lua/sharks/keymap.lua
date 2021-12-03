local api = vim.api

local M = {}

-- Util functions

-- normal keymap
M.keymap = function(mode, key, action)
  api.nvim_set_keymap(mode, key, action, { noremap = true, silent = true })
end

-- lua wrapper keymap
M.keymap_lua = function(mode, key, action)
  local action = "<CMD>lua " .. action .. "<CR>"
  api.nvim_set_keymap(mode, key, action, { noremap = true, silent = true })
end


M.toggle_quickfix = function ()
  local windows = api.nvim_tabpage_list_wins(0)
  local closed = false
  for _, window in ipairs(windows) do
    local buf = api.nvim_win_get_buf(window)
    local ft = api.nvim_buf_get_option(buf, "filetype")
    if ft == "qf" then
      api.nvim_win_close(window, true)
      closed = true
    end
  end
  if not closed then
    vim.cmd[[copen]]
    local height = vim.o.previewheight
    api.nvim_win_set_height(0, height)
  end
end

M.clear_quickfix = function ()
  vim.fn.setqflist({})
  vim.cmd[[cclose]]
end

-- Start keymaps

-- Quickfix actions
M.keymap('n', '<leader>qe', "<CMD>lua require('sharks.diagnostics').errors_to_quickfix()<CR><CMD>copen<CR>")
M.keymap('n', '<leader>qw', "<CMD>lua require('sharks.diagnostics').warnings_to_quickfix()<CR><CMD>copen<CR>")
M.keymap_lua('n', '<leader>qo', "require('sharks.keymap').toggle_quickfix()")
M.keymap_lua('n', '<leader>ql', "require('sharks.keymap').clear_quickfix()")
M.keymap_lua('n', '<leader>qt', "require('telescope.builtin').quickfix()")
M.keymap('n', '<leader>j', "<CMD>cnext<CR>")
M.keymap('n', '<leader>k', "<CMD>cprev<CR>")

-- Clear highlights
M.keymap('n', '<leader>l', "<CMD>nohl<CR>")

return M

