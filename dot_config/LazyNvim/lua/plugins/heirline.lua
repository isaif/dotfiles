return {
  'rebelot/heirline.nvim',
  event = 'UIEnter',
  dependencies = {
    'nvim-tree/nvim-web-devicons',
  },
  config = function()
    local heirline = require('heirline')
    local conditions = require('heirline.conditions')
    local utils = require('heirline.utils')

    local colors = {
      bg = utils.get_highlight('StatusLine').bg,
      fg = utils.get_highlight('StatusLine').fg,
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
      git_branch = utils.get_highlight('gitBranch').fg,
      git_del = utils.get_highlight('diffRemoved').fg,
      git_add = utils.get_highlight('diffAdded').fg,
      git_change = utils.get_highlight('diffChanged').fg,
    }

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
          v = 'v',
          vs = 'vs',
          V = 'V',
          Vs = 'Vs',
          ['\22'] = '^V',
          ['\22s'] = '^V',
          -- s = 'S',
          s = 's',
          S = 'S',
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
          n = colors.crust,
          i = colors.green,
          v = colors.orange,
          V = colors.orange,
          ['\22'] = colors.orange,
          c = colors.cyan,
          s = colors.purple,
          S = colors.purple,
          ['\19'] = colors.purple,
          R = colors.red,
          r = colors.red,
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

    FileNameBlock = utils.insert(
      FileNameBlock,
      FileName,
      unpack(FileFlags),
      { provider = '%< ' }
    )

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

    local Tabpage = {
      provider = function(self)
        -- return '%' .. self.tabnr .. 'T ' .. self.tabpage .. ' %T'
        return '%' .. self.tabnr .. 'T ' .. self.tabpage .. ' %T'
      end,
      hl = function(self)
        if not self.is_active then
          return 'TabLine'
        else
          return 'TabLineSel'
        end
      end,
    }

    local TabPages = {
      -- only show this component if there's 2 or more tabpages
      condition = function()
        return #vim.api.nvim_list_tabpages() >= 2
      end,
      { provider = '%=' },
      utils.make_tablist(Tabpage),
    }

    local StatusLine = {
      ViMode,
      Space,
      FileNameBlock,
      Align,
      TabPages,
      Space,
      ScrollBar,
      Space,
      Ruler,
      Space,
    }

    heirline.setup({ statusline = StatusLine })
  end,
}
