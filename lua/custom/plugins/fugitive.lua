return function()
  vim.pack.add({
    { src = 'https://github.com/tpope/vim-fugitive' },
  }, { load = function() end })

  require('lz.n').load {
    {
      'vim-fugitive',
      cmd = { 'G', 'Git', 'Gread', 'Gwrite', 'Gdiffsplit', 'Gvdiffsplit', 'Gedit', 'Gblame', 'GBrowse' },
    },
  }
end
