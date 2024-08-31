local modules = {

	-- Default config for nvim or plugins
	"user/core/init",

	-- User config for plugins
	"user/plugins/init",
}

for _, mod in ipairs(modules) do
	local ok, _ = pcall(require, mod)
	if not ok then
		return
	end
end
