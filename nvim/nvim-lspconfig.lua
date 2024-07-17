local lspconfig = require("lspconfig")
local telescope_builtin = require("telescope.builtin")
local which_key = require("which-key")

lspconfig.hls.setup({})
lspconfig.pyright.setup({})
lspconfig.ruff.setup({
  on_attach = function(client, bufnr)
    if client.name == "ruff" then
      client.server_capabilities.codeActionProvider = nil
      client.server_capabilities.diagnosticProvider = nil
      client.server_capabilities.hoverProvider = false
    end
  end
})

vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    -- See: https://github.com/neovim/neovim/pull/19677
    vim.bo[args.buf].formatexpr = nil,

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
