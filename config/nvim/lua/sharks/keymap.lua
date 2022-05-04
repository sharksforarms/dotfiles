local api = vim.api

local M = {}

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
vim.keymap.set("n", "<leader>qe", function()
  require('sharks.diagnostics').errors_to_quickfix()
  vim.cmd('copen')
end)
vim.keymap.set("n", "<leader>qw", function()
  require('sharks.diagnostics').warnings_to_quickfix()
  vim.cmd('copen')
end)
vim.keymap.set("n", "<leader>qo", require('sharks.keymap').quickfix_toggle())
vim.keymap.set("n", "<leader>ql", require('sharks.keymap').quickfix_clear())
vim.keymap.set("n", "<leader>qt", require('telescope.builtin').quickfix())
vim.keymap.set("n", "<leader>j", require('sharks.keymap').qf_next())
vim.keymap.set("n", "<leader>k", require('sharks.keymap').qf_prev())
vim.keymap.set("n", "<leader>tt", function()
  vim.cmd([[ Trouble<cr> ]])
end)

-- Clear highlights
vim.keymap.set("n", "<leader>l", "<CMD>nohl<CR>")

-- tagbar
vim.keymap.set("n", "<leader>to", "<CMD>TagbarToggle<CR>")

-- C development
vim.keymap.set("n", "mM", "vim.cmd(':Man 2 ' .. vim.fn.input('Man 2 > '))")
vim.keymap.set("n", "<leader>cv", "<CMD>ClangdSwitchSourceHeaderVSplit<CR>")

vim.keymap.set("n", "<leader>$", "require('hop').hint_words()")

return M
