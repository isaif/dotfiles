require('nvim-treesitter.configs').setup({
  ensure_installed = 'all', -- one of "all", "maintained" (parsers with maintainers), or a list of languages
  -- ignore_install = { "javascript" }, -- List of parsers to ignore installing
  highlight = {
    enable = true, -- false will disable the whole extension
    -- disable = { "c", "rust" },  -- list of language that will be disabled
    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
  },
  context_commentstring = {
    enable = true,
    enable_autocmd = false,
  },
  -- nvim-treesitter-textsubjects options
  -- TODO: remove mappings as this plugin is not being used
  -- textsubjects = {
  --   enable = true,
  --   prev_selection = ',', -- (Optional) keymap to select the previous selection
  --   keymaps = {
  --     ['.'] = 'textsubjects-smart',
  --     [';'] = 'textsubjects-container-outer',
  --     ['i;'] = 'textsubjects-container-inner',
  --   },
  -- },
})

-- TODO: incremental selection, folding
