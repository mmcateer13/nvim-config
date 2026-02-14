local M = {}

function M.setup()
	vim.api.nvim_create_autocmd("LspAttach", {
		callback = function(args)
			local opts = { buffer = args.buf, noremap = true, silent = true }
			vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
			vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
			vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
			vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
		end,
	})

	local servers = { "elixirls", "lua_ls", "pyright", "rust_analyzer", "terraformls" }
	for _, server in ipairs(servers) do
		vim.lsp.enable(server)
	end
end

return M
