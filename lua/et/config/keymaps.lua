local map = vim.keymap.set
--

map("i", "jk", "<Esc>", { desc = "Return to normal mode" })
map("n", "<leader>w", "<cmd>w<cr>", { desc = "Save buffer" })
map("n", "<leader>W", "<cmd>wa<cr>", { desc = "Save buffer" })

-- lua execution
map("n", "<space><space>x", "<cmd>source %<CR>", { desc = "Source current file"})
map("n", "<space><space>X", ":.lua<CR>", { desc = "Source current file"})
map("v", "<space><space>X", ":lua<CR>", { desc = "Source current file"})
-- Stay in indent mode
map("v", "<", "<gv", { desc = "indent left" })
map("v", ">", ">gv", { desc = "indent right" })

map("x", "p", [["_dP]], { desc = "don't delete to clipboard" })

--  set keyboard layout
map("n", "<space>keu", "<CMD>!setxkbmap eu<CR>", {desc = "set keyboard mapping to 'EU'"})
map("n", "<space>kfi", "<CMD>!setxkbmap fi<CR>", {desc = "set keyboard mapping to 'FI'"})
-- lazy
map("n", "<leader>l", "<cmd>Lazy<cr>", { desc = "Lazy" })
-- Mason
map("n", "<leader>M", "<cmd>Mason<cr>", { desc = "Mason" })

-- better up/down
map({ "n", "x" }, "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
map({ "n", "x" }, "<Down>", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
map({ "n", "x" }, "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
map({ "n", "x" }, "<Up>", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })

-- Move to window using the <ctrl> hjkl keys
map("n", "<C-h>", "<C-w>h", { desc = "Go to left window", remap = true })
map("n", "<C-j>", "<C-w>j", { desc = "Go to lower window", remap = true })
map("n", "<C-k>", "<C-w>k", { desc = "Go to upper window", remap = true })
map("n", "<C-l>", "<C-w>l", { desc = "Go to right window", remap = true })

-- Resize window using <ctrl> arrow keys
map("n", "<C-Up>", "<cmd>resize +2<cr>", { desc = "Increase window height" })
map("n", "<C-Down>", "<cmd>resize -2<cr>", { desc = "Decrease window height" })
map("n", "<C-Left>", "<cmd>vertical resize -2<cr>", { desc = "Decrease window width" })
map("n", "<C-Right>", "<cmd>vertical resize +2<cr>", { desc = "Increase window width" })

-- Move Lines
map("n", "<A-j>", "<cmd>m .+1<cr>==", { desc = "Move down" })
map("n", "<A-k>", "<cmd>m .-2<cr>==", { desc = "Move up" })
map("i", "<A-j>", "<esc><cmd>m .+1<cr>==gi", { desc = "Move down" })
map("i", "<A-k>", "<esc><cmd>m .-2<cr>==gi", { desc = "Move up" })
map("v", "<A-j>", ":m '>+1<cr>gv=gv", { desc = "Move down" })
map("v", "<A-k>", ":m '<-2<cr>gv=gv", { desc = "Move up" })

-- buffers
map("n", "<S-h>", "<cmd>bprevious<cr>", { desc = "Prev buffer" })
map("n", "<S-l>", "<cmd>bnext<cr>", { desc = "Next buffer" })
map("n", "<leader>bb", "<cmd>e #<cr>", { desc = "Switch to Other Buffer" })
map("n", "<leader>bd", function()
  Snacks.bufdelete()
end, { desc = "Delete Buffer" })
map("n", "<leader>bo", function()
  Snacks.bufdelete.other()
end, { desc = "Delete Other Buffers" })
map("n", "<leader>bD", "<cmd>:bd<cr>", { desc = "Delete Buffer and Window" })
-- floating terminal
map("n", "<leader>fT", function() Snacks.terminal() end, { desc = "Terminal (cwd)" })
map("n", "<leader>ft", function() Snacks.terminal(nil, { cwd = LazyVim.root() }) end, { desc = "Terminal (Root Dir)" })

-- Clear search with <esc>
map({ "i", "n" }, "<esc>", "<cmd>noh<cr><esc>", { desc = "Escape and clear hlsearch" })

-- Keymaps for better default experience
-- See `:help map()`
map({ "n", "v" }, "<Space>", "<Nop>", { silent = true })

-- Remap for dealing with word wrap
map("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
map("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Diagnostic keymaps
map("n", "d[", vim.diagnostic.goto_prev, { desc = "Go to previous diagnostic message" })
map("n", "d]", vim.diagnostic.goto_next, { desc = "Go to next diagnostic message" })
map("n", "<leader>de", vim.diagnostic.open_float, { desc = "Open floating diagnostic message" })
map("n", "<leader>dq", vim.diagnostic.setloclist, { desc = "Open diagnostics list" })
