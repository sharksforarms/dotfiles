vim.cmd([[packadd packer.nvim]])

vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerCompile
  augroup end
]])

return require("packer").startup({
  function(use)
    use("lewis6991/impatient.nvim")
    use("wbthomason/packer.nvim")
    use("flazz/vim-colorschemes")
    use("norcalli/nvim-colorizer.lua")
    use("cespare/vim-toml")
    use("sainnhe/sonokai")

    use("majutsushi/tagbar")
    use({
      "junegunn/fzf",
      run = function()
        vim.fn["fzf#install"]()
      end,
    })
    use("junegunn/fzf.vim")
    use("MattesGroeger/vim-bookmarks")
    use("preservim/nerdtree")
    use("jistr/vim-nerdtree-tabs")
    use("ThePrimeagen/harpoon")
    use({
      "phaazon/hop.nvim",
      config = function()
        require("hop").setup()
      end
    })
    use("tpope/vim-dispatch")
    use("tpope/vim-fugitive")
    use("airblade/vim-gitgutter")
    use("rhysd/git-messenger.vim")
    use({
      "ruifm/gitlinker.nvim",
      requires = "nvim-lua/plenary.nvim",
      config = function()
        require("gitlinker").setup({
          opts = {
            remote = nil,
            add_current_line_on_normal_mode = true,
            print_url = true,
          },
          mappings = "<leader>gy",
        })
      end,
    })
    use("pwntester/octo.nvim")
    use("mg979/vim-visual-multi")
    use("tpope/vim-repeat")
    use("tpope/vim-surround")
    use({
      "numToStr/Comment.nvim",
      config = function()
        require("Comment").setup()
      end,
    })
    use("AndrewRadev/splitjoin.vim")
    use("wellle/targets.vim")
    use("mbbill/undotree")
    use("tpope/vim-abolish")
    use("godlygeek/tabular")
    use("plasticboy/vim-markdown")
    use({
      -- "iamcco/markdown-preview.nvim",
      "Avimitin/markdown-preview.nvim",
      run = function()
        vim.cmd([[ call mkdp#util#install()" ]])
      end,
      config = function()
        vim.cmd [[
          "let $NVIM_MKDP_LOG_FILE = expand('~/mkdp-log.log')
          "let $NVIM_MKDP_LOG_LEVEL = 'debug'
        ]]
      end,
    })
    use("hrsh7th/nvim-cmp")
    use("hrsh7th/cmp-nvim-lsp")
    use("hrsh7th/cmp-vsnip")
    use("hrsh7th/cmp-path")
    use("hrsh7th/cmp-nvim-lua")
    use("hrsh7th/cmp-calc")
    use("hrsh7th/cmp-buffer")
    use("f3fora/cmp-spell")
    use("saadparwaiz1/cmp_luasnip")
    use({
      "rafamadriz/friendly-snippets",
      config = function()
        require("luasnip.loaders.from_vscode").lazy_load()
      end,
    })
    use("hrsh7th/vim-vsnip")
    use({ "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" })
    use("nvim-treesitter/nvim-treesitter-textobjects")
    use("RRethy/nvim-treesitter-textsubjects")
    use("romgrk/nvim-treesitter-context")
    use("nvim-treesitter/playground")
    use("mizlan/iswap.nvim")
    use("lspcontainers/lspcontainers.nvim")
    use("neovim/nvim-lspconfig")
    use({
      "folke/trouble.nvim",
      requires = "kyazdani42/nvim-web-devicons",
      config = function()
        require("trouble").setup()
      end,
    })
    use("p00f/clangd_extensions.nvim")
    use("simrat39/rust-tools.nvim")
    -- temporary until glepnir is back?
    use("tami5/lspsaga.nvim")
    use("nvim-lua/lsp-status.nvim")
    use({
      "j-hui/fidget.nvim",
      config = function()
        require("fidget").setup()
      end
    })
    use({
      "simrat39/symbols-outline.nvim",
      config = function()
        local symbols_outline_opts = {
          highlight_hovered_item = true,
          show_guides = true,
        }

        require("symbols-outline").setup(symbols_outline_opts)
      end,
    })
    use("ray-x/lsp_signature.nvim")
    use("camilledejoye/nvim-lsp-selection-range")

    -- line completion
    use("tjdevries/complextras.nvim")

    -- Snippets
    -- use("norcalli/snippets.nvim")
    use("L3MON4D3/LuaSnip")

    use("machakann/vim-highlightedyank")
    use({
      "aserowy/tmux.nvim",
      config = function()
        require("tmux").setup({
          -- overwrite default configuration
          -- here, e.g. to enable default bindings
          copy_sync = {
            -- TODO: Couldn't get this to work properly, not sure if I really want this anyway
            enable = false,
            sync_clipboard = false,
            sync_deletes = false,
            sync_unnamed = false,
          },
          navigation = {
            -- enables default keybindings (C-hjkl) for normal mode
            enable_default_keybindings = true,
          },
          resize = {
            -- enables default keybindings (A-hjkl) for normal mode
            enable_default_keybindings = true,
          },
        })
      end,
    })
    use("Saecki/crates.nvim")
    use("mfussenegger/nvim-dap")
    use("theHamsta/nvim-dap-virtual-text")
    use("rcarriga/nvim-dap-ui")
    use("mfussenegger/nvim-dap-python")
    use("Pocco81/DAPInstall.nvim")
    use("szw/vim-maximizer")
    use("benmills/vimux")
    use("jtdowney/vimux-cargo")
    use("vim-test/vim-test")
    use("nvim-lua/popup.nvim")
    use("nvim-lua/plenary.nvim")
    use("nvim-telescope/telescope.nvim")
    use("nvim-telescope/telescope-fzy-native.nvim")
    use("tami5/sql.nvim")
    use("nvim-telescope/telescope-ui-select.nvim")
    use("nvim-telescope/telescope-frecency.nvim")
    use("nvim-telescope/telescope-dap.nvim")
    --  use 'wincent/scalpel'
    --  use 'wincent/ferret'

    --  use 'ThePrimeagen/vim-apm.git'
    --  use 'ThePrimeagen/vim-be-good'

    -- Always load last
    use({
      "glacambre/firenvim",
      run = function()
        vim.fn["firenvim#install"](0)
      end,
    })
    use("ryanoasis/vim-devicons")
    use("kyazdani42/nvim-web-devicons")
  end,
  config = {
    -- Move to lua dir so impatient.nvim can cache it
    compile_path = vim.fn.stdpath("config") .. "/plugin/packer_compiled.lua",
  },
})
