local vim = vim

-- local function -- imap(input, mapping)
--	vim.keymap.set("i", input, mapping)
-- end

-- imap('"', '""<Left>')
-- imap("'", "''<Left>")
-- imap("[", "[]<Left>")
-- imap("{", "{}<Left>")
-- imap("(", "()<Left>")

-- Cheeky lil' keybind for use with oil
vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })

-- Open diagnostics
vim.keymap.set("n", "<Leader>od", "<CMD>lua vim.diagnostic.open_float()<CR>", { desc = "Open diagnostic" })
