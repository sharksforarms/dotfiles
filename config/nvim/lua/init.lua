require('colorizer').setup()
require('sharks.cmp')
require('sharks.diagnostics')
require('sharks.hop')
require('sharks.keymap')
require('sharks.lsp_config')
require('sharks.snippets')
require('sharks.telescope').setup()
require('sharks.treesitter')
require('sharks.statusline').setup()
require('sharks.dap')

RELOAD = require('plenary.reload').reload_module

R = function(name)
  RELOAD(name)
  return require(name)
end

P = function(v)
  print(vim.inspect(v))
  return v
end
