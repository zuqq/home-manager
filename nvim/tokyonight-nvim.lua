require("tokyonight").setup({
  style = "night",
  -- See: https://github.com/folke/tokyonight.nvim/issues/34#issuecomment-1347911154
  on_colors = function(colors)
    colors.border = "#565f89"
  end
})

vim.cmd("colorscheme tokyonight")
