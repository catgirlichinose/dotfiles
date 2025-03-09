--local autocmd = vim.api.nvim_create_autocmd

-- settings for Markdown
local opt = vim.opt

opt.tabstop = 4
opt.softtabstop = 4
opt.shiftwidth = 4
opt.shiftround = false
opt.expandtab = true
opt.autoindent = true
opt.smartindent = true

-- Auto resize panes when resizing nvim window
--autocmd("VimResized", {
--   pattern = "*",
--   command = "tabdo wincmd =",
-- })
