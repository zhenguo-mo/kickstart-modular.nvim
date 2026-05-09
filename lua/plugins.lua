-- Plugin manager: vim.pack (built-in) + lz.n for lazy-loading.
--
-- Each plugin module under lua/kickstart/plugins/ or lua/custom/plugins/
-- returns a function. The function calls vim.pack.add() to install,
-- then either runs setup() eagerly or hands a spec to lz.n for deferred
-- loading. See lua/kickstart/plugins/cmp.lua for a fully eager example
-- and lua/kickstart/plugins/which-key.lua for a lazy one.

-- Bootstrap lz.n. Eager so require('lz.n') is always available.
vim.pack.add { { src = 'https://github.com/lumen-oss/lz.n' } }

-- Order matters: colorscheme first (so :colorscheme works during later
-- module setups), then libs/treesitter, then everything else.
local modules = {
  'kickstart.plugins.tokyonight',
  'kickstart.plugins.treesitter',
  'kickstart.plugins.mini',
  'kickstart.plugins.gitsigns',
  'kickstart.plugins.indent_line',
  'kickstart.plugins.lspconfig',
  'kickstart.plugins.cmp',
  'kickstart.plugins.conform',
  'kickstart.plugins.which-key',
  'kickstart.plugins.telescope',
  'kickstart.plugins.todo-comments',
  'kickstart.plugins.neo-tree',
  'custom.plugins.comment',
  'custom.plugins.diffview',
  'custom.plugins.fugitive',
  'custom.plugins.guess-indent',
  'custom.plugins.harpoon',
  'custom.plugins.markdown-preview',
  'custom.plugins.octo',
  'custom.plugins.undotree',
}

for _, name in ipairs(modules) do
  require(name)()
end
