return function()
  vim.pack.add({
    { src = 'https://github.com/ThePrimeagen/harpoon', version = 'harpoon2' },
  }, { load = function() end })

  require('lz.n').load {
    {
      'harpoon',
      keys = {
        { '<leader>a', desc = 'Harpoon add file' },
        { '<C-e>', desc = 'Harpoon menu' },
        { '<C-t>', desc = 'Harpoon select 1' },
        { '<C-n>', desc = 'Harpoon select 2' },
        { '<C-s>', desc = 'Harpoon select 3' },
        { '<C-S-P>', desc = 'Harpoon prev' },
        { '<C-S-N>', desc = 'Harpoon next' },
      },
      after = function()
        local harpoon = require 'harpoon'
        harpoon:setup {
          settings = {
            save_on_toggle = true,
            sync_on_ui_close = true,
          },
        }
        vim.keymap.set('n', '<leader>a', function()
          harpoon:list():add()
        end)
        vim.keymap.set('n', '<C-e>', function()
          harpoon.ui:toggle_quick_menu(harpoon:list())
        end)
        vim.keymap.set('n', '<C-t>', function()
          harpoon:list():select(1)
        end)
        vim.keymap.set('n', '<C-n>', function()
          harpoon:list():select(2)
        end)
        vim.keymap.set('n', '<C-s>', function()
          harpoon:list():select(3)
        end)
        vim.keymap.set('n', '<C-S-P>', function()
          harpoon:list():prev()
        end)
        vim.keymap.set('n', '<C-S-N>', function()
          harpoon:list():next()
        end)
      end,
    },
  }
end
