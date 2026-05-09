return function()
  vim.pack.add({
    { src = 'https://github.com/sindrets/diffview.nvim' },
  }, { load = function() end })

  require('lz.n').load {
    {
      'diffview.nvim',
      cmd = { 'DiffviewOpen', 'DiffviewClose', 'DiffviewToggleFiles', 'DiffviewFocusFiles', 'DiffviewRefresh', 'DiffviewFileHistory' },
    },
  }
end
