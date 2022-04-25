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

M.quickfix_toggle = function()
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
    vim.cmd([[ copen ]])
    local height = vim.o.previewheight
    api.nvim_win_set_height(0, height)
  end
end

M.quickfix_clear = function()
  vim.fn.setqflist({})
  vim.cmd([[ cclose ]])
end

local function trouble_is_open()
  local wins = vim.api.nvim_list_wins()
  for i, win in ipairs(wins) do
    local buf = vim.api.nvim_win_get_buf(win)
    local ft = vim.api.nvim_buf_get_option(buf, "filetype")
    if ft == "Trouble" then
      return true
    end
  end

  return false
end

M.qf_next = function()
  if trouble_is_open() then
    require("trouble").next({ skip_groups = true, jump = true })
  else
    -- loop over
    vim.cmd([[ try | cnext | catch | cfirst | catch | endtry ]])
  end
end

M.qf_prev = function()
  if trouble_is_open() then
    require("trouble").previous({ skip_groups = true, jump = true })
  else
    -- loop over
    vim.cmd([[ try | cprev | catch | clast | catch | endtry ]])
  end
end

-- Start keymaps

-- Quickfix actions
M.keymap("n", "<leader>qe", "<CMD>lua require('sharks.diagnostics').errors_to_quickfix()<CR><CMD>copen<CR>")
M.keymap("n", "<leader>qw", "<CMD>lua require('sharks.diagnostics').warnings_to_quickfix()<CR><CMD>copen<CR>")
M.keymap_lua("n", "<leader>qo", "require('sharks.keymap').quickfix_toggle()")
M.keymap_lua("n", "<leader>ql", "require('sharks.keymap').quickfix_clear()")
M.keymap_lua("n", "<leader>qt", "require('telescope.builtin').quickfix()")
M.keymap_lua("n", "<leader>j", "require('sharks.keymap').qf_next()")
M.keymap_lua("n", "<leader>k", "require('sharks.keymap').qf_prev()")
M.keymap("n", "<leader>tt", "<CMD>Trouble<CR>")

-- Clear highlights
M.keymap("n", "<leader>l", "<CMD>nohl<CR>")

-- tagbar
M.keymap("n", "<leader>to", "<CMD>TagbarToggle<CR>")

-- C development
M.keymap_lua("n", "mM", "vim.cmd(':Man 2 ' .. vim.fn.input('Man 2 > '))")
M.keymap("n", "<leader>cv", "<CMD>ClangdSwitchSourceHeaderVSplit<CR>")

M.keymap_lua("n", "<leader>$", "require('hop').hint_words()", {})

return M
