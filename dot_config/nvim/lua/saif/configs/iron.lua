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
    send_motion = '<space>ic',
    visual_send = '<space>ic',
    send_file = '<space>if',
    send_line = '<space>il',
    send_mark = '<space>im',
    mark_motion = '<space>mc',
    mark_visual = '<space>mc',
    remove_mark = '<space>md',
    cr = '<space>i<cr>',
    interrupt = '<space>i<space>',
    exit = '<space>iq',
    clear = '<space>cl',
  },
  -- If the highlight is on, you can change how it looks
  -- For the available options, check nvim_set_hl
  highlight = {
    italic = true,
  },
})
