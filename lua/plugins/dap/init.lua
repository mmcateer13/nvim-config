local M = {}

function M.setup()
	local dap, dapui, dap_python = require("dap"), require("dapui"), require("dap-python")

	dap_python.setup(".venv/bin/python")
	dapui.setup({
		layouts = {
			{
				elements = {
					{
						id = "console",
						size = 1,
					},
				},
				position = "bottom",
				size = 15,
			},
			{
				elements = {
					{
						id = "scopes",
						size = 0.35,
					},
					{
						id = "breakpoints",
						size = 0.35,
					},
					{
						id = "stacks",
						size = 0.3,
					},
				},
				position = "left",
				size = 40,
			},
		},
	})

	-- Auto open/close of dap_ui on session start/end
	dap.listeners.before.attach.dapui_config = function()
		dapui.open()
	end
	dap.listeners.before.launch.dapui_config = function()
		dapui.open()
	end
	dap.listeners.before.event_terminated.dapui_config = function()
		dapui.close()
	end
	dap.listeners.before.event_exited.dapui_config = function()
		dapui.close()
	end

	require("plugins.dap.adapters").setup()
	require("plugins.dap.configurations").setup()
	require("plugins.dap.keymaps").setup()
end

return M
