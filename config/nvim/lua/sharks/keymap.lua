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

-- START KEYMAPS --

-- Quickfix menu actions
vim.keymap.set("n", "<leader>qe", function()
  vim.diagnostic.setqflist({
    open = true,
    title = "Language Server (Errors)",
    severity = vim.diagnostic.severity.ERROR,
  })
end)

vim.keymap.set("n", "<leader>qw", function()
  vim.diagnostic.setqflist({
    open = true,
    title = "Language Server (Warnings)",
    severity = vim.diagnostic.severity.WARNING,
  })
end)

vim.keymap.set("n", "<leader>qo", M.quickfix_toggle)
vim.keymap.set("n", "<leader>ql", M.quickfix_clear)
vim.keymap.set("n", "<leader>qt", require('telescope.builtin').quickfix)
vim.keymap.set("n", "<leader>j", M.qf_next)
vim.keymap.set("n", "<leader>k", M.qf_prev)
vim.keymap.set("n", "<leader>tt", "<CMD>Trouble<CR>")


-- C development --
vim.keymap.set("n", "mM", "vim.cmd(':Man 2 ' .. vim.fn.input('Man 2 > '))")
vim.keymap.set("n", "<leader>cv", "<CMD>ClangdSwitchSourceHeaderVSplit<CR>")

-- General --
-- clear highlights
vim.keymap.set("n", "<leader>l", "<CMD>nohl<CR>")
-- shortcuts
vim.keymap.set("n", "<leader>ev", require('sharks.telescope').dotfiles)
vim.keymap.set("n", "<leader>ej", require('sharks.telescope').notes)
vim.keymap.set("n", "<leader>et", "<CMD>vsplit ~/TODO.md<CR>")
vim.keymap.set("n", "<leader>en", "<CMD>vsplit ~/NOTES.md<CR>")
-- move visual selection up/down
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")
-- select last inserted text
vim.keymap.set("n", "gV", "`[v`]")
-- previous tab
vim.keymap.set("n", "gr", "gT")
-- faster escape
vim.keymap.set("i", "jk", "<ESC>")
vim.keymap.set("i", "kj", "<ESC>")
-- jump to start and end of line
vim.keymap.set({ "n", "v" }, "H", "^")
vim.keymap.set({ "n", "v" }, "L", "$")
-- clipboard
vim.keymap.set({ "n", "v" }, "<leader>pp", '"+p')
vim.keymap.set({ "n", "v" }, "<leader>cc", '"+y')
-- terminal
vim.keymap.set("t", "<Esc>", '<C-\\><C-n>', { buffer = true })
-- no arrow keys >:)
vim.keymap.set({ "n", "v", "i" }, "<up>", "<NOP>")
vim.keymap.set({ "n", "v", "i" }, "<down>", "<NOP>")
vim.keymap.set({ "n", "v", "i" }, "<left>", "<NOP>")
vim.keymap.set({ "n", "v", "i" }, "<right>", "<NOP>")
-- external json format
vim.keymap.set("n", "<leader><leader>jq", ":%!python3 -m json.tool<CR>", { silent = true })

-- Plugin: tagbar
vim.keymap.set("n", "<leader>to", "<CMD>TagbarToggle<CR>")

-- Plugin: hop
vim.keymap.set("n", "<leader>$", require('hop').hint_words)


-- NOTES: (keymaps to remember)
-- g<c-g> -- show stats col/line/etc


return M
