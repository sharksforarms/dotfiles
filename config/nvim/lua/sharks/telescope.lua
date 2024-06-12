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
          ["<C-f>"] = actions.to_fuzzy_refine,
        },
        n = {
          ["<C-x>"] = false,
          ["<C-s>"] = actions.select_horizontal,
          ["<C-q>"] = actions.send_to_qflist,
        },
      },

      extensions = {
        -- fzy_native = {
        --   override_generic_sorter = false,
        --   override_file_sorter = true,
        -- },
        --
        -- fzf_writer = {
        --   use_highlighter = false,
        --   minimum_grep_characters = 4,
        -- },
        fzf = {
          fuzzy = true,                    -- false will only do exact matching
          override_generic_sorter = true,  -- override the generic sorter
          override_file_sorter = true,     -- override the file sorter
          case_mode = "smart_case",        -- or "ignore_case" or "respect_case"
                                           -- the default case_mode is "smart_case"
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
  telescope.load_extension('fzf')
  telescope.load_extension("octo")
  telescope.load_extension("dap")
  telescope.load_extension("ui-select")
end

function M.search()
  require('telescope.builtin').grep_string({
    search = vim.fn.input("Grep For > "),
    file_ignore_patterns = { "mermaid.min.js" },
  })
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
    file_ignore_patterns = { "/build/", "doc/assets/mermaid" },
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

function M.dotfiles_grep(opts)
  local opts = require("telescope.themes").get_dropdown({
    cwd = "~/dotfiles", --vim.fn.stdpath("config"),
    file_ignore_patterns = { ".git", "plugged/" },
    search = vim.fn.input("Grep For > "),
  })

  require('telescope.builtin').grep_string(opts)
end

function M.notes(opts)
  local opts = require("telescope.themes").get_dropdown({
    find_command = { "rg", "--no-ignore", "--files", "--hidden" },
    cwd = "~/src/fastly/ethompson_notes/", --vim.fn.stdpath("config"),
    file_ignore_patterns = { ".git", "plugged/" },
  })

  require("telescope.builtin").find_files(opts)
end

function M.notes_grep(opts)
  local opts = require("telescope.themes").get_dropdown({
    cwd = "~/src/fastly/ethompson_notes/", --vim.fn.stdpath("config"),
    file_ignore_patterns = { ".git", "plugged/" },
    search = vim.fn.input("Grep For > "),
  })

  require('telescope.builtin').grep_string(opts)
end

function M.find_all_files()
  local opts = require("telescope.themes").get_dropdown({
    find_command = { "rg", "--no-ignore", "--files", "--hidden" },
  })
  require("telescope.builtin").find_files(opts)
end

function M.h2o_configs(opts)

  local repo_name = vim.system(
    {
      "basename",
      vim.system({"git", "rev-parse", "--show-toplevel"}, { text = true }):wait().stdout
    }, { text = true }):wait().stdout

  repo_name = string.gsub(repo_name, "\n", "")

  local opts = {}
  if repo_name == "h2o" then
    opts = require("telescope.themes").get_dropdown({
      find_command = { "rg", "--no-ignore", "--files", "--hidden", "--iglob", "h2o.conf", "--iglob", "h2o-quic.conf" },
      file_ignore_patterns = { ".git", "plugged/" },
      prompt_title = repo_name,
      default_text = 'tmp',
    })
  elseif repo_name == "origind" then
    opts = require("telescope.themes").get_dropdown({
      file_ignore_patterns = { ".git", "plugged/" },
      prompt_title = repo_name,
      default_text = 'origind.toml',
    })
  elseif repo_name == "configly-data" then
    opts = require("telescope.themes").get_dropdown({
      file_ignore_patterns = { ".git", "plugged/" },
      prompt_title = repo_name,
      default_text = 'h2o_rc_autodeploy_',
    })
  end

  require("telescope.builtin").find_files(opts)
end

return M
