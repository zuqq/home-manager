-- See: https://cmp.saghen.dev/configuration/general
require("blink.cmp").setup({
  keymap = { preset = "default" },

  appearance = {
    nerd_font_variant = "mono",
  },

  completion = {
    documentation = { auto_show = false },

    trigger = {
      show_on_keyword = false,
      show_on_trigger_character = false,
      show_on_insert_on_trigger_character = false,
      show_on_accept_on_trigger_character = false,
    },
  },

  sources = {
    default = { "lsp", "path", "snippets", "buffer" },
  },

  fuzzy = {
    implementation = "prefer_rust_with_warning",
  },
})
