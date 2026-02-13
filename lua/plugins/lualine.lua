local M = {}

function M.setup()
	require("lualine").setup({
		sections = {
			lualine_c = { { "filename", path = 1 } },
			lualine_x = { "filetype", "lsp_status" },
		},
	})
end

return M
