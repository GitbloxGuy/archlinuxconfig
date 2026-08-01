
return {
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    opts = {
      -- 1. Change the line character style
      indent = { 
        char = "┊", -- Options: "│", "▎", "┆", "┊", "╎"
      },
      -- 2. Define the active current-scope line style
      scope = {
        char = "┊", -- Makes the current scope line thicker
        highlight = "IblScope",
      },
    },
    config = function(_, opts)
      -- 3. Set custom line colors using Neovim's highlight API
      local hooks = require("ibl.hooks")
      hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
        -- Passive lines (subtle dark grey)
        vim.api.nvim_set_hl(0, "IblIndent", { fg = "#3d3938" })
        -- Active current scope line (bright cyan/blue matching your style)
        vim.api.nvim_set_hl(0, "IblScope", { fg = "#3B4252" })

      end)

      require("ibl").setup(opts)
    end,
  }
}

