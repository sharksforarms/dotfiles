return {
  "nvim-lua/lsp-status.nvim",
  "ray-x/lsp_signature.nvim",
  "camilledejoye/nvim-lsp-selection-range",
  {
    'stevearc/conform.nvim',
    opts = {},
    config = function()
      require("conform").setup({
        formatters_by_ft = {
          lua = { "stylua" },
          -- Conform will run multiple formatters sequentially
          -- python = { "isort", "black" },
          -- Use a sub-list to run only the first available formatter
          -- javascript = { { "prettierd", "prettier" } },
        },
      })
    end
  },
  {
    "SmiteshP/nvim-navic",
    dependencies = {
      "neovim/nvim-lspconfig"
    },
  },
  "lspcontainers/lspcontainers.nvim",
  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup()
    end,
  },
  "williamboman/mason-lspconfig.nvim",
  "neovim/nvim-lspconfig",
  {
    "folke/trouble.nvim",
    dependencies = "kyazdani42/nvim-web-devicons",
    config = function()
      require("trouble").setup()
    end,
  },
  {
    "nvimdev/lspsaga.nvim",
    dependencies = "nvim-lspconfig",
    -- config = function()
      --   require("lspsaga").setup({})
      -- end,
  },
  {
    "j-hui/fidget.nvim",
    tag = "legacy", -- TODO update
    config = function()
      require("fidget").setup()
    end,
  },
  {
    "hedyhli/outline.nvim",
    config = function()
      local outline_opts = {
        guides = {
          enabled = true
        },
        outline_items = {
          highlight_hovered_item = true
        }
      }

      require("outline").setup(outline_opts)
    end,
  },

  -- Rust
  {
    'nvimtools/none-ls.nvim',
    config = function()
      require("null-ls").setup()
    end,
  },
  {
    'saecki/crates.nvim',
    tag = 'stable',
    config = function()
      require('crates').setup({
        null_ls = {
          enabled = true,
          name = "Crates"
        }
      })
    end,
  },
  {
    'mrcjkb/rustaceanvim',
    ft = { 'rust' },
  },
  -- C/C++
  "p00f/clangd_extensions.nvim",
}
