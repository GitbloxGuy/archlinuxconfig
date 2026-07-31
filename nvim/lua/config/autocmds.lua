local numbergroup = vim.api.nvim_create_augroup("NumberToggle", { clear = true })

vim.api.nvim_create_autocmd({ "BufEnter", "FocusGained", "InsertLeave", "WinEnter" }, {
    pattern = "*",
    group = numbergroup,
    callback = function()
        if vim.o.number and vim.api.nvim_get_mode().mode ~= "i" then
            vim.opt.relativenumber = true
        end
    end,
})

vim.api.nvim_create_autocmd({ "BufLeave", "FocusLost", "InsertEnter", "WinLeave" }, {
    pattern = "*",
    group = numbergroup,
    callback = function()
        if vim.o.number then
            vim.opt.relativenumber = false
        end
    end,
})

vim.api.nvim_create_autocmd("VimEnter", {
	  callback = function()
		      vim.cmd("Neotree show")
		        end,
		})

vim.api.nvim_set_hl(0, "NeoTreeDirectoryName", { fg = "#d4af37", bold = true })

-- Change the folder icon color to match
vim.api.nvim_set_hl(0, "NeoTreeDirectoryIcon", { fg = "#d4af37" })

