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
          r = {telescope_builtin.lsp_references, "references"},
          i = {telescope_builtin.lsp_implementations, "go to implementation"},
          y = {telescope_builtin.lsp_type_definitions, "go to type definition"},
        },
      },
      {
        mode = "n",
      }
    )
    which_key.register(
      {
        r = {vim.lsp.buf.rename, "rename"},
      },
      {
        mode = "n",
        prefix = "<leader>",
      }
    )
  end,
})

vim.diagnostic.config({signs = false})
