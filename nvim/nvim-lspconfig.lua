local telescope_builtin = require("telescope.builtin")
local which_key = require("which-key")

vim.lsp.enable("gopls")
vim.lsp.enable("hls")

vim.lsp.config("pyright", {
  settings = {
    -- See: https://github.com/microsoft/pyright/blob/main/docs/configuration.md
    python = {
      analysis = {
        typeCheckingMode = "strict",
      },
    },
  },
})
vim.lsp.enable("pyright")

vim.lsp.config("ruff", {
  on_attach = function(client, bufnr)
    if client.name == "ruff" then
      client.server_capabilities.codeActionProvider = nil
      client.server_capabilities.diagnosticProvider = nil
      client.server_capabilities.hoverProvider = false
    end
  end
})
vim.lsp.enable("ruff")
vim.lsp.enable("rust_analyzer")

vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    which_key.add({
      {"gd", telescope_builtin.lsp_definitions, desc = "definition"},
      {"gr", telescope_builtin.lsp_references, desc = "references"},
      {"gi", telescope_builtin.lsp_implementations, desc = "go to implementation"},
      {"gy", telescope_builtin.lsp_type_definitions, desc = "go to type definition"},
      {"<leader>r", vim.lsp.buf.rename, desc = "rename"},
    }, {buffer = args.buf})
  end,
})

vim.diagnostic.config({signs = false})
