-- Line numbering
vim.opt.number = true
vim.opt.relativenumber = true

-- Search options
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.incsearch = true

-- Set leader to the Space bar
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Use spaces instead of tabs
vim.opt.expandtab = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4

-- Set colorcolumns for select file types.
-- autocmd ref: https://neovim.io/doc/user/api.html#nvim_create_autocmd()
local function set_cc_for_filetype(filetype_pattern, columns)
	vim.api.nvim_create_autocmd("FileType", {
		pattern = filetype_pattern,
		callback = function()
			vim.opt.colorcolumn = columns
		end,
	})
end

set_cc_for_filetype("*", "")
set_cc_for_filetype("python", "72,120")
set_cc_for_filetype("gitcommit", "50,72")
