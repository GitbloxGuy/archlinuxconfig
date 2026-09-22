return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  opts = {
    picker = {
      enabled = true,
      layout = { preset = "ivy" }, -- try "default", "dropdown", "vscode"
      matcher = { frecency = true },
      sources = {
        files = { hidden = true },
        grep  = { hidden = true },
      },
    },
  },
  keys = {
    { "<leader>a",       function() Snacks.picker.files({ cwd = Snacks.git.get_root() }) end, desc = "Files (git root)" },
    { "<leader><space>", function() Snacks.picker.smart() end,           desc = "Smart" },
    { "<leader>/",       function() Snacks.picker.grep() end,            desc = "Grep" },
    { "<leader>,",       function() Snacks.picker.buffers() end,         desc = "Buffers" },
    { "<leader>fr",      function() Snacks.picker.recent() end,          desc = "Recent" },
    { "<leader>fc",      function() Snacks.picker.files({ cwd = vim.fn.stdpath("config") }) end, desc = "Config files" },
    { "<leader>sw",      function() Snacks.picker.grep_word() end,       desc = "Grep word", mode = { "n", "x" } },
    { "<leader>sd",      function() Snacks.picker.diagnostics() end,     desc = "Diagnostics" },
    { "<leader>sh",      function() Snacks.picker.help() end,            desc = "Help" },
    { "<leader>sk",      function() Snacks.picker.keymaps() end,         desc = "Keymaps" },
    { "<leader>sR",      function() Snacks.picker.resume() end,          desc = "Resume" },
    { "<leader>gs",      function() Snacks.picker.git_status() end,      desc = "Git status" },
    { "<leader>gl",      function() Snacks.picker.git_log() end,         desc = "Git log" },
    { "gd",              function() Snacks.picker.lsp_definitions() end, desc = "Definition" },
    { "gr",              function() Snacks.picker.lsp_references() end,  nowait = true, desc = "References" },
    { "<leader>ss",      function() Snacks.picker.lsp_symbols() end,     desc = "Symbols" },
  },
}
