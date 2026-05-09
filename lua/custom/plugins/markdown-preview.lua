return function()
  vim.pack.add({
    { src = 'https://github.com/MeanderingProgrammer/render-markdown.nvim' },
  }, { load = function() end })

  require('lz.n').load {
    {
      'render-markdown.nvim',
      ft = { 'markdown' },
      after = function()
        require('render-markdown').setup {}
      end,
    },
  }
end
