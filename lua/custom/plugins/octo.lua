return function()
  vim.pack.add({
    { src = 'https://github.com/pwntester/octo.nvim' },
  }, { load = function() end })

  require('lz.n').load {
    {
      'octo.nvim',
      cmd = 'Octo',
      keys = {
        { '<leader>op', '<cmd>Octo pr list<CR>', desc = 'List [P]Rs' },
        { '<leader>os', '<cmd>Octo pr search<CR>', desc = '[S]earch PRs' },
        { '<leader>or', '<cmd>Octo review start<CR>', desc = 'Start PR [R]eview' },
        { '<leader>oc', '<cmd>Octo pr checkout<CR>', desc = 'PR [C]heckout (local)' },
      },
      after = function()
        require('octo').setup {
          enable_builtin = true,
          picker = 'telescope',
          default_merge_method = 'squash',
          mappings = {
            review_diff = {
              add_review_comment = { lhs = '<leader>ca', desc = 'add a new review comment' },
              add_review_suggestion = { lhs = '<leader>cs', desc = 'add a new review suggestion' },
              focus_files = { lhs = '<leader>e', desc = 'move focus to changed file panel' },
              toggle_files = { lhs = '<leader>b', desc = 'hide/show changed files panel' },
              next_thread = { lhs = ']t', desc = 'move to next comment thread' },
              prev_thread = { lhs = '[t', desc = 'move to previous comment thread' },
            },
          },
        }
      end,
    },
  }
end
