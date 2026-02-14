local M = {}

function M.setup()
	local treesitter = require("nvim-treesitter")
	treesitter.setup({ install_dir = vim.fn.stdpath("data") .. "/site" })

	-- Lua and Markdown now already come bundled with Neovim, so do not
	-- install them here.
	local core_parsers = { "lua", "markdown" }
	local non_core_parsers = {
		"bash",
		"elixir",
		"json",
		"python",
		"rust",
		"terraform",
		"toml",
		"yaml",
	}
	treesitter.install(non_core_parsers)

	local parsers_to_load = vim.list_extend(vim.deepcopy(core_parsers), non_core_parsers)
	vim.api.nvim_create_autocmd("FileType", {
		pattern = parsers_to_load,
		callback = function()
			vim.treesitter.start()
		end,
	})
end

return M
