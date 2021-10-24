local lsp_installer = require("nvim-lsp-installer")

local util = require 'lspconfig/util'
local root_pattern = util.root_pattern

-- local function common_on_attach(client, bufnr)
--   -- ... set up buffer keymaps, etc.
-- end

lsp_installer.on_server_ready(function(server)
  local opts = {
    on_attach = common_on_attach,
  }
  -- (optional) Customize the options passed to the server
  -- if server.name == "tsserver" then
  --     opts.root_dir = function() ... end
  -- end

  if server.name == "tsserver" then
    opts.on_attach = function(client, buffer)
      client.resolved_capabilities.document_formatting = false
      client.resolved_capabilities.document_range_formatting = false
      common_on_attach(client, buffer)
    end
  end


  if server.name == "sumneko_lua" then
    opts.root_dir =  root_pattern(".git", ".editorconfig")
    opts.settings = {
      Lua = {
        diagnostics = {
          -- Get the language server to recognize the `vim` global
          globals = {'vim'},
        },
        workspace = {
          -- Make the server aware of Neovim runtime files
          library = vim.api.nvim_get_runtime_file("", true),
        },
        -- Do not send telemetry data containing a randomized but unique identifier
        telemetry = {
          enable = false,
        },
      },
    }
  end

  server:setup(opts)
  vim.cmd [[ do User LspAttachBuffers ]]
end)

