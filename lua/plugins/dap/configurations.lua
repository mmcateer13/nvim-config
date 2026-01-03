local M = {}

function M.setup()
	local dap = require("dap")

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
