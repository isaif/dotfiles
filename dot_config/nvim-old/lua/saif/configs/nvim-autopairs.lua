require('nvim-autopairs').setup({
  -- You can use treesitter to check for a pair
  -- default is false
  check_ts = true,

  -- will ignore alphanumeric and `.` symbol
  -- ignored_next_char = "[%w%.]"

  fast_wrap = {
    -- <C-y> is also used by emmet plugin, i.e. <C-y> and a comma
    -- map = '<C-y-y>',
    -- chars = { '{', '[', '(', '"', "'" },
    -- pattern = string.gsub([[ [%'%"%)%>%]%)%}%,] ]], '%s+', ''),
    -- offset = 0, -- Offset from pattern match
    -- end_key = '$',
    -- keys = 'qwertyuiopzxcvbnmasdfghjkl',
    -- check_comma = true,
    -- highlight = 'Search',
    -- highlight_grey='Comment'
  },
})
-- TODO: don't autoclose " as it is used in .vimrc as comment
