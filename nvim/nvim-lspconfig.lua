local lspconfig = require("lspconfig")
local telescope_builtin = require("telescope.builtin")
local which_key = require("which-key")

lspconfig.gopls.setup({})
lspconfig.hls.setup({})
lspconfig.pyright.setup({
  settings = {
    -- See: https://github.com/microsoft/pyright/blob/main/docs/configuration.md
    python = {
      analysis = {
        typeCheckingMode = "strict",
      },
    },
  },
})
lspconfig.ruff.setup({
  on_attach = function(client, bufnr)
    if client.name == "ruff" then
      client.server_capabilities.codeActionProvider = nil
      client.server_capabilities.diagnosticProvider = nil
      client.server_capabilities.hoverProvider = false
    end
  end
})
lspconfig.rust_analyzer.setup({})

vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    which_key.register(
      {
        g = {
          name = "go to",
          d = {telescope_builtin.lsp_definitions, "definition"},
          D = {telescope_builtin.lsp_references, "references"},
        },
      },
      {
        mode = "n",
        buffer = args.buf,
      }
    )
    which_key.register(
      {
        c = {
          name = "LSP",

          i = {telescope_builtin.implementations, "go to implementations"},
          j = {vim.lsp.buf.declaration, "go to declaration"},
          k = {vim.lsp.buf.signature_help, "show signature"},
          t = {telescope_builtin.lsp_type_definitions, "go to type definition"},

          a = {vim.lsp.buf.code_action, "execute action"},
          f = {vim.lsp.buf.format, "format file"},
          r = {vim.lsp.buf.rename, "rename symbol"},

          e = {vim.diagnostic.open_float, "show error"},
          n = {vim.diagnostic.goto_next, "go to next error"},
          p = {vim.diagnostic.goto_prev, "go to previous error"},
          x = {telescope_builtin.diagnostics, "list errors"},
        },
        f = {
          name = "LSP",

          r = {vim.lsp.buf.references, "find references"},
        }
      },
      {
        mode = "n",
        prefix = "<leader>",
        buffer = args.buf,
      }
    )
    which_key.register(
      {
        c = {
          name = "LSP",
          f = {vim.lsp.buf.format, "format range"},
        },
      },
      {
        mode = "v",
        prefix = "<leader>",
        buffer = args.buf,
      }
    )
  end,
})

vim.diagnostic.config({signs = false})
