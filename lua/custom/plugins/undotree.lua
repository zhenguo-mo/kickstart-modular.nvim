return function()
  vim.pack.add({
    { src = 'https://github.com/mbbill/undotree' },
  }, { load = function() end })

  require('lz.n').load {
    {
      'undotree',
      cmd = { 'UndotreeToggle', 'UndotreeShow', 'UndotreeHide', 'UndotreeFocus' },
    },
  }
end
