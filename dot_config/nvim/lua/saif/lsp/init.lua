local lsp_installer = require("nvim-lsp-installer")
    function common_on_attach(client, bufnr)
        -- ... set up buffer keymaps, etc.
    end
    lsp_installer.on_server_ready(function(server)
        local opts = {
            on_attach = common_on_attach,
        }
        -- (optional) Customize the options passed to the server
        -- if server.name == "tsserver" then
        --     opts.root_dir = function() ... end
        -- end
        server:setup(opts)
        vim.cmd [[ do User LspAttachBuffers ]]
    end)

local server = require "nvim-lsp-installer.server"
local npm = require "nvim-lsp-installer.installers.npm"

return function(name, root_dir)
    return server.Server:new {
        name = name,
        root_dir = root_dir,
        homepage = "https://github.com/typescript-language-server/typescript-language-server",
        installer = npm.packages { "typescript-language-server", "typescript" },
        default_options = {
            cmd = { npm.executable(root_dir, "typescript-language-server"), "--stdio" },
        },
    }
end

