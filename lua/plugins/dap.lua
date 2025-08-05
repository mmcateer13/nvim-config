local dap, dapui, dap_python = require("dap"), require("dapui"), require("dap-python")

dapui.setup()
-- TODO: The following setup means that debugpy has to be installed in
-- the same virtual environment as other project deps. Might be worth
-- pointing this at a separate venv or building some sort of smart
-- discovery.
dap_python.setup(".venv/bin/python")

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

-- Function to auto-discover and load launch.json files on start
local vscode = require("dap.ext.vscode")
local function load_launchjs_and_continue()
	if vim.fn.filereadable(".vscode/launch.json") == 1 then
		vscode.load_launchjs()
	end
	dap.continue()
end

vim.keymap.set("n", "<Leader>dc", load_launchjs_and_continue, { desc = "DAP: Continue" })
vim.keymap.set("n", "<Leader>dov", dap.step_over, { desc = "DAP: Step Over" })
vim.keymap.set("n", "<Leader>di", dap.step_into, { desc = "DAP: Step Into" })
vim.keymap.set("n", "<Leader>dou", dap.step_out, { desc = "DAP: Step Out" })
vim.keymap.set("n", "<Leader>dt", dap.terminate, { desc = "DAP: Terminate Session" })
vim.keymap.set("n", "<Leader>dr", dap.restart, { desc = "DAP: Restart Session" })

vim.keymap.set("n", "<Leader>tb", dap.toggle_breakpoint, { desc = "DAP: Toggle Breakpoint" })
vim.keymap.set("n", "<Leader>dui", dapui.toggle, { desc = "DAP UI: Toggle" })
