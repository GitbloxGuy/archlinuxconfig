
return {
  "stevearc/conform.nvim",
  event = { "BufReadPre", "BufNewFile" }, -- Lazy load on file open
  config = function()
    local conform = require("conform")

    conform.setup({
      formatters_by_ft = {
        lua = { "stylua" },
        python = { "isort", "black" },
        rust = { "rustfmt", lsp_format = "fallback" },
        javascript = { "prettierd", "prettier", stop_after_first = true },
      },

      format_on_save = {
        timeout_ms = 500,
        lsp_format = "fallback",
      },
    })

    -- Manual formatting keymap (Press <leader>f in normal or visual mode)
    vim.keymap.set({ "n", "v" }, "<leader>f", function()
      conform.format({
        lsp_format = "fallback",
        async = false,
        timeout_ms = 500,
      })
    end, { desc = "Format file or range" })
  end,
}

