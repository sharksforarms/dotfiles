-- This is a scratch/test/playground area
local M = {}

local telescope = require('telescope')
local finders = require('telescope.finders')
local pickers = require('telescope.pickers')
local sorters = require('telescope.sorters')
local actions = require('telescope.actions')

local run_ns = vim.api.nvim_create_namespace("sharks.telescope.run_ns")
function M.runnables(opts)
  on_response = function(err, method, params, client_id, bufnr, config)
    opts = opts or {}

    P(params)

    local labels = {}
    local label_info = {}
    for i,v in ipairs(params) do
      table.insert(labels, v['label'])
      label_info[v['label']] = v
    end

    pickers.new(opts, {
      prompt_title = 'Launch',
      finder    = finders.new_table {
        results = labels
      },
      sorter = sorters.get_generic_fuzzy_sorter(),
      attach_mappings = function(prompt_bufnr, map)
        local selected = function()
          local selection = actions.get_selected_entry(prompt_bufnr)
          actions.close(prompt_bufnr)

          P(selection.value)
          P(label_info[selection.value])
          local prefix = '> '
          local display_virt_text = function(hint, label)
            local end_line = hint.targetSelectionRange["end"].line
            local text
            text = prefix .. label
            vim.api.nvim_buf_set_virtual_text(bufnr, run_ns, end_line, {{text, "Comment"}}, {})
          end

          display_virt_text(label_info[selection.value]['location'], selection.value)

        end

        map('i', '<CR>', selected)
        map('n', '<CR>', selected)

        return true
      end
    }):find()
  end

  vim.lsp.buf_request(
    0,
    "experimental/runnables",
    --vim.lsp.util.make_position_params(), -- around position
    {textDocument = vim.lsp.util.make_text_document_params()}, -- all in file
    on_response
  )
end

return M
