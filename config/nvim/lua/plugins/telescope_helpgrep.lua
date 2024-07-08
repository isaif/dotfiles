-- Use :Telescope helpgrep to start
-- It is useful when helptag is not enough

return {
  'catgoose/telescope-helpgrep.nvim',
  dependencies = { 'nvim-telescope/telescope.nvim' },

  config = function()
    local ok, telescope = pcall(require, 'telescope')
    if not ok then
      return
    end
    -- local actions = telescope.actions
    -- local builtin = telescope.builtin

    telescope.setup({
      extensions = {
        helpgrep = {
          ignore_paths = {
            vim.fn.stdpath('state') .. '/lazy/readme',
          },
          -- default_grep = builtin.live_grep,
        },
      },
    })
    telescope.load_extension('helpgrep')
  end,
}
