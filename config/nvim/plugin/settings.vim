filetype plugin indent on
syntax on

set exrc
"set secure

" Do not display messages like "Pattern not found"
" This made it compete with the mode and flicker
set shortmess+=c

" Use ripgrep as grep tool
set grepprg=rg\ --vimgrep\ --no-heading\ --smart-case
set grepformat=%f:%l:%c:%m,%f:%l:%m

" disable python2
let g:loaded_python_provider = 0
" set python3 host path (fixes issues in virtualenv)
let g:python3_host_prog = '/usr/bin/python3'

" Tab/indent config
set tabstop=4 " number of visual spaces per tab
set shiftwidth=4 " number of indent using >> and <<
set softtabstop=4 " number of spaces in a tab when editing
set expandtab " tabs are spaces
set autoindent " auto indent when editing
set nowrap " don't wrap
set smarttab " <tab>/<BS> indent/dedent in leading whitespace
set smartindent

" Give more space for displaying messages.
set cmdheight=2

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=100

" Reduce screen flicker when scrolling fast
"set lazyredraw

"set spell " spelling
au TermOpen * setlocal nospell

" General config
set number " show line numbers
set relativenumber " show relative numbers in gutter
set scrolloff=10 " start scrolling x lines before edge of viewport
set sidescrolloff=5 " same as scrolloff, but for columns
set showcmd " show information in visual select, show cmd info
set showmatch " highlight matching brackets
set cursorline " highlight current line
set ruler " display cursor position
set laststatus=2 " display status line
set confirm " raise dialog to save changed files
set hidden " switch buffers without needing to save
set visualbell t_vb= " no visual bell
set novisualbell " instead of the anoying sound
set cmdheight=1 " command window height
set pastetoggle=<F10> " toggle paste mode
set list " show whitespace
set listchars=nbsp:⦸ " CIRCLED REVERSE SOLIDUS (U+29B8, UTF-8: E2 A6 B8)
set listchars+=tab:▷┅ " WHITE RIGHT-POINTING TRIANGLE (U+25B7, UTF-8: E2 96 B7)
                      " + BOX DRAWINGS HEAVY TRIPLE DASH HORIZONTAL (U+2505, UTF-8: E2 94 85)
set listchars+=extends:»  " RIGHT-POINTING DOUBLE ANGLE QUOTATION MARK (U+00BB, UTF-8: C2 BB)
set listchars+=precedes:« " LEFT-POINTING DOUBLE ANGLE QUOTATION MARK (U+00AB, UTF-8: C2 AB)
set listchars+=trail:•    " BULLET (U+2022, UTF-8: E2 80 A2)
set mouse-=a
set splitright
set splitbelow
set colorcolumn=80
set signcolumn=yes " avoid vertical jitter when diagnostics come in

" Searching
set hlsearch " hilight matches
set ignorecase " ignore case
set smartcase " case insensitive, except when using uppercase chars
"set noincsearch " incremental search off
autocmd BufNewFile,BufRead * setlocal formatoptions-=cro " disable auto-wrap comments

" Disable backup files
set nobackup
set noswapfile

" Undo history
set undodir=~/.config/nvim.tmp.undo/
set undofile

" Profiling
"profile start freezing_debug.txt
"profile func *
"profile file *
function! InvertArgs()
    " Get the arguments of the current line (remove the spaces)
    let args=substitute(matchstr(getline('.'), '\[\zs.*\ze\]'), '\s', '', 'g')

    " Split the arguments as a list and reverse the list
    let argsList=split(args, ',')
    call reverse(argsList)

    " Join the reversed list with a comma and a space separing the arguments
    let invertedArgs=join(argsList, ', ')

    " Remove the old arguments and put the new list
    execute "normal! 0f[ci[" . invertedArgs
endfunction
