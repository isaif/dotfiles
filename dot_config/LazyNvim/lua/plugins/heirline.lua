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
      -- Also allows the statusline to be re-evaluated
      -- when entering operator-pending mode
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
    }

    local FileName = {
      provider = function(self)
        local filetype = vim.bo.filetype
        local filename = vim.api.nvim_buf_get_name(0)
        -- Filename for help file
        if filetype == 'help' then
          return vim.fn.fnamemodify(filename, ':t:r') .. ' [Help]'
        -- elseif vim.fn.isdirectory(filename) == 1 then
        --     return vim.fn.fnamemodify(filename, ':p:.')
        elseif filetype == 'fugitive' then
          -- local value, _ = require('nvim-web-devicons').get_icon('git')
          return '[Fugitive]'
        elseif filetype == 'TelescopePrompt' then
          return '[Telescope]'
        elseif filename == '' then
          return '[No Name]'
        end

        -- first, trim the pattern relative to the current directory. For other
        -- options, see :h filename-modifers
        filename = vim.fn.fnamemodify(self.filename, ':.')
        -- now, if the filename would occupy more than 1/4th of the available
        -- space, we trim the file path to its initials
        -- See Flexible Components section below for dynamic truncation
        if not conditions.width_percent_below(#filename, 0.25) then
          filename = vim.fn.pathshorten(filename)
        end
        return filename
      end,
    }

    local FileFlags = {
      {
        condition = function()
          return vim.bo.modified
        end,
        provider = ' [+]',
      },
      {
        condition = function()
          return not vim.bo.modifiable or vim.bo.readonly
        end,
        provider = ' ',
      },
    }

    FileNameBlock = utils.insert(FileNameBlock, FileName, unpack(FileFlags))

    local MacroRec = {
      condition = function()
        return vim.fn.reg_recording() ~= '' and vim.o.cmdheight == 0
      end,
      {
        provider = ' 󰻃 ',
        hl = { fg = colors.orange, bold = true },
      },
      {
        provider = function()
          return '[' .. vim.fn.reg_recording() .. '] '
        end,
      },
      update = {
        'RecordingEnter',
        'RecordingLeave',
      },
    }

    local ShowCmd = {
      condition = function()
        return vim.o.cmdheight == 0
      end,
      provider = '%3.5(%S%) ',
    }

    local Git = {
      condition = conditions.is_git_repo,

      init = function(self)
        self.status_dict = vim.b.gitsigns_status_dict
      end,

      hl = { fg = colors.gray },

      provider = function(self)
        return ' ' .. self.status_dict.head .. ' '
      end,
    }

    local Ruler = {
      -- %l = current line number
      -- %L = number of lines in the buffer
      -- %c = column number
      -- %P = percentage through file of displayed window
      -- provider = '%7(%l/%3L%):%2c %P',
      provider = ' %2c',
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
      hl = { fg = colors.blue, bg = colors.bright_bg },
    }

    local Tabpage = {
      provider = function(self)
        -- return '%' .. self.tabnr .. 'T ' .. self.tabpage .. ' %T'
        local tabnr =  self.tabnr
        return ' ' .. tabnr .. ' '
      end,
      hl = function(self)
        if not self.is_active then
          -- 'Tabline', 'TabLineSel' are hl groups in neovim
          -- return 'TabLine'
          return 'bg'
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
      utils.make_tablist(Tabpage),
    }

    local Left = {
      ViMode,
      MacroRec,
      Git,
      hl = { bg = 'bg' },
    }

    local Right = {
      TabPages,
      Space,
      Ruler,
      Space,
      ScrollBar,
      hl = { bg = 'bg' },
    }

    local StatusLine = {
      Left,
      Space,
      FileNameBlock,
      Align,
      ShowCmd,
      Right,
    }

    heirline.setup({ statusline = StatusLine })
  end,
}
