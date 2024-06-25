-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- Open fugitive on leader g
vim.keymap.set("n", "<leader>g", "<Cmd>Git<CR>", { silent = true, noremap = true })

-- leader gb shows blame
vim.keymap.set("n", "<leader>gb", "<Cmd>Git blame<CR>", { silent = true, noremap = true })

vim.keymap.set("n", "<leader>fg", "<Cmd>Telescope git_status<CR>", { silent = true, noremap = true })

vim.keymap.set("n", "<leader>fn", "<Cmd>cn<CR>", { silent = true, noremap = true })
vim.keymap.set("n", "<leader>fp", "<Cmd>cp<CR>", { silent = true, noremap = true })

vim.keymap.set("n", "<leader>p", "<Cmd>!python %<CR>", { silent = true, noremap = true })
vim.keymap.set("n", "<C-6>", "<C-^>", { silent = true, noremap = true })

-- Stop ESC + j or k moving lines
vim.keymap.del("n", "<A-j>")
vim.keymap.del("n", "<A-k>")

-- Write all open files --
vim.keymap.set({ "n", "v" }, "<leader>w", ":wa!<CR><ESC>", { desc = "[W]rite open files" })
