local o = vim.o
local opt = vim.opt
o.tabstop = 2
o.shiftwidth = 2
opt.relativenumber = true
o.cmdheight = 0

vim.cmd([[ colorscheme onedark ]])
vim.cmd([[ set fillchars=eob:\ ]])
vim.lsp.inlay_hint.enable(true)
