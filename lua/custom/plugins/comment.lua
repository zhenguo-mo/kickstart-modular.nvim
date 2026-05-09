return function()
  vim.pack.add { { src = 'https://github.com/numToStr/Comment.nvim' } }
  require('Comment').setup()
end
