local M = {}

local function get_leader_key()
	local leader = vim.g.mapleader or "\\"
	return leader
end

local function collect_leader_keymaps()
	local modes = { "n", "v", "i", "x", "o", "t", "c" }
	local leader = get_leader_key()
	local keymaps = {}

	for _, mode in ipairs(modes) do
		local mode_maps = vim.api.nvim_get_keymap(mode)
		for _, map in ipairs(mode_maps) do
			local lhs = map.lhs or ""
			-- Check if it starts with leader (as space or <Leader>)
			if lhs:match("^" .. vim.pesc(leader)) or lhs:match("^<[Ll]eader>") then
				table.insert(keymaps, {
					mode = mode,
					lhs = lhs,
					desc = map.desc or map.rhs or "(no description)",
					map = map,
				})
			end
		end
	end

	-- Sort alphabetically by the key following leader
	table.sort(keymaps, function(a, b)
		local a_key = a.lhs:gsub("^" .. vim.pesc(leader), ""):gsub("^<[Ll]eader>", "")
		local b_key = b.lhs:gsub("^" .. vim.pesc(leader), ""):gsub("^<[Ll]eader>", "")
		return a_key < b_key
	end)

	return keymaps
end

local function format_keymap(keymap, left_padding)
	local lhs = keymap.lhs:gsub("^" .. vim.pesc(get_leader_key()), "<Leader>")
	local formatted_keymap = string.format("[%s] %s - %s", keymap.mode, lhs, keymap.desc)

	return string.rep(" ", left_padding) .. formatted_keymap
end

local function show_leader_maps()
	-- Percentages here are expressed as decimals, e.g. 0.8 = 80%.
	local MAX_WINDOW_WIDTH_PERCENT = 0.8
	local MAX_WINDOW_HEIGHT_PERCENT = 0.8

	-- # of lines of padding on the top and bottom of the window
	local VERTICAL_PADDING = 1
	-- # of chars of padding on the left and right edges of the window
	local HORIZONTAL_PADDING = 5

	local keymaps = collect_leader_keymaps()
	if #keymaps == 0 then
		vim.notify("No leader keymaps found", vim.log.levels.INFO)
		return
	end

	-- Format keymaps into lines
	local lines = {}
	for _ = 1, VERTICAL_PADDING do
		table.insert(lines, "")
	end

	for _, keymap in ipairs(keymaps) do
		table.insert(lines, format_keymap(keymap, HORIZONTAL_PADDING))
	end

	-- Calculate dynamic width based on longest line
	local max_line_length = 0
	for _, line in ipairs(lines) do
		max_line_length = math.max(max_line_length, vim.fn.strdisplaywidth(line))
	end

	local max_width = math.floor(vim.o.columns * MAX_WINDOW_WIDTH_PERCENT)
	-- We only add HORIZONTAL_PADDING here once since the left padding
	-- is already factored in.
	local width = math.min(max_line_length + HORIZONTAL_PADDING, max_width)

	-- Calculate dynamic height based on number of lines
	local max_height = math.floor(vim.o.lines * MAX_WINDOW_HEIGHT_PERCENT)
	local height = math.min(#lines + VERTICAL_PADDING, max_height)

	local row = math.floor((vim.o.lines - height) / 2)
	local col = math.floor((vim.o.columns - width) / 2)

	-- Create scratch buffer
	local buf = vim.api.nvim_create_buf(false, true)
	vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
	vim.api.nvim_buf_set_option(buf, "modifiable", false)
	vim.api.nvim_buf_set_option(buf, "bufhidden", "wipe")

	-- Open floating window
	local win = vim.api.nvim_open_win(buf, true, {
		relative = "editor",
		width = width,
		height = height,
		row = row,
		col = col,
		style = "minimal",
		border = "rounded",
		title = "LEADER KEYMAPS",
		title_pos = "center",
	})

	-- Set up keybindings to close the window
	local close_win = function()
		if vim.api.nvim_win_is_valid(win) then
			vim.api.nvim_win_close(win, true)
		end
	end

	vim.keymap.set("n", "<Esc>", close_win, { buffer = buf, nowait = true })
	vim.keymap.set("n", "q", close_win, { buffer = buf, nowait = true })
end

function M.setup()
	-- Create the :LeaderMaps user command
	vim.api.nvim_create_user_command("LeaderMaps", show_leader_maps, {
		desc = "Show all leader-based keymaps in a floating window",
	})
end

return M
