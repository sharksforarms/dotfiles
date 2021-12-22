local saga = require("lspsaga")
local keymap = require("sharks.keymap").keymap
local keymap_lua = require("sharks.keymap").keymap_lua

local M = {}

M.init = function()
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
  }

  require("lsp_signature").on_attach(cfg)

  saga.init_lsp_saga({
    use_saga_diagnostic_sign = false,
    finder_action_keys = {
      open = "<CR>",
      vsplit = "v",
      split = "s",
      quit = "<ESC>",
      scroll_down = "<C-d>",
      scroll_up = "<C-u>",
    },
    code_action_keys = { quit = "<ESC>", exec = "<CR>" },
    rename_action_keys = {
      quit = "<ESC>",
      exec = "<CR>",
    },
    code_action_icon = "",
    code_action_prompt = {
      enable = false,
      sign = false,
      sign_priority = 20,
      virtual_text = false,
    },
    border_style = "single",
  })

  init_keymaps()
end

-- Code actions
M.code_action = function()
  --require('lspsaga.codeaction').code_action()
  --require('telescope.builtin').lsp_code_actions()
  vim.lsp.buf.code_action()
end

M.code_action_range = function()
  require("lspsaga.codeaction").range_code_action()
end

-- Symbols
M.symbol_rename = function()
  --vim.lsp.buf.rename()
  require("lspsaga.rename").rename()
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
  --require'lspsaga.provider'.lsp_finder()
end

M.symbol_document = function()
  require("telescope.builtin").lsp_document_symbols()
end

M.symbol_workspace = function()
  require("telescope.builtin").lsp_dynamic_workspace_symbols()
end

M.symbol_preview = function()
  require("lspsaga.provider").preview_definition()
end

-- Docs
M.doc_hover = function()
  --vim.lsp.buf.hover()
  if vim.bo.filetype == "rust" then
    require("rust-tools.hover_actions").hover_actions()
  else
    require("lspsaga.hover").render_hover_doc()
  end
end

M.doc_scroll_down = function(default_key)
  if require("lspsaga.hover").has_saga_hover() then
    require("lspsaga.action").smart_scroll_with_saga(1)
  else
    local key = vim.api.nvim_replace_termcodes(default_key, true, false, true)
    vim.api.nvim_feedkeys(key, "n", true)
  end
end

M.doc_scroll_up = function(default_key)
  if require("lspsaga.hover").has_saga_hover() then
    require("lspsaga.action").smart_scroll_with_saga(-1)
  else
    local key = vim.api.nvim_replace_termcodes(default_key, true, false, true)
    vim.api.nvim_feedkeys(key, "n", true)
  end
end

M.doc_signature = function()
  --vim.lsp.buf.signature_help()
  require("lspsaga.signaturehelp").signature_help()
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
  if require("lspsaga.hover").has_saga_hover() then
    return
  end

  vim.diagnostic.open_float(nil, { focusable = false })
  --require('lspsaga.diagnostic').show_line_diagnostics()
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
  keymap_lua("n", "<leader>=", "vim.lsp.buf.formatting_sync()")

  -- Code action
  keymap_lua("n", "ga", "require('sharks.lsp.config').code_action()")
  keymap("v", "ga", "<cmd>'<,'>lua require('sharks.lsp.config').code_action_range()<CR>")
  keymap("x", "ga", "<cmd>'<,'>lua require('sharks.lsp.config').code_action_range()<CR>")

  -- Symbols
  keymap_lua("n", "gn", "require('sharks.lsp.config').symbol_rename()")
  keymap_lua("n", "gd", "require('sharks.lsp.config').symbol_definition()")
  keymap_lua("n", "<C+]>", "require('sharks.lsp.config').symbol_definition()")
  keymap_lua("n", "gD", "require('sharks.lsp.config').symbol_implementation()")
  keymap_lua("n", "gT", "require('sharks.lsp.config').symbol_type()")
  keymap_lua("n", "gR", "require('sharks.lsp.config').symbol_references()")
  keymap_lua("n", "g0", "require('sharks.lsp.config').symbol_document()")
  keymap_lua("n", "gW", "require('sharks.lsp.config').symbol_workspace()")

  -- Docs
  keymap_lua("n", "K", "require('sharks.lsp.config').doc_hover()")
  keymap_lua("n", "<C-u>", "require('sharks.lsp.config').doc_scroll_up('<C-u>')")
  keymap_lua("n", "<C-d>", "require('sharks.lsp.config').doc_scroll_down('<C-d>')")
  --keymap_lua('n', '<leader>k', "require('sharks.lsp.config').doc_signature()")
  keymap_lua("i", "<C-y><C-y>", "require('sharks.lsp.config').doc_signature()")

  -- Diagnostic
  vim.cmd([[ 
  autocmd CursorHold * :lua require('sharks.lsp.config').diagnostic_preview()
  ]])
  keymap_lua("n", "<leader>dj", "require('sharks.lsp.config').diagnostic_next()")
  keymap_lua("n", "<leader>dk", "require('sharks.lsp.config').diagnostic_prev()")

  vim.cmd("hi FloatBorder guifg=#777777")
  vim.cmd("hi LspSagaDiagnosticBorder guifg=#7e8294")
  vim.cmd("hi LspSagaDiagnosticTruncateLine guifg=#7e8294")
end

return M
