local M = {}

local function diagnostics_to_items(diagnostics_by_buf, predicate)
  if not diagnostics_by_buf then
    return {}
  end
  local items = {}
  for bufnr, diagnostics in pairs(diagnostics_by_buf) do
    for _, d in pairs(diagnostics) do
      if not predicate or predicate(d) then
        table.insert(items, {
          bufnr = bufnr,
          lnum = d.range.start.line + 1,
          col = d.range.start.character + 1,
          text = d.message,
          vcol = 1,
        })
      end
    end
  end
  table.sort(items, function(a, b)
    return a.lnum < b.lnum
  end)
  return items
end

function M.errors_to_quickfix()
  local items = diagnostics_to_items(vim.lsp.diagnostic.get_all(), function(d)
    return d.severity == vim.lsp.protocol.DiagnosticSeverity.Error
  end)
  vim.fn.setqflist({}, "r", {
    title = "Language Server (Errors)",
    items = items,
  })
end

function M.warnings_to_quickfix()
  local items = diagnostics_to_items(vim.lsp.diagnostic.get_all(), function(d)
    return d.severity == vim.lsp.protocol.DiagnosticSeverity.Warning
  end)
  vim.fn.setqflist({}, "r", {
    title = "Language Server (Warnings)",
    items = items,
  })
end

return M
