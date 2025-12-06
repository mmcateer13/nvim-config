local M = {}

local MASON_PATH = vim.fn.stdpath("data") .. "/mason"

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

	-- Function to auto-discover and load launch.json files on start
	local vscode = require("dap.ext.vscode")
	local function load_launchjs_and_continue()
		if vim.fn.filereadable(".vscode/launch.json") == 1 then
			vscode.load_launchjs()
		end
		dap.continue()
	end

	local function set_conditional_breakpoint()
		dap.toggle_breakpoint(vim.fn.input("Breakpoint Condition: "))
	end

	-- DAP Keymaps
	vim.keymap.set("n", "<Leader>tb", dap.toggle_breakpoint, { desc = "DAP: Toggle Breakpoint" })
	vim.keymap.set("n", "<Leader>tB", set_conditional_breakpoint, { desc = "DAP: Conditional Breakpoint" })
	vim.keymap.set("n", "<Leader>cb", dap.clear_breakpoints, { desc = "DAP: Clear All Breakpoints" })

	vim.keymap.set("n", "<Leader>dc", load_launchjs_and_continue, { desc = "DAP: Continue" })
	vim.keymap.set("n", "<Leader>dov", dap.step_over, { desc = "DAP: Step Over" })
	vim.keymap.set("n", "<Leader>di", dap.step_into, { desc = "DAP: Step Into" })
	vim.keymap.set("n", "<Leader>dou", dap.step_out, { desc = "DAP: Step Out" })
	vim.keymap.set("n", "<Leader>dt", dap.terminate, { desc = "DAP: Terminate Session" })
	vim.keymap.set("n", "<Leader>dr", dap.restart, { desc = "DAP: Restart Session" })

	-- DAP-Python Keymaps
	vim.keymap.set("n", "<Leader>ptm", dap_python.test_method, { desc = "DAP Python: Debug Test Method" })
	vim.keymap.set("n", "<Leader>ptc", dap_python.test_class, { desc = "DAP Python: Debug Test Class" })

	-- DAP-UI Keymaps
	local function open_repl()
		dapui.float_element("repl", { enter = true, title = "Debug Console" })
	end

	vim.keymap.set("n", "<Leader>ddc", open_repl, { desc = "DAP UI: Open Debug Console" })
	vim.keymap.set("n", "<Leader>dui", dapui.toggle, { desc = "DAP UI: Toggle" })

	-- Rust config
	-- TODO: Refactor any lang-specific behaviour into their own modules.
	dap.adapters.codelldb = {
		type = "executable",
		command = MASON_PATH .. "/packages/codelldb/extension/adapter/codelldb",
	}
	dap.configurations.rust = {
		-- I looked into replacing "program" with "cargo" here,
		-- as per the codelldb docs... but at the moment, it seems
		-- nvim-dap requires a "program" argument. The below solution
		-- to skip prompting for the binary name by using an
		-- environment variable more than works for now.
		{
			name = "Debug Rust binary",
			type = "codelldb",
			request = "launch",
			program = function()
				bin_dir = vim.fn.getcwd() .. "/target/debug/"

				bin_name = vim.env.NVIM_DEBUG_RUST_BINARY
				if bin_name == nil then
					bin_path = vim.fn.input("Path to executable: ", bin_dir, "file")
				else
					bin_path = bin_dir .. bin_name
				end

				return bin_path
			end,
			cwd = "${workspaceFolder}",
			stopOnEntry = false,
		},
	}
end

return M
