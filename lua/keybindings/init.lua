vim.g.mapleader = ' '
local map = vim.api.nvim_set_keymap
map('n', '<C-h>', '<C-w>h', { noremap = true, silent = false })
map('n', '<C-l>', '<C-w>l', { noremap = true, silent = false })
map('n', '<C-j>', '<C-w>j', { noremap = true, silent = false })
map('n', '<C-k>', '<C-w>k', { noremap = true, silent = false })
map('n', 'dl', ':t.<CR>', { noremap = true, silent = false })
map('i', '<A-Down>', '<ESC>:m.+1<CR>i', { noremap = true, silent = false })
map('n', 'te', ':tabedit', { noremap = true, silent = false })
map('n', 'q', ':tabclose<CR>', { noremap = true, silent = false })
map('i', '<A-Up>', '<ESC>:m.-2<CR>i', { noremap = true, silent = false })
map('n', '<A-k>', ':m.-2<CR>', { noremap = true, silent = false })
map('i', 'jk', '<ESC>', { noremap = true, silent = false })
map('i', 'kj', '<ESC>', { noremap = true, silent = false })

map('n', '<leader>e', ':NvimTreeToggle<CR>', { noremap = true, silent = true })

map('v', '<', '<gv', { noremap = true, silent = false })
map('v', '>', '>gv', { noremap = true, silent = false })
map('v', '<leader>tb', ':TransparentToggle<CR>', { noremap = true, silent = true })

map("n", "<C-u>", "<cmd>lua require('lspsaga.action').smart_scroll_with_saga(-1)<cr>",
  { noremap = true, silent = true })
map("n", "<C-d>", "<cmd>lua require('lspsaga.action').smart_scroll_with_saga(1)<cr>",
  { noremap = true, silent = true })
