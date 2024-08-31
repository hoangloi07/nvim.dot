local map = vim.keymap.set

vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- map('i','jk','<ESC>')

-- Reload Config --
vim.api.nvim_set_keymap("n", "<space>so", "<cmd>lua ReloadConfig()<CR>", { noremap = true, silent = false })

map("n", "<leader>n", "<cmd>NvimTreeToggle<CR>")

-- Buffers keymaps --
map("n", "<TAB>", "<cmd>bn<CR>")
map("n", "<Backspace>", "<cmd>bp<CR>")
map("n", "<leader>x", "<cmd>bd!<CR>")

-- Esc to exit terminal mode --
map("t", "<ESC>", "<C-\\><C-n>")

-- Telescope keymaps --
map("n", "<leader>ff", "<cmd>Telescope find_files<CR>")
map("n", "<leader>fg", "<cmd>Telescope live_grep<CR>")

map("n", "<leader>?", "<cmd>Cheatsheet<CR>")

-- terminal --
map("n", "<A-h>", "<cmd>ToggleTerm<CR>")

vim.api.nvim_set_keymap("n", "<Leader>o", "", {

	callback = function()
		local statusline = vim.o.statusline

		require("lualine").hide({
			place = { "statusline" },
			unhide = statusline == "" or statusline == "%#Normal#",
		})
	end,
})

-- Debug --
map("n", "<F8>", "<cmd>DapToggleBreakpoint<CR>")
map("n", "<F9>", "<cmd>lua require('dapui').toggle()<CR>")
