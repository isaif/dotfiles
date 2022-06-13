local util = require('lspconfig/util')
local root_pattern = util.root_pattern

local root_dir = root_pattern(
      '.git',
      '.editorconfig',
      'stylua.toml',
      '.stylua.toml'
    )

local settings = {
    Lua = {
        diagnostics = {
            globals = {
                "vim",
                -- "use",
                -- "describe",
                -- "it",
                -- "assert",
                -- "before_each",
                -- "after_each",
            },
        },
        completion = {
            showWord = "Disable",
            callSnippet = "Disable",
            keywordSnippet = "Disable",
        },
        workspace = {
            -- checkThirdParty = false,
            -- library = {
            --     ["${3rd}/love2d/library"] = true,
            -- },
          library = vim.api.nvim_get_runtime_file('', true),
        },
        telemetry = {
          enable = false,
        },
    },
}

local M = {}

M.setup = function(on_attach, capabilities)
    require'lspconfig'.sumneko_lua.setup({
        lspconfig = {
            on_attach = on_attach,
            capabilities = capabilities,
            settings = settings,
            root_dir = root_dir,
        },
    })
end

return M
