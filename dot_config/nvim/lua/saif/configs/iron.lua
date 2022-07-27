local iron = require('iron.core')

iron.setup({
  config = {
    -- If iron should expose `<plug>(...)` mappings for the plugins
    should_map_plug = false,
    -- Whether a repl should be discarded or not
    scratch_repl = true,
    -- Your repl definitions come here
    repl_definition = {
      sh = {
        command = { 'zsh' },
      },
    },
    -- repl_open_cmd = require('iron.view').curry.right(44),
    -- how the REPL window will be opened, the default is opening
    -- a float window of height 40 at the bottom.
    -- repl_open_cmd = 'belowright 15 split',
    repl_open_cmd = 'botright 70vnew',
  },
  keymaps = {
    send_motion = '<leader>ic',
    visual_send = '<leader>ic',
    send_file = '<leader>if',
    send_line = '<leader>il',
    send_mark = '<leader>im',
    mark_motion = '<leader>mc',
    mark_visual = '<leader>mc',
    remove_mark = '<leader>md',
    cr = '<leader>i<cr>',
    interrupt = '<leader>i<space>',
    exit = '<leader>iq',
    clear = '<leader>icl',
  },
  -- If the highlight is on, you can change how it looks
  -- For the available options, check nvim_set_hl
  highlight = {
    italic = true,
  },
})
