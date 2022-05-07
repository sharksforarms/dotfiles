pcall(require, "impatient")
-- require'impatient'.enable_profile()

if require("sharks.first_load")() then
  return
end

-- Leader Key
vim.g.mapleader = " "

require("sharks.globals")
require("sharks.keymap")
require("sharks.lsp")
require("sharks.telescope").setup()
require("sharks.statusline").setup()
