local nls = require('null-ls')

require('null-ls').setup({
  diagnostics_format = '[#{s}] #{c}: #{m}',

  sources = {
    -- nls.builtins.code_actions.gitsigns,
    nls.builtins.formatting.prettierd,
    nls.builtins.diagnostics.eslint_d,
    nls.builtins.formatting.stylua,
    -- nls.builtins.formatting.stylua.with {
    --   extra_args = { "--config-path", vim.fn.expand "~/.config/stylua/stylua.toml" },
    -- },
    -- nls.builtins.formatting.isort.with {
    --   extra_args = { "-l", "100" },
    -- },
    -- nls.builtins.formatting.black.with {
    --   extra_args = { "-l", "100" },
    -- },
    -- nls.builtins.diagnostics.flake8.with {
    --   extra_args = { "--ignore", "E501,W503" },
    -- },
    -- nls.builtins.diagnostics.mypy.with {
    --   extra_args = {
    --     "--show-column-numbers",
    --     "--ignore-missing-imports",
    --     "--disable-error-code",
    --     "name-defined",
    --     "--cache-dir",
    --     "/dev/null",
    --   },
    -- },
  },

  -- you can reuse a shared lspconfig on_attach callback here
  on_attach = function(client)
    if client.resolved_capabilities.document_formatting then
      vim.cmd('autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()')
    end
  end,
})
