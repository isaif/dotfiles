return {
  'rebelot/heirline.nvim',
  event = 'UIEnter',
  dependencies = {
    'nvim-tree/nvim-web-devicons',
    -- 'neovim/nvim-lspconfig',
  },
  config = function()
    local heirline = require('heirline')
    local conditions = require('heirline.conditions')
    local utils = require('heirline.utils')
    -- local colors = require('catppuccin.palettes').get_palette()

    -- local colors = require('tokyonight.colors')
    -- local catppuccin = require('tokyonight')
    local colors = {
      bright_bg = utils.get_highlight('Folded').bg,
      bright_fg = utils.get_highlight('Folded').fg,
      red = utils.get_highlight('DiagnosticError').fg,
      dark_red = utils.get_highlight('DiffDelete').bg,
      green = utils.get_highlight('String').fg,
      blue = utils.get_highlight('Function').fg,
      gray = utils.get_highlight('NonText').fg,
      orange = utils.get_highlight('Constant').fg,
      purple = utils.get_highlight('Statement').fg,
      cyan = utils.get_highlight('Special').fg,
      diag_warn = utils.get_highlight('DiagnosticWarn').fg,
      diag_error = utils.get_highlight('DiagnosticError').fg,
      diag_hint = utils.get_highlight('DiagnosticHint').fg,
      diag_info = utils.get_highlight('DiagnosticInfo').fg,
      git_del = utils.get_highlight('diffDeleted').fg,
      git_add = utils.get_highlight('diffAdded').fg,
      git_change = utils.get_highlight('diffChanged').fg,
    }

    conditions.buffer_not_empty = function()
      return vim.fn.empty(vim.fn.expand('%:t')) ~= 1
    end

    conditions.hide_in_width = function(size)
      return vim.api.nvim_get_option('columns') > (size or 140)
    end

    -- local Align = { provider = '%=', hl = { bg = colors.crust } }
    local Align = { provider = '%=' }
    local Space = { provider = ' ' }

    local ViMode = {
      -- get vim current mode, this information will be required by the provider
      -- and the highlight functions, so we compute it only once per component
      -- evaluation and store it as a component attribute
      init = function(self)
        self.mode = vim.fn.mode(1) -- :h mode()
      end,
      -- Now we define some dictionaries to map the output of mode() to the
      -- corresponding string and color. We can put these into `static` to compute
      -- them at initialisation time.
      static = {
        mode_names = { -- change the strings if you like it vvvvverbose!
          n = 'N',
          no = 'N?',
          nov = 'N?',
          noV = 'N?',
          ['no\22'] = 'N?',
          niI = 'Ni',
          niR = 'Nr',
          niV = 'Nv',
          nt = 'Nt',
          v = 'V',
          vs = 'Vs',
          V = 'V_',
          Vs = 'Vs',
          ['\22'] = '^V',
          ['\22s'] = '^V',
          s = 'S',
          S = 'S_',
          ['\19'] = '^S',
          i = 'I',
          ic = 'Ic',
          ix = 'Ix',
          R = 'R',
          Rc = 'Rc',
          Rx = 'Rx',
          Rv = 'Rv',
          Rvc = 'Rv',
          Rvx = 'Rv',
          c = 'C',
          cv = 'Ex',
          r = '...',
          rm = 'M',
          ['r?'] = '?',
          ['!'] = '!',
          t = 'T',
        },
        mode_colors = {
          n = 'green',
          i = 'green',
          v = 'cyan',
          V = 'cyan',
          ['\22'] = 'cyan',
          c = 'orange',
          s = 'purple',
          S = 'purple',
          ['\19'] = 'purple',
          R = 'orange',
          r = 'orange',
          ['!'] = 'red',
          t = 'red',
        },
      },
      -- We can now access the value of mode() that, by now, would have been
      -- computed by `init()` and use it to index our strings dictionary.
      -- note how `static` fields become just regular attributes once the
      -- component is instantiated.
      -- To be extra meticulous, we can also add some vim statusline syntax to
      -- control the padding and make sure our string is always at least 2
      -- characters long. Plus a nice Icon.
      provider = function(self)
        -- return '%2(' .. self.mode_names[self.mode] .. '%)'

        return '%2(' .. self.mode_names[self.mode] .. '%) '
      end,
      -- Same goes for the highlight. Now the foreground will change according to the current mode.
      hl = function(self)
        local mode = self.mode:sub(1, 1) -- get only the first mode character
        return { fg = self.mode_colors[mode], bold = true }
      end,
      -- Re-evaluate the component only on ModeChanged event!
      -- Also allows the statusline to be re-evaluated when entering operator-pending mode
      update = {
        'ModeChanged',
        pattern = '*:*',
        callback = vim.schedule_wrap(function()
          vim.cmd('redrawstatus')
        end),
      },
    }

    local FileNameBlock = {
      init = function(self)
        self.filename = vim.api.nvim_buf_get_name(0)
      end,
      condition = conditions.buffer_not_empty,
      hl = { bg = colors.crust, fg = colors.subtext1 },
    }

    -- local FileIcon = {
    --   init = function(self)
    --     local filename = self.filename
    --     local extension = vim.fn.fnamemodify(filename, ':e')
    --     self.icon, self.icon_color =
    --       require('nvim-web-devicons').get_icon_color(
    --         vim.fn.fnamemodify(filename, ':t'),
    --         extension,
    --         { default = true }
    --       )
    --   end,
    --   provider = function(self)
    --     return self.icon and (' ' .. self.icon .. ' ')
    --   end,
    --   hl = function(self)
    --     return { fg = self.icon_color }
    --   end,
    -- }

    local FileName = {
      provider = function(self)
        local filename = vim.fn.fnamemodify(self.filename, ':~:.')
        if filename == '' then
          return '[No Name]'
        end
        if not conditions.width_percent_below(#filename, 0.25) then
          filename = vim.fn.pathshorten(filename)
        end
        return filename
      end,
      -- hl = { fg = colors.subtext1, bold = true },
      hl = { fg = colors.subtext1 },
    }

    local FileFlags = {
      {
        condition = function()
          return vim.bo.modified
        end,
        provider = ' [+] ',
        hl = { fg = colors.lavender },
      },
      {
        condition = function()
          return not vim.bo.modifiable or vim.bo.readonly
        end,
        provider = '',
        hl = { fg = colors.red },
      },
    }

    -- local FileNameModifer = {
    --   hl = function()
    --     if vim.bo.modified then
    --       return { fg = colors.text, bold = true, force = true }
    --     end
    --   end,
    -- }

    FileNameBlock = utils.insert(
      FileNameBlock,
      -- FileIcon,
      -- utils.insert(FileNameModifer, FileName),
      FileName,
      unpack(FileFlags),
      { provider = '%< ' }
    )

    -- local FileType = {
    --   provider = function()
    --     return vim.bo.filetype
    --   end,
    --   -- hl = { fg = utils.get_highlight('Type').fg, bold = true },
    -- }

    local Ruler = {
      -- %l = current line number
      -- %L = number of lines in the buffer
      -- %c = column number
      -- %P = percentage through file of displayed window
      -- provider = '%7(%l/%3L%):%2c %P',
      provider = '%3l:%2c',
    }

    local ScrollBar = {
      static = {
        -- sbar = { '▁', '▂', '▃', '▄', '▅', '▆', '▇', '█' },
        -- Another variant, because the more choice the better.
        sbar = { '🭶', '🭷', '🭸', '🭹', '🭺', '🭻' },
      },
      provider = function(self)
        local curr_line = vim.api.nvim_win_get_cursor(0)[1]
        local lines = vim.api.nvim_buf_line_count(0)
        local i = math.floor((curr_line - 1) / lines * #self.sbar) + 1
        return string.rep(self.sbar[i], 2)
      end,
      -- hl = { fg = 'blue', bg = 'bright_bg' },
    }

    -- local FileFormat = {
    --   provider = function()
    --     local fmt = vim.bo.fileformat
    --     if fmt == 'unix' then
    --       return ' LF '
    --     elseif fmt == 'mac' then
    --       return ' CR '
    --     else
    --       return ' CRLF '
    --     end
    --   end,
    --   hl = { bg = colors.crust, fg = colors.surface2 },
    --   condition = function()
    --     return conditions.buffer_not_empty() and conditions.hide_in_width()
    --   end,
    -- }

    local StatusLine = {
      ViMode,
      Space,
      FileNameBlock,
      Align,
      -- FileType,
      Space,
      ScrollBar,
      Space,
      Ruler,
      Space,
    }

    heirline.setup({ statusline = StatusLine, winbar = nil })
  end,
}
