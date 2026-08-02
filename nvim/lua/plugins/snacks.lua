
return {
  "folke/snacks.nvim",
  priority = 1000, -- Load early for crucial UI replacements
  lazy = false,    -- Must be false so snacks handles early hooks properly
  opts = {
    picker = { 
      enabled = true,
      sources = {
        explorer = { 
          hidden = true,     -- Shows dotfiles
          git_status = true, -- FORCES git status checks on files
        },
      },
      icons = {
        git = {
          staged    = "●", 
          added     = "A", 
          deleted   = "D", 
          modified  = "M", 
          renamed   = "R", 
          untracked = "U", 
          ignored   = "◌", 
        },
      },
    }, 
    explorer = {
      enabled = true,
    },
  },
  keys = {
    {
      "<leader>a",
      function()
        -- Forces snacks to look for the current git root when launching
        Snacks.picker.explorer({ cwd = Snacks.git.get_root() })
      end,
      desc = "File Explorer",
    },
  },
}

