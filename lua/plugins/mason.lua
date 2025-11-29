local M = {}

function M.setup()
	require("mason").setup()
	require("mason-lspconfig").setup({
		-- On Mason, some packages have two names, e.g:
		-- terraform-ls terraformls
		--
		-- When installing/uninstalling via Mason:
		-- MasonInstall/MasonUninstall <package>,
		-- use the first name.
		--
		-- When installing/uninstalling via mason-lspconfig:
		-- LspInstall/LspUninstall <lsp>,
		-- use the second name. This name is also used in ensure_installed.
		-- TODO: Migrate to a markdown doc before merging.
		ensure_installed = {
			"pyright",
			"terraformls",
		},
	})
end

return M
