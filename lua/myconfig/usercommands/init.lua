local M = {}

function M.setup()
	local leadermap = require("myconfig.usercommands.leadermap")

	vim.api.nvim_create_user_command("LeaderMaps", leadermap.show_leader_maps, {
		desc = "Show all leader-based keymaps in a floating window",
	})
end

return M
