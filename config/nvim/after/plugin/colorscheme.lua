-- Configure sonokai
vim.g.sonokai_style = "andromeda"
vim.g.sonokai_enable_italic = 1
vim.g.sonokai_cursor = "red"
vim.g.sonokai_transparent_background = 0
vim.g.sonokai_menu_selection_background = "green"
vim.g.sonokai_sign_column_background = "none"
vim.g.sonokai_diagnostic_line_highlight = 1
vim.g.sonokai_current_word = "grey background"
vim.g.sonokai_better_performance = 1

vim.opt.termguicolors = true
vim.cmd([[ colorscheme sonokai ]])

require("colorizer").setup()

vim.cmd([[
  hi! CursorLineNr cterm=bold guifg=#bb97ee guibg=#333645
  hi! CursorLine guibg=#333645
  "hi! link LineNr NonText
  hi! TabLineSel guibg=#77d5f0
  hi! Visual guifg=#23272e guibg=#77d5f0

  " Remove highlight from hover markdown menu, this is linked to `Visual` highlight
  " otherwise
  hi! link mkdLineBreak NONE

  " override git gutter highlight to respect diff
  " hi! link GitGutterAdd GreenSign
  " hi! link GitGutterDelete RedSign
  " hi! link GitGutterChange PurpleSign
  " hi! link GitGutterChangeDelete RedSign
  hi! TreesitterContext guibg=#3a3d4d
]])
