return function()
  -- nui is a small UI lib used by neo-tree's window/popup. Eager so neo-tree's
  -- own setup() in `after` can require it without an extra packadd dance.
  vim.pack.add { { src = 'https://github.com/MunifTanjim/nui.nvim' } }

  vim.pack.add({
    { src = 'https://github.com/nvim-neo-tree/neo-tree.nvim' },
  }, { load = function() end })

  require('lz.n').load {
    {
      'neo-tree.nvim',
      cmd = 'Neotree',
      keys = {
        { '\\', ':Neotree reveal<CR>', desc = 'NeoTree reveal' },
      },
      after = function()
        require('neo-tree').setup {
          filesystem = {
            window = {
              mappings = {
                ['\\'] = 'close_window',
              },
            },
          },
        }
      end,
    },
  }
end
