local M = {}

local MASON_PATH = vim.fn.stdpath("data") .. "/mason"

function M.setup()
	local dap = require("dap")

	dap.adapters.codelldb = {
		type = "executable",
		command = MASON_PATH .. "/packages/codelldb/extension/adapter/codelldb",
	}
end

return M
