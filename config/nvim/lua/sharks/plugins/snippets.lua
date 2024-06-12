return {
  "L3MON4D3/LuaSnip",
  "hrsh7th/vim-vsnip",
  {
    "rafamadriz/friendly-snippets",
    config = function()
      require("luasnip.loaders.from_vscode").lazy_load()
    end,
  },
}
