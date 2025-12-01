local M = {}

function M.setup()
	require("nvim-treesitter.configs").setup({
		ensure_installed = {
			"bash",
			"elixir",
			"json",
			"lua",
			"markdown",
			"python",
			"terraform",
			"toml",
			"yaml",
		},

		-- A note to self for some other options here where the documentation feels
		-- a little unclear:
		--
		-- sync_install: whether parser installs are synchronous, i.e. blocking.
		-- Enabling means full nvim startup will be blocked until installs are complete.
		--
		-- auto_install: whether missing parsers get pulled automatically. Fires
		-- when opening a buffer to edit a new filetype.
		sync_install = false,
		auto_install = false,

		highlight = { enable = true },
	})
end

return M
