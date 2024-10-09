local opts = {
  cmdline = {
    view = 'cmdline',
  },
  -- smart_move = {
  --   -- noice tries to move out of the way of existing floating windows.
  --   enabled = true, -- you can disable this behaviour here
  --   -- add any filetypes here, that shouldn't trigger smart move.
  --   excluded_filetypes = { 'cmp_menu', 'cmp_docs' },
  -- },
  lsp = {
    -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
    override = {
      ['vim.lsp.util.convert_input_to_markdown_lines'] = true,
      ['vim.lsp.util.stylize_markdown'] = true,
      ['cmp.entry.get_documentation'] = true,
    },
  },
  -- you can enable a preset for easier configuration
  presets = {
    -- bottom_search = true, -- use a classic bottom cmdline for search
    -- command_palette = true, -- position the cmdline and popupmenu together
    long_message_to_split = true, -- long messages will be sent to a split
    -- inc_rename = false, -- enables an input dialog for inc-rename.nvim
    -- lsp_doc_border = false, -- add a border to hover docs and signature help
  },
}

return {
  'folke/noice.nvim',
  event = 'VimEnter',
  opts = opts,
  dependencies = {
    -- if you lazy-load any plugin below,
    -- make sure to add proper `module="..."` entries
    'MunifTanjim/nui.nvim',
    -- OPTIONAL:
    --`nvim-notify` is only needed, if you want to use the notification view.
    -- If not available, we use `mini` as the fallback
    -- use({
    --   'rcarriga/nvim-notify',
    --   config = function()
    --     require('notify').setup({
    --       render = 'minimal',
    --     })
    --   end,
    -- }),
  },
}
