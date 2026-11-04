# Plugins

## Keep
zbirenbaum/copilot.lua - copilot autocompletion
  - can probably find some kind of community plugin

folke/flash.nvim
  - I flash navigation using s and to search
  - Installed with community

```lua
return {
  'folke/flash.nvim',
  event = 'VeryLazy',
  config = function()
    local flash = require 'flash'
    flash.setup()
    flash.toggle()
  end,
  -- stylua: ignore
  keys = {
    { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
    { "S", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
    { "r", mode = "o", function() require("flash").remote() end, desc = "Remote Flash" },
    { "R", mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
    { "<c-s>", mode = { "c" }, function() require("flash").toggle() end, desc = "Toggle Flash Search" },
  },
}
```

folke/noice.nvim
  - Centered command line 

```lua
return {
  {
    'folke/noice.nvim',
    event = 'VeryLazy',
    dependencies = {
      'MunifTanjim/nui.nvim',
      -- notifications are optional but recommended
      'rcarriga/nvim-notify',
    },
    config = function()
      local has_noice, noice = pcall(require, 'noice')
      if not has_noice then
        return
      end

      noice.setup {
        -- route the command-line to a centered popup
        cmdline = {
          enabled = true,
          view = 'cmdline_popup',
          opts = {},
          format = {
            cmdline = { pattern = '^:', icon = ':', lang = 'vim' },
            search_up = { kind = 'search', pattern = '^/', icon = '/' },
            search_down = { kind = 'search', pattern = '^\\?', icon = '?' },
          },
        },

        views = {
          cmdline_popup = {
            position = { row = '50%', col = '50%' },
            size = { width = 60 },
            border = { style = 'rounded', padding = { 1, 1 } },
            win_options = { winhighlight = 'Normal:Normal' },
          },
          popupmenu = {
            position = { row = '55%', col = '50%' },
            size = { width = 60 },
            border = { style = 'rounded', padding = { 0, 1 } },
            win_options = { winhighlight = 'Normal:Normal' },
          },
        },

        presets = {
          command_palette = true,
          long_message_to_split = true,
        },
      }
    end,
  },
}
```

yorickpeterse/nvim-window
  - Nice window picker using letters.  I have it set up to use <leader><leader>
```lua
return {
  'yorickpeterse/nvim-window',
  keys = {
    { '<leader><leader>', "<cmd>lua require('nvim-window').pick()<cr>", desc = 'Jump to window' },
  },
  config = true,
}

```

nickjvandyke/opencode.nvim
 - opencode as a split

```lua
return {
  'nickjvandyke/opencode.nvim',
  version = '*', -- Latest stable release
  dependencies = {
    {
      -- `snacks.nvim` integration is recommended, but optional
      ---@module "snacks" <- Loads `snacks.nvim` types for configuration intellisense
      'folke/snacks.nvim',
      optional = true,
      opts = {
        input = {}, -- Enhances `ask()`
        picker = { -- Enhances `select()`
          actions = {
            opencode_send = function(...)
              return require('opencode').snacks_picker_send(...)
            end,
          },
          win = {
            input = {
              keys = {
                ['<a-a>'] = { 'opencode_send', mode = { 'n', 'i' } },
              },
            },
          },
        },
      },
    },
  },
  config = function()
    ---@type opencode.Opts
    vim.g.opencode_opts = {
      -- Your configuration, if any; goto definition on the type or field for details
    }

    vim.o.autoread = true -- Required for `opts.events.reload`

    -- Recommended/example keymaps
    vim.keymap.set({ 'n', 'x' }, '<leader>o?', function()
      require('opencode').ask('@this: ', { submit = true })
    end, { desc = 'Ask opencode…' })
    vim.keymap.set({ 'n', 'x' }, '<leader>oa', function()
      require('opencode').select()
    end, { desc = 'Execute opencode action…' })
    vim.keymap.set({ 'n', 't' }, '<leader>oo', function()
      require('opencode').toggle()
    end, { desc = 'Toggle opencode' })

    vim.keymap.set({ 'n', 'x' }, 'go', function()
      return require('opencode').operator '@this '
    end, { desc = 'Add range to opencode', expr = true })
    vim.keymap.set('n', 'goo', function()
      return require('opencode').operator '@this ' .. '_'
    end, { desc = 'Add line to opencode', expr = true })

    vim.keymap.set('n', '<C-k>', function()
      require('opencode').command 'session.half.page.up'
    end, { desc = 'Scroll opencode up' })
    vim.keymap.set('n', '<C-j>', function()
      require('opencode').command 'session.half.page.down'
    end, { desc = 'Scroll opencode down' })

    -- You may want these if you use the opinionated `<C-a>` and `<C-x>` keymaps above — otherwise consider `<leader>o…` (and remove terminal mode from the `toggle` keymap)
    vim.keymap.set('n', '+', '<C-a>', { desc = 'Increment under cursor', noremap = true })
    vim.keymap.set('n', '-', '<C-x>', { desc = 'Decrement under cursor', noremap = true })
  end,
}

```

natecraddock/workspaces.nvim
  - workspace management
```lua
return {
  'natecraddock/workspaces.nvim',
  config = function()
    require('workspaces').setup {
      hooks = {
        open = function()
          require('persisted').load {}
        end,
      },
    }
  end,
}
```

mikavilpas/yazi.nvim
  - yazi terminal browser, super cool
  - installed with community
```lua
return {
  {
    'mikavilpas/yazi.nvim',
    version = '*',
    event = 'VeryLazy',
    dependencies = {
      { 'nvim-lua/plenary.nvim', lazy = true },
    },
    keys = {
      {
        '<leader>-',
        mode = { 'n', 'v' },
        '<cmd>Yazi<cr>',
        desc = 'Open yazi at the current file',
      },
      {
        '<leader>\\',
        '<cmd>Yazi cwd<cr>',
        desc = "Open the file manager in nvim's working directory",
      },
      {
        '<c-up>',
        '<cmd>Yazi toggle<cr>',
        desc = 'Resume the last yazi session',
      },
    },
    ---@type YaziConfig | {}
    opts = {
      open_for_directories = false,
      keymaps = {
        show_help = '<f1>',
      },
      -- sensible defaults; tweak to your liking in this file or override per-call
      clipboard_register = '*',
    },
    -- don't hijack netrw by default; enable in opts.open_for_directories if desired
    -- init = function()
    --   vim.g.loaded_netrwPlugin = 1
    -- end,
  },
}
```

## Maybe keep
olimorris/persisted.nvim
 - looks like there is some other session manager so have to see if I still want this

anuvyklack/windows.nvim
  - I mainly only use it for the maximize equalize methods but not sure if I need it

dgagn/diagflow.nvim
  - Floating diagnostics, not sure if we need but need to see the 


# Things to change
I like the navigation with ctrl+hjkl but I would like a better way to resize splits



