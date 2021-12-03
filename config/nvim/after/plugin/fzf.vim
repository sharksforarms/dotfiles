if executable('rg')
    let g:rg_derive_root='true'
endif

let $FZF_DEFAULT_OPTS='--reverse'
" default is alt+enter, but that's a default i3 binding
"let g:fzf_checkout_track_key = 'ctrl-t'
" Makes window popout in middle of screen
let g:fzf_layout = { 'window': { 'width': 0.8, 'height': 0.8 } }
