local keymap = vim.keymap
local opts = { noremap = true, silent = true }

keymap.set("n", "x", '"_x')

-- Increment/decrement
keymap.set("n", "+", "<C-a>")
keymap.set("n", "-", "<C-x>")

-- Select all
keymap.set("n", "<C-a>", "gg<S-v>G")

-- Copy and paste from different registers
keymap.set({ "n", "v" }, "<leader>y", '"+y', opts)
keymap.set({ "n", "v" }, "<leader>p", '"+p', opts)

-- Save file and quit
keymap.set("n", "<Leader>w", ":update<Return>", opts)
keymap.set("n", "<Leader>q", ":quit<Return>", opts)
keymap.set("n", "<Leader>Q", ":qa<Return>", opts)

-- File explorer with NeoTree
keymap.set("n", "<Leader>t", ":Neotree filesystem reveal float toggle<Return>", opts)

-- Tabs
keymap.set("n", "te", ":tabedit")
keymap.set("n", "<tab>", ":tabnext<Return>", opts)
keymap.set("n", "<s-tab>", ":tabprev<Return>", opts)
keymap.set("n", "tw", ":tabclose<Return>", opts)

-- Split window
keymap.set("n", "ss", ":split<Return>", opts)
keymap.set("n", "sv", ":vsplit<Return>", opts)

-- Move window
keymap.set("n", "sh", "<C-w>h")
keymap.set("n", "sk", "<C-w>k")
keymap.set("n", "sj", "<C-w>j")
keymap.set("n", "sl", "<C-w>l")

-- Resize window
keymap.set("n", "<C-S-h>", "<C-w><")
keymap.set("n", "<C-S-l>", "<C-w>>")
keymap.set("n", "<C-S-k>", "<C-w>+")
keymap.set("n", "<C-S-j>", "<C-w>-")

keymap.set("n", "<left>", '<cmd>echo "Press H"<CR>')
keymap.set("n", "<right>", '<cmd>echo "Press L"<CR>')
keymap.set("n", "<up>", '<cmd>echo "Press K"<CR>')
keymap.set("n", "<down>", '<cmd>echo "Press J"<CR>')

-- LSP
vim.keymap.set("n", "<leader>lr", ":LspRestart<Return>")

-- nvim-notify
vim.keymap.set("n", "<leader>uH", ":Notifications<Return>")
