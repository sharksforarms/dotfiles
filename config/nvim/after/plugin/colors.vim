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
