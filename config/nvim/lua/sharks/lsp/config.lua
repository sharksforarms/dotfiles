
local M = {}
local init_keymaps;

M.init = function()
  local saga = require("lspsaga")
  saga.setup({
    finder_action_keys = {
      open = "<CR>",
      vsplit = "v",
      split = "s",
      quit = "<ESC>",
      scroll_down = "<C-d>",
      scroll_up = "<C-u>",
    },
    rename_action_quit = '<ESC>',
    rename_in_select = false,
    code_action_keys = { quit = "<ESC>", exec = "<CR>" },
    lightbulb = {
      enable = false,
    },
    symbol_in_winbar = {
      enable = false,
    },
    -- ui = {
    --   code_action = '',
    -- }
    -- code_action_prompt = {
    --   enable = false,
    --   sign = false,
    --   sign_priority = 20,
    --   virtual_text = false,
    -- },
    border_style = "single",
  })

  local cfg = {
    bind = true,
    doc_lines = 2,
    hint_enable = true,
    hint_prefix = " ",
    hint_scheme = "String",
    use_lspsaga = true,
    handler_opts = {
      border = "none",
    },
    decorator = { "`", "`" },
    debug=true,
  }

  require("lsp_signature").on_attach(cfg)

  init_keymaps()
end

-- Code actions
M.code_action = function()
  -- vim.cmd("Lspsaga code_action")
  -- require("telescope.builtin").lsp_code_actions()
  vim.lsp.buf.code_action()
end

-- Code lens
M.code_lens = function()
  -- TODO: if on function, run, else goto function def using treesitter then run
  -- TODO: or if outside of function, show all runables
  vim.lsp.codelens.run()
end

-- Symbols
M.symbol_rename = function()
  vim.lsp.buf.rename()
  -- vim.cmd("Lspsaga rename")
end

M.symbol_definition = function()
  vim.lsp.buf.definition()
end

M.symbol_implementation = function()
  vim.lsp.buf.implementation()
end

M.symbol_type = function()
  vim.lsp.buf.type_definition()
end

M.symbol_references = function()
  require("telescope.builtin").lsp_references(require("telescope.themes").get_dropdown({}))
  -- require("lspsaga.provider"):lsp_finder()
end

M.symbol_document = function()
  require("telescope.builtin").lsp_document_symbols()
end

M.symbol_workspace = function()
  require("telescope.builtin").lsp_dynamic_workspace_symbols()
end

M.symbol_preview = function()
  vim.cmd("Lspsaga peek_definition")
end

-- Docs
M.doc_hover = function()
  --vim.lsp.buf.hover()
  if vim.bo.filetype == "rust" then
    require("rust-tools.hover_actions").hover_actions()
  else
    vim.cmd("Lspsaga hover_doc")
  end
end

-- Diagnostic
M.diagnostic_preview = function()
  -- if we have documentation hover, don't show diagnostics
  if require("rust-tools.hover_actions")._state.winnr ~= nil then
    if vim.api.nvim_win_is_valid(require("rust-tools.hover_actions")._state.winnr) then
      return
    end
  end

  -- if we have documentation hover, don't show diagnostics
  -- if require("lspsaga.hover").is_open() then
  --   return
  -- end
  --
  vim.diagnostic.open_float(nil, { focusable = false })
  -- require('lspsaga.diagnostic').show_line_diagnostics()
end

local goto_opts = {
  wrap = true,
  float = true,
}

M.diagnostic_next = function()
  vim.diagnostic.goto_next(goto_opts)
  --require('lspsaga.diagnostic').navigate("next")()
end

M.diagnostic_prev = function()
  vim.diagnostic.goto_prev(goto_opts)
  --require('lspsaga.diagnostic').navigate("prev")()
end

function init_keymaps()
  -- Formatting
  vim.keymap.set("n", "<leader>=", vim.lsp.buf.format)


  -- Code action
  vim.keymap.set("n", "ga", require('sharks.lsp.config').code_action)
  vim.keymap.set("v", "ga", require('sharks.lsp.config').code_action)
  vim.keymap.set("n", "gs", require('sharks.lsp.config').code_lens)

  -- Symbols
  vim.keymap.set("n", "gn", require('sharks.lsp.config').symbol_rename)
  vim.keymap.set("n", "gd", require('sharks.lsp.config').symbol_definition)
  vim.keymap.set("n", "gp", require('sharks.lsp.config').symbol_preview)
  vim.keymap.set("n", "<C+]>", require('sharks.lsp.config').symbol_definition)
  vim.keymap.set("n", "gD", require('sharks.lsp.config').symbol_implementation)
  vim.keymap.set("n", "gT", require('sharks.lsp.config').symbol_type)
  vim.keymap.set("n", "gR", require('sharks.lsp.config').symbol_references)
  vim.keymap.set("n", "g0", require('sharks.lsp.config').symbol_document)
  vim.keymap.set("n", "gW", require('sharks.lsp.config').symbol_workspace)

  -- Docs
  vim.keymap.set("n", "K", require('sharks.lsp.config').doc_hover)

  -- Diagnostic
  vim.cmd([[
    autocmd CursorHold * :lua require('sharks.lsp.config').diagnostic_preview()
  ]])
  vim.keymap.set("n", "<leader>dj", require('sharks.lsp.config').diagnostic_next)
  vim.keymap.set("n", "<leader>dk", require('sharks.lsp.config').diagnostic_prev)

  vim.cmd("hi FloatBorder guifg=#777777")
  vim.cmd("hi LspSagaDiagnosticBorder guifg=#7e8294")
  vim.cmd("hi LspSagaDiagnosticTruncateLine guifg=#7e8294")
end

return M
