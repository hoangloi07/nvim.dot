local modules = {
	-- Keymaps --
	"user/core/maps",
	-- Plugins list --
	"user/core/plugins",
	-- Setting for vim/nvim --
	"user/core/options",
	-- Call config functions plugins --
	"user/core/init_plugins",
	-- Auto command --
	"user/core/autocmd"
}


for _, mod in ipairs(modules) do
	local ok,_ = pcall(require,mod)
	if not ok then
		return
	end
end


