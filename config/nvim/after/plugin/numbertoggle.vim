function! NumberToggle()
  if(&number == 1)
    set nonumber
    set norelativenumber
  else
    set number
    set relativenumber
  endif
endfunc
nnoremap <F7> :call NumberToggle()<cr>
