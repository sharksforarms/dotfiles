local M = {}

local telescope = require("telescope")
local finders = require("telescope.finders")
local pickers = require("telescope.pickers")
local sorters = require("telescope.sorters")
local actions = require("telescope.actions")
local previewers = require("telescope.previewers")
local action_state = require("telescope.actions.state")
local action_set = require("telescope.actions.set")
local conf = require("telescope.config").values
local Path = require("plenary.path")

function M.setup()
  telescope.setup({
    defaults = {
      prompt_prefix = ">",
      selection_strategy = "reset",
      scroll_strategy = "cycle",
      sorting_strategy = "descending",
      layout_strategy = "horizontal",

      file_ignore_patterns = {},
      winblend = 0,
      color_devicons = true,

      file_previewer = require("telescope.previewers").vim_buffer_cat.new,
      grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
      qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,

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
          },
        },
      },
    },
  })

  telescope.load_extension("frecency")
  telescope.load_extension("fzy_native")
  telescope.load_extension("octo")
  telescope.load_extension("dap")
  telescope.load_extension("ui-select")
end

function M.search()
  require('telescope.builtin').grep_string({ search = vim.fn.input("Grep For > ")})
end

function M.find_files()
  local opts = require("telescope.themes").get_dropdown({
    attach_mappings = function(_, map)
      local function goto_nerdtree()
        local selection = action_state.get_selected_entry().path
        P(selection)
        -- Goto nerdtree
        vim.cmd(":NERDTreeFind " .. selection)
      end

      map("i", "<C-o>", goto_nerdtree)
      map("n", "<C-o>", goto_nerdtree)

      return true
    end,
    file_ignore_patterns = { "/build/" },
  })
  require("telescope.builtin").find_files(opts)
end

function M.dotfiles(opts)
  local opts = require("telescope.themes").get_dropdown({
    find_command = { "rg", "--no-ignore", "--files", "--hidden" },
    cwd = "~/dotfiles", --vim.fn.stdpath("config"),
    file_ignore_patterns = { ".git", "plugged/" },
  })

  require("telescope.builtin").find_files(opts)
end

function M.notes(opts)
  local opts = require("telescope.themes").get_dropdown({
    find_command = { "rg", "--no-ignore", "--files", "--hidden" },
    cwd = "~/src/fastly/ethompson_notes/", --vim.fn.stdpath("config"),
    file_ignore_patterns = { ".git", "plugged/" },
  })

  require("telescope.builtin").find_files(opts)
end

function M.find_all_files()
  local opts = require("telescope.themes").get_dropdown({
    find_command = { "rg", "--no-ignore", "--files", "--hidden" },
  })
  require("telescope.builtin").find_files(opts)
end

function M.h2o_configs(opts)
  local opts = require("telescope.themes").get_dropdown({
    find_command = { "rg", "--no-ignore", "--files", "--hidden", "--iglob", "h2o*.conf" },
    file_ignore_patterns = { ".git", "plugged/" },
    default_text = 'tmp',
  })

  require("telescope.builtin").find_files(opts)
end

return M
