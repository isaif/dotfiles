-- This plugin uses treesitter to highlight spelling mistakes
-- instead of using default vim regex highlight
-- it is better to be disabled when using treesitter
--
-- query file adds some nice addon places which can be spellchecked
-- If there is no query file, then it default to comments.
-- to check which filetype it supports check the queries directory in the repo
--
-- previously it used hunspell for spellcheck, now it supports internal vim spell
-- it doesn't support external spellcheckers and doesn't plan to do so
-- so we can use null-ls for external spellcheckers

require('spellsitter').setup({
  -- Whether enabled, can be a list of filetypes, e.g. {'python', 'lua'}
  enable = true,
})
