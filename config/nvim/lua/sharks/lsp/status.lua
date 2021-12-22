local lsp_status = require("lsp-status")

local status = {}

status.select_symbol = function(cursor_pos, symbol)
  if symbol.valueRange then
    local value_range = {
      ["start"] = {
        character = 0,
        line = vim.fn.byte2line(symbol.valueRange[1]),
      },
      ["end"] = {
        character = 0,
        line = vim.fn.byte2line(symbol.valueRange[2]),
      },
    }

    return require("lsp-status.util").in_range(cursor_pos, value_range)
  end
end

local symbol_kind_labels_map = {
  ["File"] = "",
  ["Module"] = "全",
  ["Namespace"] = "",
  ["Package"] = "",
  ["Class"] = "",
  ["Method"] = "",
  ["Property"] = "",
  ["Field"] = "",
  ["Constructor"] = "",
  ["Enum"] = "螺",
  ["Interface"] = "",
  ["Function"] = "",
  ["Variable"] = "",
  ["Constant"] = "",
  ["String"] = "",
  ["Number"] = "7",
  ["Boolean"] = "",
  ["Array"] = "",
  ["Object"] = "",
  ["Key"] = "",
  ["Null"] = "",
  ["EnumMember"] = "",
  ["Struct"] = "",
  ["Event"] = "",
  ["Operator"] = "璉",
  ["TypeParameter"] = "",
}

status.activate = function()
  lsp_status.register_progress()

  lsp_status.config({
    current_function = true,
    kind_labels = symbol_kind_labels_map,
    status_symbol = "%#StatusLineLinNbr#LSP",
    indicator_errors = "%#StatusLineLSPErrors#",
    indicator_warnings = "%#StatusLineLSPWarnings#",
    indicator_info = "%#StatusLineLSPInfo#",
    indicator_hints = "%#StatusLineLSPHints#",
    indicator_ok = "%#StatusLineLSPOk#",
  })
end

return status
