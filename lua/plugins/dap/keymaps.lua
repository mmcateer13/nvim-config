local M = {}

local DAP, DAPUI, DAP_PYTHON = require("dap"), require("dapui"), require("dap-python")

local BREAKPOINT_KEYMAPS = {
	base = "<Leader>b",
	name = "DAP Breakpoint",
	keymaps = {
		{ key = "t", rhs = DAP.toggle_breakpoint, desc = "Toggle" },
		{
			key = "T",
			rhs = function()
				DAP.toggle_breakpoint(vim.fn.input("Breakpoint Condition: "))
			end,
			desc = "Conditional Breakpoint",
		},
		{ key = "c", rhs = DAP.clear_breakpoints, desc = "Clear All" },
	},
}

local DEBUG_KEYMAPS = {
	base = "<Leader>d",
	name = "DAP",
	keymaps = {
		{ key = "c", rhs = DAP.continue, desc = "Continue" },
		{ key = "o", rhs = DAP.step_over, desc = "Step Over" },
		{ key = "i", rhs = DAP.step_into, desc = "Step Into" },
		{ key = "u", rhs = DAP.step_out, desc = "Step Out" },
		{ key = "t", rhs = DAP.terminate, desc = "Terminate" },
		{ key = "r", rhs = DAP.restart, desc = "Restart" },
		{ key = "U", rhs = DAPUI.toggle, desc = "Toggle UI" },
		{
			key = "C",
			rhs = function()
				DAPUI.float_element("repl", { enter = true, title = "Debug Console" })
			end,
			desc = "Open Debug Console",
		},
	},
}

local DAP_PYTHON_KEYMAPS = {
	base = "<Leader>p",
	name = "DAP Python",
	keymaps = {
		{ key = "m", rhs = DAP_PYTHON.test_method, desc = "Debug Test Method" },
		{ key = "c", rhs = DAP_PYTHON.test_class, desc = "Debug Test Class" },
	},
}

local function add_keymap_category(category)
	for _, km in ipairs(category.keymaps) do
		local lhs = category.base .. km.key
		vim.keymap.set("n", lhs, km.rhs, { desc = category.name .. ": " .. km.desc })
	end
end

local function create_debug_hydra(debug_keymaps)
	local Hydra = require("hydra")
	local heads = {}
	for _, km in ipairs(debug_keymaps.keymaps) do
		table.insert(heads, { km.key, km.rhs, { desc = km.desc } })
	end
	table.insert(heads, { "q", nil, { exit = true, desc = "quit" } })
	table.insert(heads, { "<Esc>", nil, { exit = true } })

	Hydra({
		name = "DAP Hydra",
		mode = "n",
		body = debug_keymaps.base,
		config = {
			color = "amaranth",
			invoke_on_body = true,
		},
		heads = heads,
	})
end

function M.setup()
	add_keymap_category(BREAKPOINT_KEYMAPS)
	add_keymap_category(DAP_PYTHON_KEYMAPS)

	if vim.env.NVIM_DAP_HYDRA_ENABLED == "1" then
		create_debug_hydra(DEBUG_KEYMAPS)
	else
		add_keymap_category(DEBUG_KEYMAPS)
	end
end

return M
