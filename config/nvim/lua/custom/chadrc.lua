---@type ChadrcConfig
local M = {}

M.ui = { theme = 'catppuccin' }

M.plugins = 'custom.plugins'

vim.api.nvim_set_keymap('n', '<leader>cpo', "<cmd>CompilerOpen<cr>", { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>cps', "<cmd>CompilerRedo<cr>", { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>cpt', "<cmd>CompilerToggleResults<cr>", { noremap = true, silent = true})

return M
