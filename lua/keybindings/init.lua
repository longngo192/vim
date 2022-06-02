vim.g.mapleader = ' '
local map = vim.api.nvim_set_keymap
map('n', '<C-h>', '<C-w>h', { noremap = true, silent = false })
map('n', '<C-l>', '<C-w>l', { noremap = true, silent = false })
map('n', '<C-j>', '<C-w>j', { noremap = true, silent = false })
map('n', '<C-k>', '<C-w>k', { noremap = true, silent = false })
map('n', 'dl', ':t.<CR>', { noremap = true, silent = false })
map('i', '<A-Down>', '<ESC>:m.+1<CR>i', { noremap = true, silent = false })
map('n', '<A-Down>', '<ESC>:m.+1<CR>i', { noremap = true, silent = false })
map('n', 'te', '<ESC>:tabedit', { noremap = true, silent = false })
map('i', '<A-Up>', '<ESC>:m.-2<CR>i', { noremap = true, silent = false })
map('n', '<A-Up>', '<ESC>:m.-2<CR>i', { noremap = true, silent = false })
map('i', 'kl', '<ESC>', { noremap = true, silent = false })
map('i', '<S-Right>', '<ESC>v<Right>', { noremap = true, silent = false })
map('n', '<S-Right>', '<ESC>v<Right>', { noremap = true, silent = false })
map('i', '<S-Left>', '<ESC>v<Left>', { noremap = true, silent = false })
map('n', '<S-Left>', '<ESC>v<Left>', { noremap = true, silent = false })
map('n', '<S-Up>', '<ESC>v<Up>', { noremap = true, silent = false })
map('n', '<S-Down>', '<ESC>v<Down>', { noremap = true, silent = false })
map('n', ',', '<ESC>0', { noremap = true, silent = false })
map('n', '.', '<ESC>$', { noremap = true, silent = false })
map('n', '<leader>h', ':Prettier<CR>', { noremap = true, silent = false })
map('i', '<leader>h', '<ESC>:Prettier<CR>i', { noremap = true, silent = false })

map('n', '<leader>et', ':NvimTreeToggle<CR>', { noremap = true, silent = true })
map('n', '<leader>ef', ':NvimTreeFindFile<CR>', { noremap = true, silent = true })

map("n", "<C-u>", "<cmd>lua require('lspsaga.action').smart_scroll_with_saga(-1)<cr>",
  { noremap = true, silent = true })
map("n", "<C-d>", "<cmd>lua require('lspsaga.action').smart_scroll_with_saga(1)<cr>",
  { noremap = true, silent = true })
