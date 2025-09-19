local M = {}

local function string_is_empty(s)
	return s == nil or s == ""
end

function M.setup()
	-- Imports are usually ordered alphabetically, but not here.
	-- This order is needed so that keymaps are set with the correct leader key.
	require("myconfig.options")
	require("myconfig.keymaps")

	-- Attempt to load any project-specific settings
	local project_to_load = vim.env.NVIM_PROJECT_CONFIG_NAME
	if not string_is_empty(project_to_load) then
		module_path = "myconfig.projectconfigs." .. project_to_load
		local ok, module = pcall(require, module_path)
		if ok and type(module.setup) == "function" then
			module.setup()
		end
	end
end

return M
