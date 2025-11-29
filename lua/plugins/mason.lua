local M = {}

function M.setup()
	require("mason").setup()
	require("mason-lspconfig").setup({
		ensure_installed = {
			"pyright",
			"terraformls",
		},
	})
end

return M
