local nvim_lsp = require("lspconfig")
local protocol = require("vim.lsp.protocol")
local util = require("lspconfig/util")
-- local lsp_status = require("lsp-status")
local status = require("sharks.lsp.status")
local sharks_lsp = require("sharks.lsp.config")
local lsp_selection_range = require("lsp-selection-range")
local navic = require("nvim-navic")

local on_attach = function(client, bufnr)
  local caps = client.server_capabilities
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

  if client.server_capabilities.documentSymbolProvider then
    navic.attach(client, bufnr)
  end

  -- if client.config.flags then
  --   client.config.flags.allow_incremental_sync = true
  -- end

  if caps.document_highlight then
    vim.api.nvim_exec(
      [[
    augroup lsp_document_highlight
      autocmd! * <buffer>
      autocmd CursorHold  <buffer> lua vim.lsp.buf.document_highlight()
      autocmd CursorHoldI <buffer> lua vim.lsp.buf.document_highlight()
      autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
    augroup END
    ]],
      false
    )
  end

  client.server_capabilities.semanticTokensProvider = nil
  -- if caps.semanticTokensProvider and caps.semanticTokensProvider.full then
  --   local augroup = vim.api.nvim_create_augroup("SemanticTokens", {})
  --   vim.cmd([[
  --     hi link LspComment TSComment
  --   ]])
  --   vim.api.nvim_create_autocmd({ "BufEnter", "CursorHold", "InsertLeave" }, {
  --     group = augroup,
  --     buffer = bufnr,
  --     callback = function()
  --       -- vim.lsp.buf.semantic_tokens_full()
  --       -- require('vim.lsp.semantic_tokens').refresh(bufnr)
  --     end,
  --   })
  --   -- fire it first time on load as well
  --   -- vim.lsp.buf.semantic_tokens_full()
  --   -- vim.lsp.semantic_tokens.refresh(bufnr)
  --   -- require('vim.lsp.semantic_tokens').refresh(bufnr)
  -- end

  local code_lens_cap_found = false
    for _, client in ipairs(vim.lsp.get_clients()) do
        if client.supports_method("textDocument/codeLens") then
            code_lens_cap_found = true
            break
        end
    end
    if code_lens_cap_found then
      local augroup_code_lens = vim.api.nvim_create_augroup("CodeLens", {})
      -- vim.api.nvim_create_autocmd({ "BufEnter", "CursorHold", "InsertLeave" }, {
      vim.api.nvim_create_autocmd({ "BufEnter", "InsertLeave" }, {
        group = augroup_code_lens,
        buffer = bufnr,
        callback = function()
          -- vim.lsp.codelens.refresh()
        end,
      })
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

local updated_capabilities = require("cmp_nvim_lsp").default_capabilities()
updated_capabilities = lsp_selection_range.update_capabilities(updated_capabilities)

local extension_path = "/opt/codelldb/extension/"
local codelldb_path = extension_path .. "adapter/codelldb"
local liblldb_path = extension_path .. "lldb/lib/liblldb.so"

local rust_opts = {
  tools = {
    runnables = {},
    debuggables = {},
    hover_actions = {
      auto_focus = true,
      border = "single",
    },
  },
  dap = {
    --adapter = require("rust-tools.dap").get_codelldb_adapter(codelldb_path, liblldb_path),
    --adapter = {
    --type = 'executable',
    --command = 'lldb-vscode',
    --name = "rt_lldb"
    --}
  },
  server = {
    --cmd = {"/home/sharks/source/dotfiles/misc/misc/rust-analyzer-wrapper"},
    --cmd = { "rustup", "run", "stable", "rust-analyzer" },
    -- cmd = { "/home/ethompson/.cargo/bin/rust-analyzer" },
    cmd = { "rust-analyzer" },
    on_attach = on_attach,
    root_dir = util.root_pattern("Cargo.toml"),
    capabilities = updated_capabilities,
    settings = {
      -- https://github.com/rust-analyzer/rust-analyzer/blob/master/docs/user/generated_config.adoc
      ["rust-analyzer"] = {
        updates = { channel = "stable" },
        imports = {
          granularity = {
            enforce = false,
            group = "crate",
          },
        },

        callinfo = {
          full = true,
        },

        cargo = {
          allfeatures = true,
          autoreload = true,
          loadoutdirsfromcheck = true,
        },

        -- checkonsave = {
        --   command = "clippy",
        --   allfeatures = true,
        --   extraargs = { "--tests" },
        -- },

        completion = {
          addcallargumentsnippets = true,
          addcallparenthesis = true,
          postfix = {
            enable = true,
          },
          autoimport = {
            enable = true,
          },
        },

        diagnostics = {
          enable = true,
          -- enableexperimental = true,
          disabled = {
            "unresolved-proc-macro",
            "unresolved-macro-call",
          }
        },

        hoveractions = {
          enable = true,
          debug = true,
          gototypedef = true,
          implementations = true,
          run = true,
          linksinhover = true,
        },

        inlayhints = {
          chaininghints = true,
          parameterhints = false,
          typehints = true,
        },

        lens = {
          enable = true,
          debug = true,
          implementations = true,
          run = true,
          methodreferences = true,
          references = true,
        },

        notifications = {
          cargotomlnotfound = true,
        },

        procmacro = {
          enable = true,
        },
      }, -- ["rust-analyzer"]
    }, -- settings
  }, -- lsp server
}

vim.g.rustaceanvim = rust_opts;

-- require("rust-tools").setup(rust_opts)

local function switch_source_header_splitcmd(bufnr, splitcmd)
  bufnr = require("lspconfig").util.validate_bufnr(bufnr)
  local clangd_client = require("lspconfig").util.get_active_client_by_name(bufnr, "clangd")
  local params = { uri = vim.uri_from_bufnr(bufnr) }
  if clangd_client then
    clangd_client.request("textdocument/switchsourceheader", params, function(err, result)
      if err then
        error(tostring(err))
      end
      if not result then
        print("corresponding file can’t be determined")
        return
      end
      vim.api.nvim_command(splitcmd .. " " .. vim.uri_to_fname(result))
    end, bufnr)
  else
    print("textdocument/switchsourceheader is not supported by the clangd server active on the current buffer")
  end
end

require("clangd_extensions").setup({
    inlay_hints = {
        only_current_line = false,
        only_current_line_autocmd = { "cursorhold" },
        show_parameter_hints = true,
        parameter_hints_prefix = "<- ",
        other_hints_prefix = "=> ",
        highlight = "comment",
    },
})

require("lspconfig").clangd.setup {
  on_attach = on_attach,
  capabilities = updated_capabilities,
  cmd = {
    "clangd",
    "--background-index",
    "--clang-tidy",
    "--header-insertion=iwyu",
    "--clang-tidy-checks=misc-unused-*,clang-diagnostic-*,clang-analyzer-*,-*,bugprone*,modernize*,performance*,-modernize-pass-by-value,-modernize-use-auto,-modernize-use-using,-modernize-use-trailing-return-type",
  },
  root_dir = function(fname)
    local primary = util.root_pattern("build")(fname)
    local fallback = util.root_pattern(".git")(fname)
    return primary or fallback
  end,
  single_file_support = true,
  filetypes = { "c", "cc", "cpp" },
  init_options = {
    compilationdatabasepath = "build",
  },
  commands = {
    Clangdswitchsourceheader = {
      function()
        switch_source_header_splitcmd(0, "edit")
      end,
      description = "open source/header in current buffer",
    },
    Clangdswitchsourceheadervsplit = {
      function()
        switch_source_header_splitcmd(0, "vsplit")
      end,
      description = "open source/header in a new vsplit",
    },
    Clangdswitchsourceheadersplit = {
      function()
        switch_source_header_splitcmd(0, "split")
      end,
      description = "open source/header in a new split",
    },
  },
}


-- nvim_lsp.pylsp.setup({
--   -- pip install 'python-language-server[all]'
--   cmd = { os.getenv("home") .. "/.virtualenvs/pyls/bin/pyls" },
--   on_attach = on_attach,
-- })

-- nvim_lsp.gopls.setup({
--   on_attach = on_attach,
--   root_dir = util.root_pattern(".git"),
--   cmd = { "gopls", "serve" },
--   settings = {
--     gopls = {
--       analyses = {
--         unusedparams = true,
--       },
--       staticcheck = true,
--     },
--   },
-- })

-- local sumneko_root_path = "/opt/lua-language-server/"
-- local sumneko_binary = sumneko_root_path .. "/bin/lua-language-server"
--
-- require("lspconfig").sumneko_lua.setup({
--   on_attach = on_attach,
--   cmd = { sumneko_binary, "-e", sumneko_root_path .. "/main.lua" },
--   settings = {
--     lua = {
--       runtime = {
--         -- tell the language server which version of lua you're using (most likely luajit in the case of neovim)
--         version = "luajit",
--         -- setup your lua path
--         path = vim.split(package.path, ";"),
--       },
--       diagnostics = {
--         -- get the language server to recognize the `vim` global
--         globals = { "vim" },
--       },
--       workspace = {
--         -- make the server aware of neovim runtime files
--         library = {
--           [vim.fn.expand("$vimruntime/lua")] = true,
--           [vim.fn.expand("$vimruntime/lua/vim/lsp")] = true,
--         },
--       },
--     },
--   },
-- })

-- sudo cpanm --notest pls
require("lspconfig").perlpls.setup({
  on_attach = on_attach,
})

-- docker'ized lsp
-- require("lspconfig").bashls.setup({
--   before_init = function(params)
--     params.processid = vim.nil
--   end,
--   cmd = require("lspcontainers").command("bashls"),
--   root_dir = util.root_pattern(".git", vim.fn.getcwd()),
--   on_attach = on_attach,
-- })
require'lspconfig'.bashls.setup{
  on_attach = on_attach,
}
-- require("lspconfig").dockerls.setup({
--   before_init = function(params)
--     params.processid = vim.nil
--   end,
--   cmd = require("lspcontainers").command("dockerls"),
--   root_dir = util.root_pattern(".git", vim.fn.getcwd()),
--   on_attach = on_attach,
-- })
require("lspconfig").gopls.setup({
  cmd = require("lspcontainers").command("gopls"),
  on_attach = on_attach,
})
-- require("lspconfig").jsonls.setup({
--   before_init = function(params)
--     params.processid = vim.nil
--   end,
--   cmd = require("lspcontainers").command("jsonls"),
--   root_dir = util.root_pattern(".git", vim.fn.getcwd()),
--   on_attach = on_attach,
-- })
-- require("lspconfig").pyright.setup({
--   before_init = function(params)
--     params.processid = vim.nil
--   end,
--   cmd = require("lspcontainers").command("pyright"),
--   root_dir = util.root_pattern(".git", vim.fn.getcwd()),
--   on_attach = on_attach,
-- })
require("lspconfig").pylsp.setup({
  cmd = require("lspcontainers").command("pylsp"),
  on_attach = on_attach,
})
-- require("lspconfig").lua_ls.setup({
--   cmd = require("lspcontainers").command("lua_ls"),
--   settings = { { diagnostics = { globals = { "vim" } } } },
--   on_attach = on_attach,
-- })
-- require("lspconfig").tsserver.setup({
--   before_init = function(params)
--     params.processid = vim.nil
--   end,
--   cmd = require("lspcontainers").command("tsserver"),
--   root_dir = util.root_pattern(".git", vim.fn.getcwd()),
--   on_attach = on_attach,
-- })
-- require("lspconfig").yamlls.setup({
--   before_init = function(params)
--     params.processid = vim.nil
--   end,
--   cmd = require("lspcontainers").command("yamlls"),
--   root_dir = util.root_pattern(".git", vim.fn.getcwd()),
--   on_attach = on_attach,
-- })

local path = require("mason-core.path")
-- local groovy_lsp = path.concat({
--   vim.fn.stdpath("data"),
--   "mason",
--   "packages/groovy-language-server/build/libs/groovy-language-server-all.jar",
-- })
-- require("lspconfig").groovyls.setup({
--   cmd = { "java", "-jar", groovy_lsp },
--   on_attach = on_attach,
-- })
local mason_lspconfig = require("mason-lspconfig")
mason_lspconfig.setup({
  ensure_installed = {
    --"groovyls",
    --"yamlls",
  },
})
mason_lspconfig.setup_handlers({
  function(server_name)
    require("lspconfig")[server_name].setup({
      on_attach = on_attach,
    })
  end,
})
