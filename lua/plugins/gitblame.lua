local M = {}

function M.setup()
	vim.g.gitblame_delay = 1000
	require("gitblame").setup()
end

return M
