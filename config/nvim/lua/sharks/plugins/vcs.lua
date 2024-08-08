return {
  "tpope/vim-fugitive",
  "rhysd/git-messenger.vim",
  "airblade/vim-gitgutter",
  {
    'pwntester/octo.nvim',
    requires = {
      'nvim-lua/plenary.nvim',
      'nvim-telescope/telescope.nvim',
      -- OR 'ibhagwan/fzf-lua',
      'nvim-tree/nvim-web-devicons',
    },
    config = function ()
      -- require"octo".setup()
    end
  },
  {
    "linrongbin16/gitlinker.nvim",
    cmd = "GitLink",
    opts = {},
    keys = {
      { "<leader>gy", "<cmd>GitLink<cr>", mode = { "n", "v" }, desc = "Yank git link" },
      { "<leader>gY", "<cmd>GitLink!<cr>", mode = { "n", "v" }, desc = "Open git link" },
    },
  },
  {
    "sindrets/diffview.nvim",
    cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewToggleFiles", "DiffviewFocusFiles" },
  },
  {
    "TimUntersberger/neogit",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim",
      "sindrets/diffview.nvim",
      "ibhagwan/fzf-lua",
    },
    branch = "master",
    config = function()
      require("neogit").setup({
        disable_commit_confirmation = true,
        disable_builtin_notifications = true,
        integrations = {
          diffview = true,
        },
        sections = {
          untracked = {
            folded = true,
          },
        },
      })

      -- set colorcolumn to 50 and 72 to represent max title and body
      local augroup = vim.api.nvim_create_augroup("NeogitCC", {})
      vim.api.nvim_create_autocmd({ "FileType" }, {
        group = augroup,
        pattern = "NeogitCommitMessage",
        callback = function()
          vim.wo.colorcolumn = "50,72"
        end,
      })
    end,
  }
}
