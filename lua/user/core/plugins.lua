local ensure_packer = function()
	local fn = vim.fn
	local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
	if fn.empty(fn.glob(install_path)) > 0 then
		fn.system({ "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path })
		vim.cmd([[packadd packer.nvim]])
		return true
	end
	return false
end

local packer_bootstrap = ensure_packer()

return require("packer").startup(function(use)
	-- Packer Nvim --
	use("wbthomason/packer.nvim")
	if packer_bootstrap then
		require("packer").sync()
	end

	-- Useful plugins --
	use({
		"nvim-tree/nvim-tree.lua",
		requires = {
			"nvim-tree/nvim-web-devicons", -- optional
		},
	})
	use({
		"nvim-telescope/telescope.nvim",
		tag = "0.1.8",
		requires = { { "nvim-lua/plenary.nvim" } },
	})
	use("mfussenegger/nvim-dap")
	use({ "rcarriga/nvim-dap-ui", requires = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" } })

	-- UI --
	use("yamatsum/nvim-nonicons")
	use({
		"letieu/btw.nvim",
	})
	use({
		"vague2k/vague.nvim",
	})
	use({
		"nvim-lualine/lualine.nvim",
		-- requires = { "nvim-tree/nvim-web-devicons", opt = true },
	})
	use({
		"akinsho/bufferline.nvim",
		tag = "*",
		-- requires = "nvim-tree/nvim-web-devicons",
	})
	use({
		"ellisonleao/gruvbox.nvim",
	})
	use({
		"rebelot/kanagawa.nvim",
	})
	use("oxfist/night-owl.nvim")
	use("olimorris/onedarkpro.nvim")

	-- LSP --
	use({ "VonHeikemen/lsp-zero.nvim", branch = "v4.x" })
	use({ "neovim/nvim-lspconfig" })
	-- use({ "hrsh7th/nvim-cmp" })
	use({ "hrsh7th/cmp-nvim-lsp" })
	use({
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",
		"neovim/nvim-lspconfig",
	})
	use({
		"hrsh7th/cmp-nvim-lsp",
		"hrsh7th/cmp-buffer",
		"hrsh7th/cmp-path",
		"hrsh7th/cmp-cmdline",
		"hrsh7th/nvim-cmp",
	})
	use({
		"L3MON4D3/LuaSnip",
		tag = "v2.*",
		run = "make install_jsregexp",
	})

	-- function --
	use({
		"numToStr/Comment.nvim",
		config = function()
			require("Comment").setup()
		end,
	})
	use({
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		config = function()
			require("nvim-autopairs").setup({})
		end,
	})
	use({
		"stevearc/conform.nvim",
	})
	use("lukas-reineke/indent-blankline.nvim")
	use({
		"sudormrfbin/cheatsheet.nvim",
		requires = {
			{ "nvim-telescope/telescope.nvim" },
			{ "nvim-lua/popup.nvim" },
			{ "nvim-lua/plenary.nvim" },
		},
	})
	use({
		"akinsho/toggleterm.nvim",
		tag = "*",
	})
	use({
		"ibhagwan/fzf-lua",
		requires = { "echasnovski/mini.icons" },
	})
	use({
		"nvim-treesitter/nvim-treesitter",
	})
	use({
		"MeanderingProgrammer/render-markdown.nvim",
		after = { "nvim-treesitter" },
	})
	use({ "nvimdev/lspsaga.nvim" })
	use("mrcjkb/rustaceanvim")
	--
end)
