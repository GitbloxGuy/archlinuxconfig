-- Press <leader>p to turn paste ON
vim.keymap.set("n", "<leader>p", "<cmd>set paste<CR>", { desc = "Enable paste mode" })

-- Press <leader>P to turn paste OFF
vim.keymap.set("n", "<leader>P", "<cmd>set nopaste<CR>", { desc = "Disable paste mode" })

-- Tab navigation
vim.keymap.set('n', '<Tab>', ':tabnext<CR>', { desc = 'Next tab' })
vim.keymap.set('n', '<S-Tab>', ':tabprevious<CR>', { desc = 'Previous tab' })
vim.keymap.set('n', '<leader>tn', ':tabnew<CR>', { desc = 'New tab' })
vim.keymap.set('n', '<leader>tc', ':tabclose<CR>', { desc = 'Close tab' })
vim.keymap.set('n', '<leader>to', ':tabonly<CR>', { desc = 'Close other tabs' })

-- Jump directly to tab by number (leader + 1-9)
for i = 1, 9 do
  vim.keymap.set('n', '<leader>' .. i, i .. 'gt', { desc = 'Go to tab ' .. i })
end

-- remaps

-- Delete without yank
vim.keymap.set({'n', 'x'}, 'd', '"_d', { desc = "Delete without copying" })
vim.keymap.set({'n', 'x'}, 'c', '"_c', { desc = "Change without copying" })
vim.keymap.set({'n', 'x'}, 'x', '"_x', { desc = "Delete char without copying" })

-- Map a new shortcut for "Cut" operations (if you actually want to copy + delete)
vim.keymap.set({'n', 'x'}, 'm', 'd', { desc = "Cut text (copy and delete)" })

-- Cut the current line with Shift + X
vim.keymap.set('n', 'X', 'dd', { desc = "Cut current line" })



-- Disable Ctrl+Z from suspending Neovim
vim.keymap.set({'n', 'v', 'i'}, '<C-z>', '<Nop>', { desc = "Disable suspend" })

