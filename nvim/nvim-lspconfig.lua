local lspconfig = require("lspconfig")
local telescope_builtin = require("telescope.builtin")
local which_key = require("which-key")

lspconfig.gopls.setup {}
lspconfig.pyright.setup {}

vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("UserLspConfig", {}),
  callback = function(env)
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
            buffer = env.buf,
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
            buffer = env.buf,
        }
    )
  end,
})

vim.diagnostic.config({signs = false})
