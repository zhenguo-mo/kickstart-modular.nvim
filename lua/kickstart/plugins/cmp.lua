return function()
  -- LuaSnip needs jsregexp built for full snippet regex support. Skip on
  -- Windows or when `make` is missing.
  local can_build_luasnip = vim.fn.has 'win32' == 0 and vim.fn.executable 'make' == 1
  if can_build_luasnip then
    vim.api.nvim_create_autocmd('PackChanged', {
      callback = function(ev)
        if ev.data.spec.name == 'LuaSnip' and (ev.data.kind == 'install' or ev.data.kind == 'update') then
          vim.system({ 'make', 'install_jsregexp' }, { cwd = ev.data.path })
        end
      end,
    })
  end

  vim.pack.add {
    { src = 'https://github.com/L3MON4D3/LuaSnip' },
    { src = 'https://github.com/saadparwaiz1/cmp_luasnip' },
    { src = 'https://github.com/hrsh7th/cmp-nvim-lsp' },
    { src = 'https://github.com/hrsh7th/cmp-path' },
    { src = 'https://github.com/hrsh7th/nvim-cmp' },
    { src = 'https://github.com/windwp/nvim-autopairs' },
  }

  local cmp = require 'cmp'
  local luasnip = require 'luasnip'
  luasnip.config.setup {}

  cmp.setup {
    snippet = {
      expand = function(args)
        luasnip.lsp_expand(args.body)
      end,
    },
    completion = { completeopt = 'menu,menuone,noinsert' },

    mapping = cmp.mapping.preset.insert {
      ['<C-n>'] = cmp.mapping.select_next_item(),
      ['<C-p>'] = cmp.mapping.select_prev_item(),
      ['<C-b>'] = cmp.mapping.scroll_docs(-4),
      ['<C-f>'] = cmp.mapping.scroll_docs(4),
      ['<C-y>'] = cmp.mapping.confirm { select = true },
      ['<C-Space>'] = cmp.mapping.complete {},
      ['<C-l>'] = cmp.mapping(function()
        if luasnip.expand_or_locally_jumpable() then
          luasnip.expand_or_jump()
        end
      end, { 'i', 's' }),
      ['<C-h>'] = cmp.mapping(function()
        if luasnip.locally_jumpable(-1) then
          luasnip.jump(-1)
        end
      end, { 'i', 's' }),
    },
    sources = {
      { name = 'nvim_lsp' },
      { name = 'luasnip' },
      { name = 'path' },
    },
  }

  require('nvim-autopairs').setup {}
  cmp.event:on('confirm_done', require('nvim-autopairs.completion.cmp').on_confirm_done())
end
