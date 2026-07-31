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
