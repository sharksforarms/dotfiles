let g:firenvim_config = { 
    \ 'globalSettings': {
        \ 'alt': 'all',
    \  },
    \ 'localSettings': {
        \ '.*': {
            \ 'cmdline': 'neovim',
            \ 'priority': 0,
            \ 'selector': 'textarea',
            \ 'takeover': 'never',
        \ },
    \ }
\ }

function! s:IsFirenvimActive(event) abort
  if !exists('*nvim_get_chan_info')
    return 0
  endif
  let l:ui = nvim_get_chan_info(a:event.chan)
  return has_key(l:ui, 'client') && has_key(l:ui.client, 'name') &&
      \ l:ui.client.name =~? 'Firenvim'

endfunction

function! OnUIEnter(event) abort
  if s:IsFirenvimActive(a:event)
    " set lines=15
    set laststatus=0
    set wrap
    set linebreak
    au BufEnter github.com_*.txt set filetype=markdown
  endif
endfunction
autocmd UIEnter * call OnUIEnter(deepcopy(v:event))
