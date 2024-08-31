local modules = {
	"user/plugins/lspzero",
	"user/plugins/reload",
	"user/plugins/NvimTree",
	"user/plugins/bufferline",
	"user/plugins/lualine",
	"user/plugins/mason",
	"user/plugins/cmp",
	"user/plugins/conform",
	"user/plugins/lsp-saga",
	"user/plugins/nvimdap",
}

for _, mod in ipairs(modules) do
	local ok, _ = pcall(require, mod)
	if not ok then
		return
	end
end
