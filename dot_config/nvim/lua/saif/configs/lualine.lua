require('lualine').setup({
  options = {
    icons_enabled = true,
    -- theme = 'auto',
    -- component_separators = { left = '', right = ''},
    section_separators = '',
    -- section_separators = { left = '', right = ''},
    -- disabled_filetypes = {},
    always_divide_middle = true,
    -- enable global line
    globalstatus = true,
    refresh = {
      statusline = 200,
      -- tabline = 1000,
      -- winbar = 1000,
    },
  },
  sections = {
    lualine_a = { 'mode' },
    lualine_b = {
      'branch',
      'diff',
      { 'diagnostics', sources = { 'nvim_diagnostic' } },
    },
    lualine_c = {
      {
        'filename',
        -- displays file status (readonly status, modified status)
        file_status = true,
        -- 0 = just filename, 1 = relative path, 2 = absolute path
        path = 1,
        shorting_target = 20,
      },
      -- 'lsp_progress',
    },
    lualine_x = {
      -- 'encoding',
      -- 'fileformat',
      -- {
      --   require('noice').api.status.message.get_hl,
      --   cond = require('noice').api.status.message.has,
      -- },
      {
        require('noice').api.status.command.get,
        cond = require('noice').api.status.command.has,
        color = { fg = '#ff9e64' },
      },
      {
        require('noice').api.status.mode.get,
        cond = require('noice').api.status.mode.has,
        color = { fg = '#ff9e64' },
      },
      -- {
      --   require('noice').api.status.search.get,
      --   cond = require('noice').api.status.search.has,
      --   color = { fg = '#ff9e64' },
      -- },
      { 'filetype', icons_enabled = false },
    },
    lualine_y = { 'progress' },
    lualine_z = { 'location' },
  },
  -- When buffer is inactive
  -- not required when using global line
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {
      {
        'filename',
        path = 1,
        shorting_target = 40,
      },
    },
    lualine_x = { 'location' },
    lualine_y = {},
    lualine_z = {},
  },
  tabline = {},
  winbar = {
    lualine_a = {
      {
        'tabs',
        mode = 1,
        -- show tabs only on the first window
        -- i.e. the top left window
        cond = function()
          return vim.api.nvim_win_get_number(0) == 1
        end,
      },
    },
    lualine_z = {
      {
        'filename',
        color = 'lualine_a_normal',
        path = 1,
        shorting_target = 40,
      },
    },
  },
  inactive_winbar = {
    lualine_a = {
      {
        'tabs',
        mode = 1,
        cond = function()
          return vim.api.nvim_win_get_number(0) == 1
        end,
      },
    },
    lualine_z = {
      {
        'filename',
        path = 1,
        shorting_target = 40,
      },
    },
  },
  extensions = { 'fugitive' },
})

vim.opt.showtabline = 0
