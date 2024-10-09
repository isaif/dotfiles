return {
  'mfussenegger/nvim-lint',
  ft = {
    'javascript',
    'javascriptreact',
    'typescriptreact',
  },
  opts = {
    linters_by_ft = {
      javascript = { 'eslint' },
      javascriptreact = { 'eslint' },
      typescriptreact = { 'eslint' },
      astro = { 'eslint' },
    },
  },
  config = function()
    -- vim.api.nvim_create_autocmd({ 'BufWritePost' }, {
    vim.api.nvim_create_autocmd({ 'TextChanged' }, {
      callback = function()
        -- try_lint without arguments runs the linters defined in `linters_by_ft`
        -- for the current filetype
        require('lint').try_lint()
        print('linter works')

        -- You can call `try_lint` with a linter name or a list of names to always
        -- run specific linters, independent of the `linters_by_ft` configuration
        -- require('lint').try_lint('cspell')
      end,
    })
  end,
}
