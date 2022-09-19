vim.keymap.set("n", "<leader>to", "<CMD>TagbarToggle<CR>")

vim.g.tagbar_left = 0
vim.g.tagbar_left = 0
vim.g.tagbar_autofocus = 1
vim.g.tagbar_show_data_type = 1
vim.g.tagbar_compact = 1
vim.g.tagbar_autoshowtag = 1

vim.g.tagbar_type_go = {
  ctagstype = 'go',
  kinds = {
    'p:package',
    'f:function',
    'v:variables',
    't:type',
    'c:const'
  }
}
