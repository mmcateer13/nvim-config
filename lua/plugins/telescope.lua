local builtin = require("telescope.builtin")
local utils = require("telescope.utils")

vim.keymap.set("n", "<Leader>ff", builtin.find_files, { desc = "Telescope: Find Files" })
vim.keymap.set("n", "<Leader>fg", builtin.live_grep, { desc = "Telescope: Live Grep" })
vim.keymap.set("n", "<Leader>fb", builtin.buffers, { desc = "Telescope: Buffers" })
vim.keymap.set("n", "<Leader>fh", builtin.help_tags, { desc = "Telescope: Help Tags" })

vim.keymap.set("n", "<Leader>FF", function()
	builtin.find_files({
		cwd = utils.buffer_dir(),
	})
end, { desc = "Telescope: Find Files in Buffer Dir" })

vim.keymap.set("n", "<Leader>FG", function()
	builtin.live_grep({
		cwd = utils.buffer_dir(),
	})
end, { desc = "Telescope: Live Grep in Buffer Dir" })

local function resolve_search_path(rel_path)
	return vim.fn.fnamemodify(rel_path, ":p")
end

local function validate_search_path(search_path)
	-- Check path exists and is a directory
	local stat = vim.uv.fs_stat(search_path)
	if not stat or stat.type ~= "directory" then
		return false
	end

	-- Check said directory is either the same as
	-- the CWD or is within it.
	local cwd = vim.fn.getcwd()

	local abs_search_path = vim.fn.fnamemodify(search_path, ":p")
	local abs_cwd = vim.fn.fnamemodify(cwd, ":p")

	if abs_search_path == abs_cwd then
		return true
	end

	-- Check that the CWD is present in the search string, so
	-- that we know the search path is within the CWD and not
	-- outside it.
	return abs_search_path:sub(1, #abs_cwd) == abs_cwd
end

vim.api.nvim_create_user_command("FindFilesInDir", function(args)
	abs_path = resolve_search_path(args.fargs[1])
	if not validate_search_path(abs_path) then
		print("Error: Path is invalid")
		return
	end
	builtin.find_files({ cwd = abs_path })
end, { nargs = 1, complete = "dir_in_path" })

vim.api.nvim_create_user_command("LiveGrepInDir", function(args)
	abs_path = resolve_search_path(args.fargs[1])
	if not validate_search_path(abs_path) then
		print("Error: Path is invalid")
		return
	end
	builtin.live_grep({ cwd = abs_path })
end, { nargs = 1, complete = "dir_in_path" })
