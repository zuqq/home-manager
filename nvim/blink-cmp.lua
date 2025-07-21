-- See: https://cmp.saghen.dev/configuration/general
require("blink.cmp").setup({
  completion = {
    menu = {
      auto_show = false,
    },
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
