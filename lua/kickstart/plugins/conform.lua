return function()
  vim.pack.add { { src = 'https://github.com/stevearc/conform.nvim' } }

  require('conform').setup {
    notify_on_error = false,
    format_on_save = function(bufnr)
      local disable_filetypes = { c = true, cpp = true, java = true }
      return {
        timeout_ms = 500,
        lsp_fallback = not disable_filetypes[vim.bo[bufnr].filetype],
      }
    end,
    formatters_by_ft = {
      lua = { 'stylua' },
      javascript = { { 'prettierd', 'prettier' } },
    },
  }

  vim.keymap.set('', '<leader>f', function()
    require('conform').format { async = true, lsp_fallback = true }
  end, { desc = '[F]ormat buffer' })
end
