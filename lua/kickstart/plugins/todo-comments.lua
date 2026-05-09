return function()
  vim.pack.add({
    { src = 'https://github.com/folke/todo-comments.nvim' },
  }, { load = function() end })

  require('lz.n').load {
    {
      'todo-comments.nvim',
      event = 'VimEnter',
      after = function()
        require('todo-comments').setup { signs = false }
      end,
    },
  }
end
