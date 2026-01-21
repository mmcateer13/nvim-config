local M = {}

function M.setup()
	require("mason").setup()
	require("mason-lspconfig").setup({
		ensure_installed = {
			"elixirls",
			"lua_ls",
			"pyright",
			"rust_analyzer",
			"terraformls",
		},
	})
end

return M
