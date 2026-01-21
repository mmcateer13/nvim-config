local M = {}

local vim = vim
local Plug = vim.fn["plug#"]

-- Make calls to plugins here
vim.call("plug#begin")

-- Themes
-- https://vimcolorschemes.com
Plug("morhetz/gruvbox")
Plug("folke/tokyonight.nvim")
Plug("tomasr/molokai")

-- Telescope + dependencies
Plug("nvim-lua/plenary.nvim")
Plug("nvim-telescope/telescope.nvim", { ["tag"] = "0.1.8" })
Plug("nvim-treesitter/nvim-treesitter", { ["branch"] = "master", ["do"] = ":TSUpdate" })

-- Oil + file icons
Plug("stevearc/oil.nvim")
Plug("echasnovski/mini.nvim", { ["branch"] = "stable" })

-- Mason
Plug("mason-org/mason.nvim")

-- LSP config + plugin to tie it to Mason
Plug("neovim/nvim-lspconfig")
Plug("mason-org/mason-lspconfig.nvim")

-- Autocomplete + sources
Plug("hrsh7th/nvim-cmp")
Plug("hrsh7th/cmp-nvim-lsp")
Plug("hrsh7th/cmp-path")

-- VSCode-style git blame
Plug("f-person/git-blame.nvim")

-- DAP
-- https://codeberg.org/mfussenegger/nvim-dap/wiki/Debug-Adapter-installation
Plug("mfussenegger/nvim-dap")
Plug("nvim-neotest/nvim-nio")
Plug("rcarriga/nvim-dap-ui")

-- Indent guidelines
Plug("lukas-reineke/indent-blankline.nvim")

-- Python debugging
Plug("mfussenegger/nvim-dap-python")

-- Git diff viewer
Plug("sindrets/diffview.nvim")
Plug("nvim-tree/nvim-web-devicons")

vim.call("plug#end")

function M.setup()
	require("ibl").setup()
	require("mini.icons").setup()
	require("plugins.cmp").setup()
	require("plugins.colorscheme").setup()
	require("plugins.dap").setup()
	require("plugins.gitblame").setup()
	require("plugins.mason").setup()
	require("plugins.oil").setup()
	require("plugins.telescope").setup()
	require("plugins.treesitter").setup()
end

return M
