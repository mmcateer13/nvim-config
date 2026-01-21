local M = {}

function M.setup()
	local dap, dapui, dap_python = require("dap"), require("dapui"), require("dap-python")
	local vscode = require("dap.ext.vscode")

	-- Breakpoints
	vim.keymap.set("n", "<Leader>bt", dap.toggle_breakpoint, { desc = "DAP: Toggle Breakpoint" })
	vim.keymap.set("n", "<Leader>bT", function()
		dap.toggle_breakpoint(vim.fn.input("Breakpoint Condition: "))
	end, { desc = "DAP: Conditional Breakpoint" })
	vim.keymap.set("n", "<Leader>bc", dap.clear_breakpoints, { desc = "DAP: Clear All Breakpoints" })

	-- Debugging
	vim.keymap.set("n", "<Leader>dc", function()
		if vim.fn.filereadable(".vscode/launch.json") == 1 then
			vscode.load_launchjs()
		end
		dap.continue()
	end, { desc = "DAP: Continue" })
	vim.keymap.set("n", "<Leader>dov", dap.step_over, { desc = "DAP: Step Over" })
	vim.keymap.set("n", "<Leader>di", dap.step_into, { desc = "DAP: Step Into" })
	vim.keymap.set("n", "<Leader>dou", dap.step_out, { desc = "DAP: Step Out" })
	vim.keymap.set("n", "<Leader>dt", dap.terminate, { desc = "DAP: Terminate Session" })
	vim.keymap.set("n", "<Leader>dr", dap.restart, { desc = "DAP: Restart Session" })

	-- DAP-Python
	vim.keymap.set("n", "<Leader>ptm", dap_python.test_method, { desc = "DAP Python: Debug Test Method" })
	vim.keymap.set("n", "<Leader>ptc", dap_python.test_class, { desc = "DAP Python: Debug Test Class" })

	-- DAP-UI
	vim.keymap.set("n", "<Leader>ddc", function()
		dapui.float_element("repl", { enter = true, title = "Debug Console" })
	end, { desc = "DAP UI: Open Debug Console" })
	vim.keymap.set("n", "<Leader>dui", dapui.toggle, { desc = "DAP UI: Toggle" })
end

return M
