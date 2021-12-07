local M = {}

local telescope = require('telescope')
local finders = require('telescope.finders')
local pickers = require('telescope.pickers')
local sorters = require('telescope.sorters')
local actions = require('telescope.actions')
local previewers = require('telescope.previewers')
local conf = require('telescope.config').values
local Path = require("plenary.path")
local keymap_lua = require('sharks.keymap').keymap_lua

function M.setup()
  telescope.setup{
    defaults = {
      prompt_prefix = ">",
      selection_strategy = "reset",
      scroll_strategy = "cycle",
      sorting_strategy = "descending",
      layout_strategy = "horizontal",

      file_ignore_patterns = {},
      winblend = 0,
      color_devicons = true,

      file_previewer   = require('telescope.previewers').vim_buffer_cat.new,
      grep_previewer   = require('telescope.previewers').vim_buffer_vimgrep.new,
      qflist_previewer = require('telescope.previewers').vim_buffer_qflist.new,

      mappings = {
        i = {
          ["<C-x>"] = false,
          ["<C-s>"] = actions.select_horizontal,
          ["<C-q>"] = actions.send_to_qflist,
        },
        n = {
          ["<C-x>"] = false,
          ["<C-s>"] = actions.select_horizontal,
          ["<C-q>"] = actions.send_to_qflist,
        },
      },

      extensions = {
        fzy_native = {
          override_generic_sorter = false,
          override_file_sorter = true,
        },

        fzf_writer = {
          use_highlighter = false,
          minimum_grep_characters = 4,
        },

        frecency = {
          show_scores = true,
          workspaces = {
            ["conf"] = vim.fn.stdpath("config"),
          }
        }
      }
    }
  }

  telescope.load_extension('frecency')
  telescope.load_extension('fzy_native')
  telescope.load_extension('octo')
  telescope.load_extension('dap')

  keymap_lua('n', '<leader>fe', "require('telescope.builtin').file_browser()")
end

function M.dotfiles(opts)
  local opts = require('telescope.themes').get_dropdown{
    find_command = { 'rg', '--no-ignore', '--files', '--hidden' },
    cwd = "~/dotfiles", --vim.fn.stdpath("config"),
    file_ignore_patterns = { ".git", "plugged/" },
  }

  require('telescope.builtin').find_files(opts)
end

function M.search_all_files()
  local opts = require('telescope.themes').get_dropdown{
    find_command = { 'rg', '--no-ignore', '--files', '--hidden' },
  }
  require('telescope.builtin').find_files(opts)
end

return M
