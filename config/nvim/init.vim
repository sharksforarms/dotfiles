let mapleader="\<Space>"

set exrc
set secure

" Get plugins
source $HOME/.config/nvim/plug_init.vim

if exists('+termguicolors')
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
  set termguicolors
endif

lua << EOF
    package.loaded['init'] = nil
    require('init')
EOF

" Colors
colorscheme sonokai

lua require('nvim-web-devicons').setup()
