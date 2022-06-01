local opts = { noremap = true, silent = true }

-- Shorten function name
local keymap = vim.api.nvim_set_keymap

--Remap space as leader key
keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

vim.keymap.set({ "n", "i", "v", "x", "t", "c" }, "<C-W>h", "<cmd>lua require('config.windows').bwn('h')<CR>", opts)
vim.keymap.set({ "n", "i", "v", "x", "t", "c" }, "<C-W>j", "<cmd>lua require('config.windows').bwn('j')<CR>", opts)
vim.keymap.set({ "n", "i", "v", "x", "t", "c" }, "<C-W>k", "<cmd>lua require('config.windows').bwn('k')<CR>", opts)
vim.keymap.set({ "n", "i", "v", "x", "t", "c" }, "<C-W>l", "<cmd>lua require('config.windows').bwn('l')<CR>", opts)

keymap("n", "H", "<cmd>BufferLineMovePrev <CR>", opts)
keymap("n", "J", "<cmd>BufferLineCyclePrev <CR>", opts)
keymap("n", "<S-Tab>", "<cmd>BufferLineCyclePrev <CR>", opts)
keymap("n", "<Tab>", "<cmd>BufferLineCycleNext <CR>", opts)
keymap("n", "K", "<cmd>BufferLineCycleNext <CR>", opts)
keymap("n", "L", "<cmd>BufferLineMoveNext <CR>", opts)

vim.keymap.set({ "n", "o" }, "gs ", "<cmd>HopPattern<cr>", opts)

vim.keymap.set({ "n", "o" }, "s", "<cmd>HopChar2AC<cr>", opts)
vim.keymap.set({ "n", "o" }, "S", "<cmd>HopChar2BC<cr>", opts)

vim.keymap.set({ "n", "o", "v" }, "gj", "<cmd>HopLineStartAC<cr>", opts)
vim.keymap.set({ "n", "o", "v" }, "gk", "<cmd>HopLineStartBC<cr>", opts)

-- Resize with arrows
keymap("n", "<C-Up>", "<cmd>resize -2<CR>", opts)
keymap("n", "<C-Down>", "<cmd>resize +2<CR>", opts)
keymap("n", "<C-Left>", "<cmd>vertical resize -2<CR>", opts)
keymap("n", "<C-Right>", "<cmd>vertical resize +2<CR>", opts)

-- Visual --
-- Stay in indent mode
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- Move text up and down
keymap("v", "<A-j>", "<cmd>m .+1<CR>==", opts)
keymap("v", "<A-k>", "<cmd>m .-2<CR>==", opts)
keymap("v", "p", '"_dP', opts)

-- Visual Block --
-- Move text up and down
keymap("x", "J", "<cmd>move '>+1<CR>gv-gv", opts)
keymap("x", "K", "<cmd>move '<-2<CR>gv-gv", opts)
keymap("x", "<A-j>", "<cmd>move '>+1<CR>gv-gv", opts)
keymap("x", "<A-k>", "<cmd>move '<-2<CR>gv-gv", opts)

-- Terminal --

-- local term_opts = { silent = true }

-- Better terminal navigation
-- keymap("t", "<C-h>", "<C-\\><C-N><C-w>h", term_opts)
-- keymap("t", "<C-j>", "<C-\\><C-N><C-w>j", term_opts)
-- keymap("t", "<C-k>", "<C-\\><C-N><C-w>k", term_opts)
-- keymap("t", "<C-l>", "<C-\\><C-N><C-w>l", term_opts)

-- keymap("n", "<leader>f", "<cmd>Telescope find_files<cr>", opts)
-- keymap("n", "<leader>f", "<cmd>lua require'telescope.builtin'.find_files(require('telescope.themes').get_dropdown({ previewer = false }))<cr>", opts)
-- keymap("n", "<c-t>", "<cmd>Telescope live_grep<cr>", opts)
