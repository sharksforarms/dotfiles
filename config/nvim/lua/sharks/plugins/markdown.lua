return {
  {
    -- "iamcco/markdown-preview.nvim",
    "Avimitin/markdown-preview.nvim",
    build = function()
      vim.cmd([[ call mkdp#util#install()" ]])
    end,
    -- config = function()
      -- vim.cmd([[
      -- "let $NVIM_MKDP_LOG_FILE = expand('~/mkdp-log.log')
      -- "let $NVIM_MKDP_LOG_LEVEL = 'debug'
      -- ]])
    -- end,
  }
}
