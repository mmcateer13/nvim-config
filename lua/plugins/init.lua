local vim = vim
local Plug = vim.fn["plug#"]

-- Make calls to plugins here
vim.call("plug#begin")

-- Themes
-- https://vimcolorschemes.com
Plug("morhetz/gruvbox")
Plug("folke/tokyonight.nvim")

-- Telescope + dependencies
Plug("nvim-lua/plenary.nvim")
Plug("nvim-telescope/telescope.nvim", { ["tag"] = "0.1.8" })
Plug("nvim-treesitter/nvim-treesitter", { ["do"] = ":TSUpdate" })

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
Plug("mfussenegger/nvim-dap")
Plug("nvim-neotest/nvim-nio")
Plug("rcarriga/nvim-dap-ui")

-- Indent guidelines
Plug("lukas-reineke/indent-blankline.nvim")

-- Python debugging
-- TODO: Set up Python debugging
-- https://codeberg.org/mfussenegger/nvim-dap/wiki/Debug-Adapter-installation
-- Plug("mfussenegger/nvim-dap-python")

vim.call("plug#end")

-- Any extra config needed for plugins here
-- Call any setup here too, unless additional config is needed.
-- In that case, the setup is likely in its own module.
vim.cmd("silent! colorscheme tokyonight")
require("mini.icons").setup()
require("oil").setup()
require("nvim-treesitter.configs").setup({ highlight = { enable = true } })
require("mason").setup()
require("ibl").setup()
require("mason-lspconfig").setup()
require("plugins.cmp")
require("plugins.telescope")
require("plugins.gitblame")
require("plugins.dap")
