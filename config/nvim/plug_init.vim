if ! filereadable(expand('~/.config/nvim/autoload/plug.vim'))
  echo "Downloading junegunn/vim-plug to manage plugins..."
  silent !mkdir -p ~/.config/nvim/autoload/
  silent !curl "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim" > ~/.config/nvim/autoload/plug.vim
  autocmd VimEnter * PlugInstall
endif

call plug#begin()

" Colors
"Plug 'git://github.com/arcticicestudio/nord-vim'
Plug 'git://github.com/flazz/vim-colorschemes.git'
Plug 'git://github.com/norcalli/nvim-colorizer.lua'
Plug 'git://github.com/cespare/vim-toml'

Plug 'git://github.com/sainnhe/sonokai'
let g:sonokai_style = 'andromeda'
let g:sonokai_enable_italic = 1
let g:sonokai_cursor = 'red'
let g:sonokai_transparent_background = 0
let g:sonokai_menu_selection_background = 'green'
let g:sonokai_sign_column_background = 'none'
let g:sonokai_diagnostic_line_highlight = 1
let g:sonokai_current_word = 'grey background'
let g:sonokai_better_performance = 1

Plug 'git://github.com/sainnhe/edge'
let g:edge_style = 'neon'
let g:edge_enable_italic = 1
let g:edge_cursor = 'auto'
let g:edge_menu_selection_background = 'purple'
let g:edge_diagnostic_text_highlight = 1
let g:edge_diagnostic_line_highlight = 1

" Bars
Plug 'git://github.com/majutsushi/tagbar'

" Navigation
Plug 'git://github.com/junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'git://github.com/junegunn/fzf.vim'
Plug 'git://github.com/MattesGroeger/vim-bookmarks'
Plug 'git://github.com/preservim/nerdtree'
Plug 'git://github.com/jistr/vim-nerdtree-tabs'
"Plug 'git://github.com/ms-jpq/chadtree'
Plug 'git://github.com/ThePrimeagen/harpoon'
Plug 'git://github.com/phaazon/hop.nvim'
Plug 'git://github.com/tpope/vim-dispatch'

" Git
Plug 'git://github.com/tpope/vim-fugitive'
Plug 'git://github.com/airblade/vim-gitgutter'
Plug 'git://github.com/rhysd/git-messenger.vim'
Plug 'git://github.com/pwntester/octo.nvim'

" Text manipulation
Plug 'git://github.com/mg979/vim-visual-multi'
Plug 'git://github.com/tpope/vim-repeat'
Plug 'git://github.com/tpope/vim-surround'
let g:NERDCreateDefaultMappings = 0
Plug 'git://github.com/scrooloose/nerdcommenter'
Plug 'git://github.com/AndrewRadev/splitjoin.vim'
Plug 'git://github.com/wellle/targets.vim'
Plug 'git://github.com/mbbill/undotree'
Plug 'git://github.com/tpope/vim-abolish.git'

" Markdown
Plug 'git://github.com/godlygeek/tabular'
Plug 'git://github.com/plasticboy/vim-markdown'
Plug 'git://github.com/iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}

" LSP and Autocompletion
"Plug 'git://github.com/hrsh7th/nvim-compe'
Plug 'git://github.com/hrsh7th/nvim-cmp'
Plug 'git://github.com/hrsh7th/cmp-nvim-lsp'
Plug 'git://github.com/hrsh7th/cmp-vsnip'
Plug 'git://github.com/hrsh7th/cmp-path'
Plug 'git://github.com/hrsh7th/cmp-nvim-lua'
Plug 'git://github.com/hrsh7th/cmp-calc'
Plug 'git://github.com/hrsh7th/cmp-buffer'
Plug 'git://github.com/f3fora/cmp-spell'
Plug 'git://github.com/saadparwaiz1/cmp_luasnip'

Plug 'git://github.com/hrsh7th/vim-vsnip'
Plug 'git://github.com/nvim-treesitter/nvim-treesitter-textobjects'
Plug 'git://github.com/RRethy/nvim-treesitter-textsubjects'
Plug 'git://github.com/romgrk/nvim-treesitter-context'
Plug 'git://github.com/nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'git://github.com/nvim-treesitter/playground'
Plug 'git://github.com/mizlan/iswap.nvim'
Plug 'git://github.com/lspcontainers/lspcontainers.nvim'
Plug 'git://github.com/neovim/nvim-lspconfig'
Plug 'git://github.com/simrat39/rust-tools.nvim'
"Plug 'git://github.com/glepnir/lspsaga.nvim'
" temporary until glepnir is back?
Plug 'git://github.com/tami5/lspsaga.nvim'
Plug 'git://github.com/nvim-lua/lsp-status.nvim'
Plug 'git://github.com/simrat39/symbols-outline.nvim'
Plug 'git://github.com/ray-x/lsp_signature.nvim'

" line completion
Plug 'git://github.com/tjdevries/complextras.nvim'

" Snippets
Plug 'git://github.com/norcalli/snippets.nvim'
Plug 'git://github.com/L3MON4D3/LuaSnip'

" Misc
Plug 'git://github.com/machakann/vim-highlightedyank'
Plug 'git://github.com/christoomey/vim-tmux-navigator'
Plug 'git://github.com/Saecki/crates.nvim'
Plug 'git://github.com/puremourning/vimspector.git'
Plug 'git://github.com/sharksforarms/vimspector-gen.git'
Plug 'git://github.com/mfussenegger/nvim-dap'
Plug 'git://github.com/theHamsta/nvim-dap-virtual-text'
Plug 'git://github.com/rcarriga/nvim-dap-ui'
Plug 'git://github.com/mfussenegger/nvim-dap-python'
Plug 'git://github.com/Pocco81/DAPInstall.nvim'
Plug 'git://github.com/szw/vim-maximizer'
Plug 'git://github.com/benmills/vimux'
Plug 'git://github.com/jtdowney/vimux-cargo'
Plug 'git://github.com/vim-test/vim-test'

" Telescope
Plug 'git://github.com/nvim-lua/popup.nvim'
Plug 'git://github.com/nvim-lua/plenary.nvim'
Plug 'git://github.com/nvim-telescope/telescope.nvim'
Plug 'git://github.com/nvim-telescope/telescope-fzy-native.nvim'
Plug 'git://github.com/tami5/sql.nvim'
Plug 'git://github.com/nvim-telescope/telescope-frecency.nvim'
Plug 'git://github.com/sharksforarms/telescope-vimspector.nvim'

"Plug 'git://github.com/wincent/scalpel'
"Plug 'git://github.com/wincent/ferret'

"Plug 'git://github.com/ThePrimeagen/vim-apm.git'
"Plug 'git://github.com/ThePrimeagen/vim-be-good'

" Always load last
Plug 'git://github.com/glacambre/firenvim', { 'do': { _ -> firenvim#install(0) } }
Plug 'git://github.com/ryanoasis/vim-devicons'
Plug 'git://github.com/kyazdani42/nvim-web-devicons'

call plug#end()
