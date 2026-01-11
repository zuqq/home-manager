local nvim_tree = require("nvim-tree")
local nvim_tree_api = require("nvim-tree.api")
local which_key = require("which-key")

local CURSOR_NAME = "NvimTreeCursor"
local CURSOR = ("n-v-o:%s/l%s"):format(CURSOR_NAME, CURSOR_NAME)

local function install_cursor()
  local cursor = vim.api.nvim_get_hl(0, {name = "Cursor", link = false})
  vim.api.nvim_set_hl(0, CURSOR_NAME, {blend = 100, fg = cursor.fg, bg = cursor.bg})
end

vim.api.nvim_create_autocmd("ColorScheme", {
  callback = install_cursor,
})

local function hide_cursor(desired)
  install_cursor()
  local current = vim.o.guicursor:find(CURSOR, 1, true) ~= nil
  if desired then
    if not current then
      vim.opt.guicursor:append(CURSOR)
    end
  else
    if current then
      vim.opt.guicursor:remove(CURSOR)
    end
  end
end

local function lock_cursor()
  local cursor = vim.api.nvim_win_get_cursor(0)
  vim.api.nvim_win_set_cursor(0, {cursor[1], 0})
end

vim.api.nvim_create_autocmd({"WinEnter", "BufWinEnter", "TabEnter"}, {
  callback = function(args)
    hide_cursor(nvim_tree_api.tree.is_tree_buf(args.buf))
  end,
})

vim.api.nvim_create_autocmd("BufEnter", {
  nested = true,
  callback = function(args)
    if #vim.api.nvim_list_wins() == 1 and nvim_tree_api.tree.is_tree_buf(args.buf) then
      vim.cmd("quit")
    end
  end
})

nvim_tree.setup({
  on_attach = function(bufnr)
    nvim_tree_api.config.mappings.default_on_attach(bufnr)
    if nvim_tree_api.tree.is_tree_buf(bufnr) then
      hide_cursor(true)
    end
    vim.api.nvim_create_autocmd("CursorMoved", {
      buffer = bufnr,
      callback = lock_cursor,
    })
    lock_cursor()
  end,
  update_focused_file = {
    enable = true,
    update_root = false,
  },
})

which_key.add({
  {"<leader>e", "<cmd>NvimTreeFocus<CR>", desc = "explorer"},
})
