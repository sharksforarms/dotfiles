local nvim_lsp = require("lspconfig")
local protocol = require("vim.lsp.protocol")
local util = require("lspconfig/util")
local lsp_status = require("lsp-status")
local status = require("sharks.lsp.status")
local sharks_lsp = require("sharks.lsp.config")

local on_attach = function(client)
  protocol.CompletionItemKind = {
    " ", -- text
    " ", -- method
    " ", -- function
    " ", -- ctor
    " ", -- field
    " ", -- variable
    " ", -- class
    " ", -- interface
    " ", -- module
    " ", -- property
    " ", -- unit
    " ", -- value
    "螺", -- enum
    " ", -- keyword
    " ", -- snippet
    " ", -- color
    " ", -- file
    " ", -- reference
    " ", -- folder
    " ", -- enum member
    " ", -- constant
    " ", -- struct
    " ", -- event
    "璉", -- operator
    " ", -- type parameter
  }

  if client.config.flags then
    client.config.flags.allow_incremental_sync = true
  end

  if client.resolved_capabilities.document_highlight then
    vim.api.nvim_exec(
      [[
    augroup lsp_document_highlight
      autocmd! * <buffer>
      autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
      autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
    augroup END
    ]],
      false
    )
  end

  -- format on save?
  --vim.cmd [[
  --augroup lsp_buf_format
  --au! BufWritePre <buffer>
  --autocmd BufWritePre <buffer> :lua vim.lsp.buf.formatting_sync()
  --augroup END
  --]]

  -- this breaks git-gutter?
  --lsp_status.on_attach(client)

  sharks_lsp.init()
end

local updated_capabilities = vim.lsp.protocol.make_client_capabilities()

updated_capabilities = require("cmp_nvim_lsp").update_capabilities(updated_capabilities)

local extension_path = "/opt/codelldb/extension/"
local codelldb_path = extension_path .. "adapter/codelldb"
local liblldb_path = extension_path .. "lldb/lib/liblldb.so"

local rust_opts = {
  tools = {
    autoSetHints = true,
    hover_with_actions = true,
    runnables = { use_telescope = true },
    debuggables = { use_telescope = true },
    inlay_hints = {
      show_parameter_hints = false,
      parameter_hints_prefix = "",
      other_hints_prefix = "",
    },
    hover_actions = {
      border = "single",
    },
  },
  dap = {
    adapter = require("rust-tools.dap").get_codelldb_adapter(codelldb_path, liblldb_path),
    --adapter = {
    --type = 'executable',
    --command = 'lldb-vscode',
    --name = "rt_lldb"
    --}
  },
  runnables = { use_telescope = true },
  debuggables = { use_telescope = true },
  server = {
    --cmd = {"/home/sharks/source/dotfiles/misc/misc/rust-analyzer-wrapper"},
    on_attach = on_attach,
    root_dir = util.root_pattern("Cargo.toml"),
    capabilities = updated_capabilities,
    settings = {
      -- https://github.com/rust-analyzer/rust-analyzer/blob/master/docs/user/generated_config.adoc
      ["rust-analyzer"] = {
        updates = { channel = "stable" },
        assist = {
          importGroup = true,
          importMergeBehaviour = "full",
          importPrefix = "by_crate",
        },

        callInfo = {
          full = true,
        },

        cargo = {
          allFeatures = true,
          autoreload = true,
          loadOutDirsFromCheck = true,
        },

        checkOnSave = {
          command = "clippy",
          allFeatures = true,
          extraArgs = { "--tests" },
        },

        completion = {
          addCallArgumentSnippets = true,
          addCallParenthesis = true,
          postfix = {
            enable = true,
          },
          autoimport = {
            enable = true,
          },
        },

        diagnostics = {
          enable = true,
          enableExperimental = true,
        },

        hoverActions = {
          enable = true,
          debug = true,
          gotoTypeDef = true,
          implementations = true,
          run = true,
          linksInHover = true,
        },

        inlayHints = {
          chainingHints = true,
          parameterHints = true,
          typeHints = true,
        },

        lens = {
          enable = true,
          debug = true,
          implementations = true,
          run = true,
          methodReferences = true,
          references = true,
        },

        notifications = {
          cargoTomlNotFound = true,
        },

        procMacro = {
          enable = true,
        },
      }, -- ["rust-analyzer"]
    }, -- settings
  }, -- lsp server
}

require("rust-tools").setup(rust_opts)

local function switch_source_header_splitcmd(bufnr, splitcmd)
  bufnr = require("lspconfig").util.validate_bufnr(bufnr)
  local clangd_client = require("lspconfig").util.get_active_client_by_name(bufnr, "clangd")
  local params = { uri = vim.uri_from_bufnr(bufnr) }
  if clangd_client then
    clangd_client.request("textDocument/switchSourceHeader", params, function(err, result)
      if err then
        error(tostring(err))
      end
      if not result then
        print("Corresponding file can’t be determined")
        return
      end
      vim.api.nvim_command(splitcmd .. " " .. vim.uri_to_fname(result))
    end, bufnr)
  else
    print("textDocument/switchSourceHeader is not supported by the clangd server active on the current buffer")
  end
end

-- TODO: Check out these checks
-- local clangd_flags = {
--   "--background-index",
--   "--cross-file-rename",
--   "--clang-tidy-checks=clang-diagnostic-*,clang-analyzer-*,-*,bugprone*,modernize*,performance*,-modernize-pass-by-value,-modernize-use-auto,-modernize-use-using,-modernize-use-trailing-return-type",
-- }
--
-- require("lspconfig").clangd.setup {
--   cmd = {"clangd", unpack(clangd_flags)},
--   capabilities = require'lsp'.capabilities
-- }

local clangd_args = {
  on_attach = on_attach,
  -- cmd = { "clangd", "--background-index", "--compile-commands-dir", "build/" },
  cmd = {
    "clangd",
    "--background-index",
    "--clang-tidy",
    "--header-insertion=iwyu",
    "--cross-file-rename",
    "--clang-tidy-checks=clang-diagnostic-*,clang-analyzer-*,-*,bugprone*,modernize*,performance*,-modernize-pass-by-value,-modernize-use-auto,-modernize-use-using,-modernize-use-trailing-return-type",
    -- "--clang-tidy-checks=*",
  },
  root_dir=util.root_pattern(".git") or util.path.dirname,
  filetypes = { "c", "cc", "cpp" },
  init_options = {
    compilationDatabasePath = "build",
  },
  commands = {
    ClangdSwitchSourceHeader = {
      function()
        switch_source_header_splitcmd(0, "edit")
      end,
      description = "Open source/header in current buffer",
    },
    ClangdSwitchSourceHeaderVSplit = {
      function()
        switch_source_header_splitcmd(0, "vsplit")
      end,
      description = "Open source/header in a new vsplit",
    },
    ClangdSwitchSourceHeaderSplit = {
      function()
        switch_source_header_splitcmd(0, "split")
      end,
      description = "Open source/header in a new split",
    },
  },
  -- root_dir=util.root_pattern("build/compile_commands.json", "compile_commands.json", "compile_flags.txt", ".git") or util.path.dirname
}

require("clangd_extensions").setup({
  server = clangd_args,
  extensions = {
    autoSetHints = true,
    hover_with_actions = true,
    inlay_hints = {
      only_current_line = false,
      only_current_line_autocmd = "CursorHold",
      show_parameter_hints = true,
      parameter_hints_prefix = "<- ",
      other_hints_prefix = "=> ",
      max_len_align = false,
      max_len_align_padding = 1,
      right_align = false,
      right_align_padding = 7,
      highlight = "Comment",
    },
  },
})

nvim_lsp.pylsp.setup({
  -- pip install 'python-language-server[all]'
  cmd = { os.getenv("HOME") .. "/.virtualenvs/pyls/bin/pyls" },
  on_attach = on_attach,
})

nvim_lsp.gopls.setup({
  on_attach = on_attach,
  root_dir = util.root_pattern(".git"),
  cmd = { "gopls", "serve" },
  settings = {
    gopls = {
      analyses = {
        unusedparams = true,
      },
      staticcheck = true,
    },
  },
})

local sumneko_root_path = "/opt/lua-language-server/"
local sumneko_binary = sumneko_root_path .. "/bin/lua-language-server"

require("lspconfig").sumneko_lua.setup({
  on_attach = on_attach,
  cmd = { sumneko_binary, "-E", sumneko_root_path .. "/main.lua" },
  settings = {
    Lua = {
      runtime = {
        -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
        version = "LuaJIT",
        -- Setup your lua path
        path = vim.split(package.path, ";"),
      },
      diagnostics = {
        -- Get the language server to recognize the `vim` global
        globals = { "vim" },
      },
      workspace = {
        -- Make the server aware of Neovim runtime files
        library = {
          [vim.fn.expand("$VIMRUNTIME/lua")] = true,
          [vim.fn.expand("$VIMRUNTIME/lua/vim/lsp")] = true,
        },
      },
    },
  },
})

-- sudo cpanm --notest PLS
require("lspconfig").perlpls.setup({
  on_attach = on_attach,
})
require("lspconfig").tsserver.setup({
  on_attach = on_attach,
})
