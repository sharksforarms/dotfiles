vim.cmd([[packadd packer.nvim]])

local packer_user_config = vim.api.nvim_create_augroup("PackerUserConfig", {})
vim.api.nvim_create_autocmd({ "BufWritePost" }, {
  group = packer_user_config,
  pattern = "plugins.lua",
  callback = function()
    vim.cmd([[ :source % | :PackerCompile ]])
    print("Done PackerCompile")
  end,
})

return require("packer").startup({
  function(use)
    use("lewis6991/impatient.nvim")
    use("wbthomason/packer.nvim")
    use("flazz/vim-colorschemes")
    use("norcalli/nvim-colorizer.lua")
    use("cespare/vim-toml")
    use("sainnhe/sonokai")
    use("rebelot/kanagawa.nvim")

    use("preservim/tagbar")
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
    use {
      'TimUntersberger/neogit',
      requires = {
        'nvim-lua/plenary.nvim',
        'sindrets/diffview.nvim'
      },
      config = function()
        require("neogit").setup({
          disable_commit_confirmation=true,
          disable_builtin_notifications=true,
          integrations = {
            diffview = true
          },
          sections = {
            untracked = {
              folded = true
            }
          },
        })
      end
    }
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
    use {
      "SmiteshP/nvim-navic",
      requires = "neovim/nvim-lspconfig"
    }
    use("nvim-treesitter/playground")
    use("mizlan/iswap.nvim")
    use("lspcontainers/lspcontainers.nvim")
    use({
      "williamboman/mason.nvim",
      config = function ()
       require("mason").setup()
      end
    })
    use("williamboman/mason-lspconfig.nvim")
    use("neovim/nvim-lspconfig")
    use("ryanoasis/vim-devicons")
    use("DaikyXendo/nvim-material-icon")
    use({
      "kyazdani42/nvim-web-devicons",
      config = function()
        require("trouble").setup()
        local web_devicons_ok, web_devicons = pcall(require, "nvim-web-devicons")
        if not web_devicons_ok then
          return
        end

        local material_icon_ok, material_icon = pcall(require, "nvim-material-icon")
        if not material_icon_ok then
          return
        end

        web_devicons.setup({
          override = material_icon.get_icons(),
        })
      end,
    })
    use({
      "folke/trouble.nvim",
      requires = "kyazdani42/nvim-web-devicons",
      config = function()
        require("trouble").setup()
      end,
    })
    use("p00f/clangd_extensions.nvim")
    use("simrat39/rust-tools.nvim")
    use({
      "glepnir/lspsaga.nvim",
      branch = "version_2.3",
    })
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
    use("jose-elias-alvarez/null-ls.nvim")
    use({
      'saecki/crates.nvim',
      requires = { 'nvim-lua/plenary.nvim', 'jose-elias-alvarez/null-ls.nvim' },
    })

    use {
      "NTBBloodbath/rest.nvim",
      requires = { "nvim-lua/plenary.nvim" },
      config = function()
        require("rest-nvim").setup({
          -- Open request results in a horizontal split
          result_split_horizontal = false,
          -- Keep the http file buffer above|left when split horizontal|vertical
          result_split_in_place = false,
          -- Skip SSL verification, useful for unknown certificates
          skip_ssl_verification = true,
          -- Encode URL before making request
          encode_url = true,
          -- Highlight request on run
          highlight = {
            enabled = true,
            timeout = 150,
          },
          result = {
            -- toggle showing URL, HTTP info, headers at top the of result window
            show_url = true,
            show_http_info = true,
            show_headers = true,
            -- executables or functions for formatting response body [optional]
            -- set them to nil if you want to disable them
            formatters = {
              json = "jq",
              html = function(body)
                return vim.fn.system({"tidy", "-i", "-q", "-"}, body)
              end
            },
          },
          -- Jump to request line on run
          jump_to_request = false,
          env_file = '.env',
          custom_dynamic_variables = {},
          yank_dry_run = true,
        })
      end
    }

    -- line completion
    use("tjdevries/complextras.nvim")

    -- Snippets
    -- use("norcalli/snippets.nvim")
    use("L3MON4D3/LuaSnip")
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
    use("mfussenegger/nvim-dap")
    use("theHamsta/nvim-dap-virtual-text")
    use({
      -- requires https://github.com/neovim/neovim/pull/15723
      "theHamsta/nvim-semantic-tokens",
      config = function()
        require("nvim-semantic-tokens").setup {
          preset = "default",
          -- highlighters is a list of modules following the interface of nvim-semantic-tokens.table-highlighter or
          -- function with the signature: highlight_token(ctx, token, highlight) where
          --        ctx (as defined in :h lsp-handler)
          --        token  (as defined in :h vim.lsp.semantic_tokens.on_full())
          --        highlight (a helper function that you can call (also multiple times) with the determined highlight group(s) as the only parameter)
          highlighters = { require 'nvim-semantic-tokens.table-highlighter'}
        }

        local semantic_tokens = require'nvim-semantic-tokens.table-highlighter'
        semantic_tokens.modifiers_map["unsafe"] = {
          ["function"] = "Identifier",
          keyword = "Identifier",
        }
      end,
    })
    use("rcarriga/nvim-dap-ui")
    use("mfussenegger/nvim-dap-python")
    -- using this to fix python identation, can probably remove in the fututre
    use({
      "yioneko/nvim-yati",
      requires = "nvim-treesitter/nvim-treesitter",
      ft = { "python" },
      config = function ()
        require("nvim-treesitter.configs").setup {
          yati = { enable = false },
        }
      end
    })
    use("Pocco81/DAPInstall.nvim")
    use("szw/vim-maximizer")
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
  end,
  config = {
    -- Move to lua dir so impatient.nvim can cache it
    compile_path = vim.fn.stdpath("config") .. "/plugin/packer_compiled.lua",
  },
})
