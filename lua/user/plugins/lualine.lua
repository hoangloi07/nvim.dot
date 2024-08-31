local function get_attached_clients()
	local buf_clients = vim.lsp.get_active_clients({ bufnr = 0 })
	if #buf_clients == 0 then
		return ""
	end

	local buf_ft = vim.bo.filetype
	local buf_client_names = {}

	-- add client
	for _, client in pairs(buf_clients) do
		if client.name ~= "copilot" and client.name ~= "null-ls" then
			table.insert(buf_client_names, client.name)
			-- return "LSP"
		end
	end

	-- Generally, you should use either null-ls or nvim-lint + formatter.nvim, not both.
	-- Add sources (from null-ls)
	-- null-ls registers each source as a separate attached client, so we need to filter for unique names down below.
	local null_ls_s, null_ls = pcall(require, "null-ls")
	if null_ls_s then
		local sources = null_ls.get_sources()
		for _, source in ipairs(sources) do
			if source._validated then
				for ft_name, ft_active in pairs(source.filetypes) do
					if ft_name == buf_ft and ft_active then
						table.insert(buf_client_names, source.name)
					end
				end
			end
		end
	end

	-- Add linters (from nvim-lint)
	local lint_s, lint = pcall(require, "lint")
	if lint_s then
		for ft_k, ft_v in pairs(lint.linters_by_ft) do
			if type(ft_v) == "table" then
				for _, linter in ipairs(ft_v) do
					if buf_ft == ft_k then
						table.insert(buf_client_names, linter)
					end
				end
			elseif type(ft_v) == "string" then
				if buf_ft == ft_k then
					table.insert(buf_client_names, ft_v)
				end
			end
		end
	end

	-- Add formatters (from formatter.nvim)
	local formatter_s, _ = pcall(require, "formatter")
	if formatter_s then
		local formatter_util = require("formatter.util")
		for _, formatter in ipairs(formatter_util.get_available_formatters_for_ft(buf_ft)) do
			if formatter then
				table.insert(buf_client_names, formatter)
			end
		end
	end

	-- This needs to be a string only table so we can use concat below
	local unique_client_names = {}
	for _, client_name_target in ipairs(buf_client_names) do
		local is_duplicate = false
		for _, client_name_compare in ipairs(unique_client_names) do
			if client_name_target == client_name_compare then
				is_duplicate = true
			end
		end
		if not is_duplicate then
			table.insert(unique_client_names, client_name_target)
		end
	end

	local client_names_str = table.concat(unique_client_names, ", ")
	local language_servers = string.format("[%s]", client_names_str)

	return language_servers
end

local attached_clients = {
	get_attached_clients,
	color = {
		-- fg = "#ffffff",
		-- gui = "bold",
	},
}

require("lualine").setup({
	options = {
		icons_enabled = true,
		theme = "auto",
		component_separators = { left = "", right = "" },
		section_separators = { left = "", right = "" },
		disabled_filetypes = {
			statusline = {},
			winbar = {},
			"packer",
			"NvimTree",
			"toggleterm",
			"starter",
			"dapui_stacks",
			"dapui_watches",
			"dapui_scopes",
			"dapui_console",
			"dap-repl",
			"dapui_breakpoints",
		},
		ignore_focus = {},
		always_divide_middle = true,
		globalstatus = false,
		refresh = {
			statusline = 1000,
			tabline = 1000,
			winbar = 1000,
		},
	},
	-- sections = {
	-- 	lualine_a = {
	-- 		{
	-- 			"mode",
	-- 		},
	-- 	},
	-- 	lualine_b = { "branch", "diff", "diagnostics" },
	-- 	lualine_c = { "filename" },
	-- 	lualine_x = { "encoding", "filetype" },
	-- 	lualine_y = { attached_clients },
	-- 	lualine_z = {--[['location',]]
	-- 		"progress",
	-- 	},
	-- },
	-- inactive_sections = {
	-- 	lualine_a = {},
	-- 	lualine_b = {},
	-- 	lualine_c = { "filename" },
	-- 	lualine_x = { "location" },
	-- 	lualine_y = {},
	-- 	lualine_z = {},
	-- },
	sections = {
		lualine_a = {},
		lualine_b = {},
		lualine_c = { "mode", "filename" },
		lualine_x = { attached_clients, "location" },
		lualine_y = {},
		lualine_z = {},
	},
	inactive_sections = {
		lualine_a = {},
		lualine_b = {},
		lualine_c = { "filename" },
		lualine_x = { "location" },
		lualine_y = {},
		lualine_z = {},
	},
	tabline = {},
	winbar = {},
	inactive_winbar = {},
	extensions = {},
})
