-- See: https://cmp.saghen.dev/configuration/general
require("blink.cmp").setup({
  keymap = {
    preset = "default",

    ["<Tab>"] = {"select_and_accept", "snippet_forward", "fallback"},
    ["<S-Tab>"] = {"select_and_accept", "snippet_backward", "fallback"},
  },

  sources = {
    default = {
      "lsp",
    },
  },

  fuzzy = {
    implementation = "prefer_rust_with_warning",
  },

  cmdline = {
    enabled = false,
  },
})
