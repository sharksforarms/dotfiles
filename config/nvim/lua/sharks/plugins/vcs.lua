return {
  "tpope/vim-fugitive",
  "rhysd/git-messenger.vim",
  "airblade/vim-gitgutter",
  "pwntester/octo.nvim",
  {
    "ruifm/gitlinker.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
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
