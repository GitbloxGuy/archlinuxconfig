
return {
  'saghen/blink.cmp',
  dependencies = {
    'saghen/blink.lib',
    'rafamadriz/friendly-snippets',
  },
  
  -- Removed the crashing build function since we are using the Lua matcher instead
  
  ---@module 'blink.cmp'
  ---@type blink.cmp.Config
  opts = {
    keymap = { preset = 'super-tab' },

    completion = {
      documentation = { auto_show = false },
      ghost_text = { enabled = true },
    },

    sources = { default = { 'lsp', 'path', 'snippets', 'buffer' } },

    -- CHANGED HERE: Uses the pure Lua implementation to fix the startup crash
    fuzzy = { implementation = "lua" }
  },
}

