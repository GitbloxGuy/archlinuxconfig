-- ~/.config/nvim/lua/plugins/blink.lua
-- blink.cmp: fast completion engine for Neovim
-- https://cmp.saghen.dev

return {
  'saghen/blink.cmp',
  version = '1.*',
  event = 'InsertEnter',

  dependencies = {
    'rafamadriz/friendly-snippets', -- community snippet collection
  },

  ---@module 'blink.cmp'
  ---@type blink.cmp.Config
  opts = {
    keymap = {
      -- 'super-tab': <Tab> both cycles the menu and jumps snippet placeholders, VS Code style.
      -- <CR> only accepts when a suggestion is actually selected; otherwise it's a normal newline.
      preset = 'super-tab',

      ['<C-space>'] = { 'show', 'show_documentation', 'hide_documentation' },
      ['<C-e>'] = { 'hide', 'fallback' },

      -- <Tab>/<S-Tab> intentionally left untouched here — the 'super-tab' preset already
      -- gives <Tab> the right smart behavior (accept snippet placeholder, else accept the
      -- top match, else jump forward, else fallback to a real tab). Overriding it drops
      -- the accept step entirely, which is what happened in the previous version of this file.

      ['<C-p>'] = { 'select_prev', 'fallback' },
      ['<C-n>'] = { 'select_next', 'fallback' },

      ['<C-b>'] = { 'scroll_documentation_up', 'fallback' },
      ['<C-f>'] = { 'scroll_documentation_down', 'fallback' },
    },

    appearance = {
      -- 'mono' keeps icon spacing aligned when using a Nerd Font Mono variant.
      -- Use 'normal' if your terminal font is a regular (non-mono) Nerd Font.
      nerd_font_variant = 'mono',
    },

    completion = {
      accept = {
        -- auto-insert matching brackets for functions/methods, based on semantic tokens
        auto_brackets = { enabled = true },
      },

      menu = {
        border = 'none',
        draw = {
          treesitter = { 'lsp' }, -- syntax-highlight completion items via treesitter
        },
      },

      documentation = {
        auto_show = true,
        auto_show_delay_ms = 200,
        window = { border = 'none' },
      },

      ghost_text = { enabled = true }, -- preview the top match inline as you type
    },

    signature = {
      enabled = true, -- function signature help as you type arguments
      window = { border = 'none' },
    },

    sources = {
      -- order matters: earlier sources rank higher in the menu
      default = { 'lsp', 'path', 'snippets', 'buffer' },
    },

    -- prebuilt Rust fuzzy matcher when available, falls back to Lua with a warning otherwise
    fuzzy = { implementation = 'prefer_rust_with_warning' },
  },

  -- lets other plugins (e.g. lazydev.nvim) append to sources.default instead of overwriting it
  opts_extend = { 'sources.default' },

  -- `config` instead of a plain `opts` table so we can strip the documentation popup's
  -- background before setup(), and reapply it on `:colorscheme` since most themes clear
  -- custom highlights when they load.
  config = function(_, opts)
    local function set_highlights()
      -- 'NONE' makes the doc window transparent, letting your terminal/editor background
      -- show through instead of a solid fill. Same trick works for BlinkCmpMenu if you
      -- want the completion menu itself transparent too.
      vim.api.nvim_set_hl(0, 'BlinkCmpDoc', { bg = 'NONE' })
    end

    set_highlights()
    vim.api.nvim_create_autocmd('ColorScheme', { group = vim.api.nvim_create_augroup('BlinkCmpHighlights', {}), callback = set_highlights })

    require('blink.cmp').setup(opts)
  end,
}
