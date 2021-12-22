vim.cmd([[
sign define LspDiagnosticsSignError text= texthl=LspDiagnosticsSignError linehl= numhl=
sign define LspDiagnosticsSignWarning text= texthl=LspDiagnosticsSignWarning linehl= numhl=
sign define LspDiagnosticsSignInformation text= texthl=LspDiagnosticsSignInformation linehl= numhl=
sign define LspDiagnosticsSignHint text= texthl=LspDiagnosticsSignHint linehl= numhl=
]])

vim.diagnostic.config({
  underline = true,
  virtual_text = false,
  signs = true,

  -- options for floating windows:
  float = {
    show_header = true,
  },

  -- general purpose
  severity_sort = true,
  update_in_insert = false,
})
