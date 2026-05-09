return function()
  -- Pin to master: the default branch is now "main" which removed
  -- nvim-treesitter.configs and changed the setup API. Stay on master to
  -- preserve the existing config until a deliberate API migration.
  --
  -- After install/update, schedule :TSUpdate to run on VimEnter so that
  -- nvim-treesitter's plugin/ files have been sourced and the user command
  -- is available.
  vim.api.nvim_create_autocmd('PackChanged', {
    callback = function(ev)
      if ev.data.spec.name == 'nvim-treesitter' and (ev.data.kind == 'install' or ev.data.kind == 'update') then
        vim.api.nvim_create_autocmd('VimEnter', {
          once = true,
          callback = function()
            vim.cmd 'TSUpdate'
          end,
        })
      end
    end,
  })

  vim.pack.add {
    { src = 'https://github.com/nvim-treesitter/nvim-treesitter', version = 'master' },
  }

  require('nvim-treesitter.install').prefer_git = true
  ---@diagnostic disable-next-line: missing-fields
  require('nvim-treesitter.configs').setup {
    ensure_installed = { 'bash', 'c', 'diff', 'html', 'lua', 'luadoc', 'markdown', 'vim', 'vimdoc' },
    auto_install = true,
    highlight = {
      enable = true,
      additional_vim_regex_highlighting = { 'ruby', 'java', 'xml', 'lua', 'python' },
    },
    indent = { enable = true, disable = { 'ruby', 'java', 'xml', 'lua', 'python' } },
  }
end
