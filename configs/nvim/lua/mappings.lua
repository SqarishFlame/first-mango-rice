require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

-- map("<leader>fd", ":telescope diagnostics")
map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")
map("n", "<leader>fd", "<cmd>Telescope diagnostics<CR>", { desc = "Show diagnostics" })
-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")
