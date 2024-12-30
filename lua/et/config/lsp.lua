local M = {}

M.servers = {
  jdtls = true,
  jsonls = {
    settings = {
      json = {
        schemas = require("schemastore").json.schemas(),
        validate = { enable = true },
      },
    },
  },
  lemminx = true,
  lua_ls = {
    runtime = {
      version = 'LuaJIT'
    },
    diagnostics = {
      globals = {
        'vim'
      },
    },
    workspace = {
      library = {
        [vim.fn.expand('$VIMRUNTIME/lua')] = true,
        [vim.fn.stdpath('config')] = true,
      },
    },
    telemetry = { enabled = false },
    server_capabilities = {
      semanticTokensProvider = vim.NIL,
    },
  },
  yamlls = {
    settings = {
      yaml = {
        schemaStore = {
          enable = false,
          url = "",
        },
        schemas = require("schemastore").yaml.schemas(),
      },
    },
  },
}

M.ensure_installed = {
  "jdtls",
  "jsonls",
  "lemminx",
  "lua_ls",
  "stylua",
  "yamlls",
}

return M
