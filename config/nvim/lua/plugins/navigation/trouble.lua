local keymaps = {
  {
    '<leader>xx',
    '<cmd>Trouble diagnostics toggle<cr>',
    desc = 'Diagnostics (Trouble)',
  },
  {
    '<leader>xd',
    '<cmd>Trouble diagnostics toggle filter.buf=0<cr>',
    desc = 'Buffer Diagnostics (Trouble)',
  },
  {
    '<leader>xs',
    '<cmd>Trouble symbols toggle focus=false<cr>',
    desc = 'Symbols (Trouble)',
  },
  {
    '<leader>xl',
    '<cmd>Trouble lsp toggle focus=false win.position=right<cr>',
    desc = 'LSP Definitions / references / ... (Trouble)',
  },
  {
    '<leader>xL',
    '<cmd>Trouble loclist<cr>',
    desc = 'Location List (Trouble)',
  },
  {
    '<leader>xq',
    '<cmd>Trouble quickfix<cr>',
    desc = 'Quickfix List (Trouble)',
  },
  {
    '[q',
    function()
      if require('trouble').is_open() then
        require('trouble').previous({ skip_groups = true, jump = true })
      else
        vim.cmd.cprev()
      end
    end,
    desc = 'Previous trouble/quickfix item',
  },
  {
    ']q',
    function()
      if require('trouble').is_open() then
        require('trouble').next({ skip_groups = true, jump = true })
      else
        vim.cmd.cnext()
      end
    end,
    desc = 'Next trouble/quickfix item',
  },
}

-- better diagnostics list and others
return {
  'folke/trouble.nvim',
  cmd = { 'Trouble' },
  opts = { use_diagnostic_signs = true },
  keys = keymaps,
  dependencies = {
    'nvim-tree/nvim-web-devicons',
  },
}
