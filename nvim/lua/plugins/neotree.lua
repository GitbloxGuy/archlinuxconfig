return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  lazy = false,
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons", -- Requires a Nerd Font for file icons
    "MunifTanjim/nui.nvim",
  },
  keys = {
    { "<leader>e", "<cmd>Neotree toggle left<cr>", desc = "Toggle Neo-tree (Filesystem)" },
    { "<leader>ge", "<cmd>Neotree toggle git_status left<cr>", desc = "Toggle Neo-tree (Git Status)" },
  },
  opts = {
    filesystem = {
      filtered_items = {
        visible = true,
        hide_dotfiles = false,
        hide_gitignored = false,
      },
      follow_current_file = {
        enabled = true,
      },
      use_libuv_file_watcher = true,
    },
    window = {
      width = 30,
      mappings = {
        ["<space>"] = "none",
      },
    },
  },
  config = function(_, opts)
    require("neo-tree").setup(opts)
  end,
}
	
