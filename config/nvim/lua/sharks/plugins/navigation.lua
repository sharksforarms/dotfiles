return {
  "preservim/tagbar",
  "liuchengxu/vista.vim",
  "MattesGroeger/vim-bookmarks",
  "preservim/nerdtree",
  "jistr/vim-nerdtree-tabs",
  "ThePrimeagen/harpoon",
  {
    "phaazon/hop.nvim",
    config = function()
      require("hop").setup()
    end,
  },
  "mbbill/undotree",
  {
    "nvim-telescope/telescope.nvim",
    priority = 100,
    config = function()
      require("sharks.telescope").setup()
    end,
  },
  { 'nvim-telescope/telescope-fzf-native.nvim', build = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build' },
  "nvim-telescope/telescope-ui-select.nvim",
  {
    "nvim-telescope/telescope-frecency.nvim",
  },
  {
    "stevearc/oil.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("oil").setup {
        columns = { "icon" },
        keymaps = {
          ["<C-h>"] = false,
          ["<M-h>"] = "actions.select_split",
        },
        view_options = {
          show_hidden = true,
        },
      }

      -- Open parent directory in current window
      vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })

      -- Open parent directory in floating window
      vim.keymap.set("n", "<space>-", require("oil").toggle_float)
    end,
  },
}
