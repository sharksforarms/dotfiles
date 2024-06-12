-- misc/utils
return {
  "szw/vim-maximizer",
  {
    "glacambre/firenvim",
    build = function()
      vim.fn["firenvim#install"](0)
    end,
  },
}
