local M = {}

local function escape_special_regex_chars(str)
	return (string.gsub(str, "([%^%$%(%)%%%.%[%]%*%+%-%?])", "%%%1"))
end

function M.setup()
	-- The module at this path is in .gitignore, allowing for per-editor config.
	local ok, ignored_names = pcall(require, "plugins.oil.oil_ignore")
	if not ok then
		ignored_names = {}
	end

	require("oil").setup({
		view_options = {
			show_hidden = true,
			is_always_hidden = function(name, bufnr)
				for _, file_name in ipairs(ignored_names) do
					local pattern = escape_special_regex_chars(file_name)
					if name:match(pattern) ~= nil then
						return true
					end
				end
				return false
			end,
		},
	})
end

return M
