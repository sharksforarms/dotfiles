local opt = vim.opt
--" Do not display messages like "Pattern not found"
--" This made it compete with the mode and flicker
opt.shortmess = opt.shortmess + "c"

--" disable python2
--let g:loaded_python_provider = 0
--" set python3 host path (fixes issues in virtualenv)
--let g:python3_host_prog = '/usr/bin/python3'

-- Ignore compiled files
opt.wildignore = "__pycache__"
opt.wildignore = opt.wildignore + { "*.o", "*~", "*.pyc", "*pycache*" }

-- number of visual spaces per tab
opt.tabstop = 4
-- number of indent using >> and <<
opt.shiftwidth = 4
-- number of spaces in a tab when editing
opt.softtabstop = 4
-- tabs are spaces
opt.expandtab = true
-- auto indent when editing
opt.autoindent = true
-- don't wrap
opt.wrap = false
-- <tab>/<BS> indent/dedent in leading whitespace
opt.smarttab = true
opt.smartindent = true

-- Give more space for displaying messages.
opt.cmdheight = 2

-- Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
-- delays and poor user experience.
opt.updatetime = 100

-- Reduce screen flicker when scrolling fast
--opt.lazyredraw

--opt.spell " spelling
vim.cmd([[ au TermOpen * setlocal nospell ]])

-- General config
-- show line numbers
opt.number = true
-- show relative numbers in gutter
opt.relativenumber = true
-- start scrolling x lines before edge of viewport
opt.scrolloff = 10
-- same as scrolloff, but for columns
opt.sidescrolloff = 5
-- show information in visual select, show cmd info
opt.showcmd = true
-- highlight matching brackets
opt.showmatch = true
-- highlight current line
opt.cursorline = true
-- display cursor position
opt.ruler = true
-- display status line
opt.laststatus = 2
-- raise dialog to save changed files
opt.confirm = true
-- switch buffers without needing to save
opt.hidden = true
-- turn off bell
opt.belloff = "all"
-- command window height
opt.cmdheight = 1
-- toggle paste mode
opt.pastetoggle = "<F10>"
-- show whitespace
opt.list = true
opt.listchars = {
  -- CIRCLED REVERSE SOLIDUS (U+29B8, UTF-8: E2 A6 B8)
  nbsp = "⦸",
  -- WHITE RIGHT-POINTING TRIANGLE (U+25B7, UTF-8: E2 96 B7)
  -- + BOX DRAWINGS HEAVY TRIPLE DASH HORIZONTAL (U+2505, UTF-8: E2 94 85)
  tab = "▷┅",
  -- RIGHT-POINTING DOUBLE ANGLE QUOTATION MARK (U+00BB, UTF-8: C2 BB)
  extends = "»",
  -- LEFT-POINTING DOUBLE ANGLE QUOTATION MARK (U+00AB, UTF-8: C2 AB)
  precedes = "«",
  -- BULLET (U+2022, UTF-8: E2 80 A2)
  trail = "•",
}
--opt.mouse-=a
opt.splitright = true
opt.splitbelow = true
vim.wo.colorcolumn = "80"
-- avoid vertical jitter when diagnostics come in
vim.wo.signcolumn = "yes"

-- Searching
-- hilight matches
opt.hlsearch = true
-- ignore case
opt.ignorecase = true
-- case insensitive, except when using uppercase chars
opt.smartcase = true
-- incremental search off
--opt.noincsearch

-- opt.formatoptions = opt.formatoptions
--   - "a" -- Auto formatting is BAD.
--   - "t" -- Don't auto format my code. I got linters for that.
--   + "c" -- In general, I like it when comments respect textwidth
--   + "q" -- Allow formatting comments w/ gq
--   - "o" -- O and o, don't continue comments
--   + "r" -- But do continue when pressing enter.
--   + "n" -- Indent past the formatlistpat, not underneath it.
--   + "j" -- Auto-remove comments if possible.
--   - "2" -- I'm not in gradeschool anymore
--
vim.api.nvim_exec(
  [[
  augroup NoAutoComment
    au!
    au FileType * setlocal formatoptions-=ro
  augroup end
]],
  false
)

-- Disable backup files
opt.backup = false
opt.swapfile = false

-- Undo history
opt.undodir = vim.fn.stdpath("data") .. "/undodir"
opt.undofile = true

-- Profiling
--profile start freezing_debug.txt
--profile func *
--profile file *
vim.cmd([[
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
]])
