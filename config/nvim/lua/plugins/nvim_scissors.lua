local snippetDir = vim.fn.stdpath('config') .. '/lua/snippets'

-- TODO: https://github.com/chrisgrieser/nvim-scissors?tab=readme-ov-file#version-controlling-snippets-json-formatting
return {
  'chrisgrieser/nvim-scissors',
  dependencies = { 'nvim-telescope/telescope.nvim', 'L3MON4D3/LuaSnip' },
  opts = {
    snippetDir = snippetDir,
  },
  init = function()
    require('luasnip.loaders.from_vscode').lazy_load({
      paths = { snippetDir },
    })
  end,
}
