local telescope = require("telescope")
local telescope_actions = require("telescope.actions")
local telescope_builtin = require("telescope.builtin")
local which_key = require("which-key")

telescope.setup({
  defaults = {
    layout_strategy = "vertical",

    -- See: https://github.com/nvim-telescope/telescope.nvim/wiki/Configuration-Recipes#mappings
    mappings = {
      i = {
        ["<C-g>"] = telescope_actions.close,
        ["<Esc>"] = telescope_actions.close,

        ["<C-u>"] = false,
      },
    },
  },
})

which_key.register(
  {
    [","] = {telescope_builtin.buffers, "find buffer"},
    ["."] = {telescope_builtin.find_files, "find file"},
    ["/"] = {telescope_builtin.live_grep, "search"},
  },
  {
    mode = "n",
    prefix = "<leader>",
  }
)
