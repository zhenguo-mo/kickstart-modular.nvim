return function()
  vim.pack.add { { src = 'https://github.com/folke/tokyonight.nvim' } }

  require('tokyonight').setup { transparent = true }
  vim.cmd.colorscheme 'tokyonight-storm'
  vim.cmd.hi 'Comment gui=none'
end
