return {
  "norcalli/nvim-colorizer.lua",
  "cespare/vim-toml",
  "plasticboy/vim-markdown",
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate"
  },
  "nvim-treesitter/playground",
  "nvim-treesitter/nvim-treesitter-textobjects",
  "RRethy/nvim-treesitter-textsubjects",
  "romgrk/nvim-treesitter-context",
  {
    "hiphish/rainbow-delimiters.nvim",
    config = function()
      local rainbow_delimiters = require('rainbow-delimiters')

      require('rainbow-delimiters.setup').setup {
        strategy = {
          [''] = rainbow_delimiters.strategy['global'],
          vim = rainbow_delimiters.strategy['local'],
        },
        query = {
          [''] = 'rainbow-delimiters',
          lua = 'rainbow-blocks',
        },
        highlight = {
          'RainbowDelimiterRed',
          'RainbowDelimiterYellow',
          'RainbowDelimiterBlue',
          'RainbowDelimiterOrange',
          'RainbowDelimiterGreen',
          'RainbowDelimiterViolet',
          'RainbowDelimiterCyan',
        },
      }
    end
  }
}
