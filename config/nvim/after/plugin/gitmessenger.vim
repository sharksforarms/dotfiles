nmap <leader>gm <Plug>(git-messenger)

function! s:setup_git_messenger_popup() abort
  call nvim_win_set_option(0, 'winhl', 'Normal:NormalFloat')

  nmap <buffer><esc> q
  nmap <buffer><C-o> o
  nmap <buffer><C-i> O
endfunction

augroup MyGitMessenger
  au!
  autocmd FileType gitmessengerpopup call <SID>setup_git_messenger_popup()
augroup END
