fun! Func_StripTrailingWhitespaces()
    let l:save = winsaveview()
    keeppatterns %s/\s\+$//e
    call winrestview(l:save)
endfun

:command! StripTrailingWhitespaces :call Func_StripTrailingWhitespaces()
