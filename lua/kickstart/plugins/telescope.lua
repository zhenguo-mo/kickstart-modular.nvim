function vim.getVisualSelection()
  vim.cmd 'noau normal! "vy"'
  local text = vim.fn.getreg 'v'
  vim.fn.setreg('v', {})

  text = string.gsub(text, '\n', '')
  if #text > 0 then
    return text
  else
    return ''
  end
end

return function()
  -- telescope-fzf-native ships C source; rebuild after install/update.
  vim.api.nvim_create_autocmd('PackChanged', {
    callback = function(ev)
      if ev.data.spec.name == 'telescope-fzf-native.nvim' and (ev.data.kind == 'install' or ev.data.kind == 'update') then
        if vim.fn.executable 'make' == 1 then
          vim.system({ 'make' }, { cwd = ev.data.path }):wait()
        end
      end
    end,
  })

  -- Eager dependencies (small libs and telescope extensions). Loading their
  -- plugin/* eagerly is harmless and keeps lz.n's spec for telescope simple.
  vim.pack.add {
    { src = 'https://github.com/nvim-lua/plenary.nvim' },
    { src = 'https://github.com/nvim-tree/nvim-web-devicons' },
    { src = 'https://github.com/nvim-telescope/telescope-fzf-native.nvim' },
    { src = 'https://github.com/nvim-telescope/telescope-ui-select.nvim' },
    { src = 'https://github.com/nvim-telescope/telescope-live-grep-args.nvim' },
  }

  vim.pack.add({
    { src = 'https://github.com/nvim-telescope/telescope.nvim', version = '0.1.x' },
  }, { load = function() end })

  require('lz.n').load {
    {
      'telescope.nvim',
      event = 'VimEnter',
      after = function()
        local lga_actions = require 'telescope-live-grep-args.actions'
        require('telescope').setup {
          extensions = {
            ['ui-select'] = {
              require('telescope.themes').get_dropdown(),
            },
            ['live_grep_args'] = {
              auto_quoting = true,
              mappings = {
                i = {
                  ['<C-k>'] = lga_actions.quote_prompt(),
                  ['<C-i>'] = lga_actions.quote_prompt { postfix = ' --iglob ' },
                  ['<C-space>'] = require('telescope.actions').to_fuzzy_refine,
                },
              },
            },
          },
        }

        pcall(require('telescope').load_extension, 'fzf')
        pcall(require('telescope').load_extension, 'ui-select')
        pcall(require('telescope').load_extension, 'live_grep_args')

        local builtin = require 'telescope.builtin'
        local lga_ext = require('telescope').extensions.live_grep_args
        vim.keymap.set('n', '<leader>sh', builtin.help_tags, { desc = '[S]earch [H]elp' })
        vim.keymap.set('n', '<leader>sk', builtin.keymaps, { desc = '[S]earch [K]eymaps' })
        vim.keymap.set('n', '<leader>sf', builtin.find_files, { desc = '[S]earch [F]iles' })
        vim.keymap.set('n', '<leader>ss', builtin.builtin, { desc = '[S]earch [S]elect Telescope' })
        vim.keymap.set('n', '<leader>sw', builtin.grep_string, { desc = '[S]earch current [W]ord' })
        vim.keymap.set('n', '<leader>sg', builtin.live_grep, { desc = '[S]earch by [G]rep' })
        vim.keymap.set('n', '<leader>sd', builtin.diagnostics, { desc = '[S]earch [D]iagnostics' })
        vim.keymap.set('n', '<leader>sr', builtin.resume, { desc = '[S]earch [R]esume' })
        vim.keymap.set('n', '<leader>s.', builtin.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
        vim.keymap.set('n', '<leader><leader>', builtin.buffers, { desc = '[ ] Find existing buffers' })
        vim.keymap.set('n', '<leader>sl', lga_ext.live_grep_args, { desc = '[S]earch with [Live] args' })

        vim.keymap.set('n', '<leader>/', function()
          builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
            winblend = 10,
            previewer = false,
          })
        end, { desc = '[/] Fuzzily search in current buffer' })

        vim.keymap.set('n', '<leader>s/', function()
          builtin.live_grep {
            grep_open_files = true,
            prompt_title = 'Live Grep in Open Files',
          }
        end, { desc = '[S]earch [/] in Open Files' })

        vim.keymap.set('n', '<leader>sn', function()
          builtin.find_files { cwd = vim.fn.stdpath 'config' }
        end, { desc = '[S]earch [N]eovim files' })

        vim.keymap.set('v', '<leader>sv', function()
          local text = vim.getVisualSelection()
          builtin.grep_string { default_text = text }
        end, { desc = '[S]earch [V]isual Group' })
      end,
    },
  }
end
