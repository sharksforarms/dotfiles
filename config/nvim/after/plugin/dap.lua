local dap = require("dap")

-- sudo pip3 install debugpy
require("dap-python").setup("/usr/bin/python3")

require("nvim-dap-virtual-text").setup()

vim.keymap.set("n", "<leader>dd", require('dapui').toggle)
vim.keymap.set("n", "<leader>db", require('dap').toggle_breakpoint)
vim.keymap.set("n", "<leader>dc", require('dap').continue)
vim.keymap.set("n", "<leader>dn", require('dap').step_over)
vim.keymap.set("n", "<leader>di", require('dap').step_into)
vim.keymap.set("n", "<leader>do", require('dap').step_out)
vim.keymap.set("n", "<leader>dr", require('dap').run_last)

vim.fn.sign_define("DapBreakpoint", { text = "●", texthl = "healthError", linehl = "CursorLine", numhl = "" })

vim.g.dap_virtual_text = true

dap.adapters.lldb = {
  type = "executable",
  command = "/usr/bin/lldb-vscode-11",
  name = "lldb",
}

dap.configurations.cpp = {
  {
    name = "Launch",
    type = "lldb",
    request = "launch",
    program = function()
      return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
    end,
    cwd = "${workspaceFolder}",
    stopOnEntry = false,
    args = {},

    -- if you change `runInTerminal` to true, you might need to change the yama/ptrace_scope setting:
    --    echo 0 | sudo tee /proc/sys/kernel/yama/ptrace_scope
    -- Otherwise you might get the following error:
    --    Error on launch: Failed to attach to the target process
    -- But you should be aware of the implications:
    -- https://www.kernel.org/doc/html/latest/admin-guide/LSM/Yama.html
    runInTerminal = false,
  },
}

dap.configurations.c = dap.configurations.cpp
dap.configurations.rust = dap.configurations.cpp
vim.cmd([[
  autocmd FileType dapui* set statusline=%!v:lua.inactive_status_line()
  autocmd FileType dap-repl set statusline=%!v:lua.inactive_status_line()
]])

require("dapui").setup({
  icons = { expanded = "▾", collapsed = "▸" },
  mappings = {
    -- Use a table to apply multiple mappings
    expand = { "<CR>", "<2-LeftMouse>" },
    open = "o",
    remove = "d",
    edit = "e",
    repl = "r",
  },
  layouts = {
    {
      elements = {
        'scopes',
        'breakpoints',
        'stacks',
        'watches',
      },
      size = 40,
      position = 'left',
    },
    {
      elements = {
        'repl',
        'console',
      },
      size = 10,
      position = 'bottom',
    },
  },
  floating = {
    max_height = nil, -- These can be integers or a float between 0 and 1.
    max_width = nil, -- Floats will be treated as percentage of your screen.
    mappings = {
      close = { "q", "<Esc>" },
    },
  },
  windows = { indent = 1 },
})
