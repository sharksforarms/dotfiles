"
" GENERAL
"

" Quickly edit/reload the vimrc file
" noremap <silent><leader>ev :lua require('sharks.telescope').dotfiles()<cr>
" noremap <silent><leader>ej :lua require('sharks.telescope').notes()<cr>
" noremap <silent><leader>et :vsplit ~/TODO.md<cr>
" noremap <silent><leader>en :vsplit ~/NOTES.md<cr>

" move visual selection up and down
" vnoremap J :m '>+1<CR>gv=gv
" vnoremap K :m '<-2<CR>gv=gv

" <leader>q shows stats
" nnoremap <leader>q g<c-g>

" select last inserted text
" nnoremap gV `[v`]

" previous tab
" nnoremap gr gT

" Faster escape
" inoremap jk <esc>
" inoremap kj <esc>
" inoremap <C-c> <esc>

" Jump to start and end of line using the home row keys
" map H ^
" map L $

" scroll and center
"nnoremap <silent> <c-d> <c-d>zz
"nnoremap <silent> <c-u> <c-u>zz

" X clipboard integration
" nnoremap <leader>pp "+p
" vnoremap <leader>pp "+p
" nnoremap <leader>cc "+y
" vnoremap <leader>cc "+y

" Terminal escape
au TermOpen * tnoremap <buffer> <Esc> <c-\><c-n>
" tnoremap <buffer> <Esc> <c-\><c-n>
au TermOpen * nnoremap <buffer> oo i<Up><CR><c-\><c-n>
au FileType fzf tunmap <buffer> <Esc>

" No arrow keys >:) --- force usage of the home row
" map <up> <nop>
" map <down> <nop>
" map <left> <nop>
" map <right> <nop>
" imap <up> <nop>
" imap <down> <nop>
" imap <left> <nop>
" imap <right> <nop>

" Alias
:command! WQ wq
:command! Wq wq
:command! W w
:command! Q q
:command! Qa qa

" JSON reformat
" noremap <silent><leader><leader>jq :%!python3 -m json.tool<cr>

"
" PLUGINS
"
"harpoon
nnoremap <silent><leader><leader>h :lua require("harpoon.mark").set_current_at(1)<CR>
nnoremap <silent><leader><leader>j :lua require("harpoon.mark").set_current_at(2)<CR>
nnoremap <silent><leader><leader>k :lua require("harpoon.mark").set_current_at(3)<CR>
nnoremap <silent><leader><leader>l :lua require("harpoon.mark").set_current_at(4)<CR>
nnoremap <silent><leader><CR>h :lua require("harpoon.ui").nav_file(1)<CR>
nnoremap <silent><leader><CR>j :lua require("harpoon.ui").nav_file(2)<CR>
nnoremap <silent><leader><CR>k :lua require("harpoon.ui").nav_file(3)<CR>
nnoremap <silent><leader><CR>l :lua require("harpoon.ui").nav_file(4)<CR>

" nnoremap <silent><leader><leader>t :lua require("harpoon.mark").toggle_file()<CR>
" nnoremap <silent><leader><leader>r :lua require("harpoon.mark").rm_file()<CR>
nnoremap <silent><leader><leader>o :lua require("harpoon.ui").toggle_quick_menu()<CR>

"telescope
:command! Keys lua require('telescope.builtin').keymaps()
:command! Highlights lua require('telescope.builtin').highlights()
:command! Fmt lua vim.lsp.buf.formatting_sync()
:command! Files lua require('sharks.telescope').find_all_files()

nnoremap <leader>ps <cmd>lua require('sharks.telescope').search()<CR>
nnoremap <silent><leader>tg <cmd>lua require'telescope.builtin'.live_grep{}<CR>
nnoremap <silent><leader>tp <cmd>lua require'telescope.builtin'.git_files{}<CR>
nnoremap <silent><C-p> <cmd>lua require'sharks.telescope'.find_files()<CR>
"nnoremap <silent><leader>ch <cmd>lua require('telescope.builtin').command_history{}<CR>
nnoremap <silent><leader>qf :lua require'telescope.builtin'.quickfix{}<CR>
nnoremap <silent><leader>gc    <cmd>lua require'telescope.builtin'.git_branches{}<CR>
nnoremap <leader>hc <cmd>lua require('sharks.telescope').h2o_configs()<CR>

" not really working:
nnoremap <silent><leader>fz <cmd>lua require('telescope.builtin').current_buffer_fuzzy_find{}<CR>

autocmd FileType toml nnoremap <silent> K :call <SID>show_documentation()<cr>
function! s:show_documentation()
    if (index(['vim','help'], &filetype) >= 0)
        execute 'h '.expand('<cword>')
    elseif ('Cargo.toml' == expand('%:t'))
        lua require('crates').show_versions_popup()
    else
        lua vim.lsp.buf.hover()
    endif
endfunction

nnoremap <leader>m :MaximizerToggle!<CR>

" nerdcommenter
nmap <silent> <C-_>   :lua require('Comment.api').toggle.linewise.current()<CR>
vmap <silent> <C-_>   :lua require("Comment.api").toggle.linewise(vim.fn.visualmode())<CR>

" fzf
nnoremap <Leader>pf :Files<CR>

" nerdtree
map <Leader>n <cmd>NERDTreeToggle<CR>

" FuGITive
" nmap <leader>gs :tab Neogit<CR>
nmap gh <Plug>(GitGutterPreviewHunk)
nmap <leader>gj <Plug>(GitGutterNextHunk)
nmap <leader>gk <Plug>(GitGutterPrevHunk)
" nnoremap <leader>grum :Git rebase upstream/master<CR>
" nnoremap <leader>grom :Git rebase origin/master<CR>

" vim-test
function! HarpoonStrategy(cmd)
  "call SendTerminalCommand(0, "cd " . getcwd() . " && " . a:cmd . "\n")
  call luaeval('require("harpoon.term").sendCommand(0, ' .. '"cd ' . getcwd() . ' && ' . a:cmd . '\n"' .. ')')
  call luaeval('require("harpoon.term").gotoTerminal(0)')
  normal! G
endfunction

let g:test#custom_strategies = {'harpoon': function('HarpoonStrategy')}
let g:test#strategy = 'harpoon'
"let test#strategy = "neovim"
nmap <silent> t<C-n> :TestNearest<CR>
nmap <silent> t<C-f> :TestFile<CR>
nmap <silent> t<C-s> :TestSuite<CR>
nmap <silent> t<C-l> :TestLast<CR>
nmap <silent> t<C-g> :TestVisit<CR>

function! <SID>SynStack()
  if !exists("*synstack")
      return
  endif
  echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunc

nmap <leader>hi :call <SID>SynStack()<CR>
