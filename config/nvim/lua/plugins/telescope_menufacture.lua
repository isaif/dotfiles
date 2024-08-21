local ok, telescope = pcall(require, 'telescope')
if not ok then
  return
end

return {
  'molecule-man/telescope-menufacture',
  dependencies = {
    'nvim-telescope/telescope.nvim',
  },
  config = function()
    telescope.load_extension('menufacture')
  end,
  keys = {

    {
      '<leader>e',
      function()
        require('telescope').extensions.menufacture.find_files()
      end,
    },
    {
      '<leader>ss',
      function()
        require('telescope').extensions.menufacture.live_grep()
      end,
    },
    {
      '<leader>sw',
      function()
        require('telescope').extensions.menufacture.grep_string()
      end,
    },
    {
      '<leader>gf',
      function()
        require('telescope').extensions.menufacture.git_files()
      end,
    },
  },
}
