local highlight_disable_size = 1024 * 1024 -- 1M

local options = {
  -- one of "all", "maintained" (parsers with maintainers), or a list of languages
  ensure_installed = {
    'bash',
    'c',
    'vimdoc',
    'html',
    'javascript',
    'json',
    'jsonc',
    'lua',
    'luadoc',
    'luap',
    'markdown',
    'markdown_inline',
    'python',
    'query',
    'regex',
    'tsx',
    'typescript',
    'vim',
    'yaml',
  },
  -- ignore_install = { "javascript" }, -- List of parsers to ignore installing
  highlight = {
    enable = true, -- false will disable the whole extension
    -- disable = { "c", "rust" },  -- list of language that will be disabled
    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    -- additional_vim_regex_highlighting = { 'latex' },
    additional_vim_regex_highlighting = false,
    disable = function(_, buf)
      local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
      if ok and stats and stats.size > highlight_disable_size then
        vim.notify(
          'File too large. TS highlight is disabled',
          vim.log.levels.INFO
        )
        return true
      end
    end,
  },
}

return {
  'nvim-treesitter/nvim-treesitter',
  build = ':TSUpdate',
  event = { 'BufReadPost', 'BufNewFile' },
  -- cmd = {
  --   'TSBufDisable',
  --   'TSBufEnable',
  --   'TSBufToggle',
  --   'TSDisable',
  --   'TSEnable',
  --   'TSToggle',
  --   'TSInstall',
  --   'TSInstallInfo',
  --   'TSInstallSync',
  --   'TSModuleInfo',
  --   'TSUninstall',
  --   'TSUpdate',
  --   'TSUpdateSync',
  -- },
  opts = options,
  config = function(_, opts)
    require('nvim-treesitter.configs').setup(opts)
  end,
}
