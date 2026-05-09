return function()
  -- load = noop: install on disk only. lz.n calls :packadd when its trigger fires.
  vim.pack.add({ { src = 'https://github.com/folke/which-key.nvim' } }, { load = function() end })

  require('lz.n').load {
    {
      'which-key.nvim',
      event = 'VimEnter',
      after = function()
        local wk = require 'which-key'
        wk.setup()
        wk.add {
          { '<leader>c', group = '[C]ode' },
          { '<leader>c_', hidden = true },
          { '<leader>d', group = '[D]ocument' },
          { '<leader>d_', hidden = true },
          { '<leader>h', group = 'Git [H]unk' },
          { '<leader>h_', hidden = true },
          { '<leader>o', group = '[O]cto / GitHub PRs' },
          { '<leader>o_', hidden = true },
          { '<leader>r', group = '[R]ename' },
          { '<leader>r_', hidden = true },
          { '<leader>s', group = '[S]earch' },
          { '<leader>s_', hidden = true },
          { '<leader>t', group = '[T]oggle' },
          { '<leader>t_', hidden = true },
          { '<leader>u', group = '[U]tils' },
          { '<leader>u_', hidden = true },
          { '<leader>w', group = '[W]orkspace' },
          { '<leader>w_', hidden = true },
        }
        wk.add { { '<leader>h', desc = 'Git [H]unk', mode = 'v' } }
      end,
    },
  }
end
