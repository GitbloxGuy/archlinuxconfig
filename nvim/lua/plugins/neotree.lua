
return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  lazy = false,
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons", -- Requires a Nerd Font for file icons
    "MunifTanjim/nui.nvim",
    "nvim-telescope/telescope.nvim",
  },
  keys = {
    { "<leader>e", "<cmd>Neotree toggle left<cr>", desc = "Toggle Neo-tree (Filesystem)" },
    { "<leader>ge", "<cmd>Neotree toggle git_status left<cr>", desc = "Toggle Neo-tree (Git Status)" },
  },
  opts = {
    default_component_configs = {
      git_status = {
        symbols = {
          added     = "✚",
          modified  = "",
          deleted   = "✖",
          renamed   = "  ",
          untracked = "",
          ignored   = "",
          unstaged  = "  ",
          staged    = "",
          conflict  = "",
        },
      },
    },
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
      commands = {
        fuzzy_jump_dir = function(state)
          local has_telescope, telescope = pcall(require, "telescope.builtin")
          if not has_telescope then
            vim.notify("Telescope is still installing!", vim.log.levels.WARN)
            return
          end

          telescope.find_files({
            prompt_title = "Jump to Folder",
            find_command = { "fd", "--type", "d", "--hidden", "--exclude", ".git" },
            attach_mappings = function(prompt_bufnr, map)
              local actions = require("telescope.actions")
              local action_state = require("telescope.actions.state")
              
              actions.select_default:replace(function()
                actions.close(prompt_bufnr)
                local selection = action_state.get_selected_entry()
                if selection then
                  -- FIXED: Convert the path to an absolute path so Neo-tree doesn't crash
                  local target_dir = vim.fn.fnamemodify(selection.value, ":p")
                  
                  require("neo-tree.command").execute({
                    action = "show",
                    reveal = true,
                    reveal_file = target_dir,
                  })
                end
              end)
              return true
            end,
          })
        end,
      },
    },
    window = {
      width = 30,
      mappings = {
        ["<space>"] = "none",
        ["Z"] = "fuzzy_jump_dir", -- Press Capital Z inside Neo-tree to search folders
      },
    },
  },
  config = function(_, opts)
    vim.api.nvim_set_hl(0, "NeoTreeGitUntracked", { fg = "#edece8", italic = true })
    require("neo-tree").setup(opts)
  end,
}

