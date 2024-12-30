local lua_ls_settings = {
  Lua = {
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
  }
}
return {
  {
    "folke/lazydev.nvim",
    ft = "lua", -- only load on lua files
    opts = {
      library = {
        -- See the configuration section for more details
        -- Load luvit types when the `vim.uv` word is found
        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
      },
    },
  },
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "jdtls",
        "json-lsp",
        "lemminx",
        "lua-language-server",
        "yaml-language-server",
      },
    },
  },
  {
    "neovim/nvim-lspconfig",
    config = function()
      local lspconfig = require("lspconfig")

      lspconfig.jdtls.setup({
        settings = {
          java = {
            configuration = {
              runtimes = {
                {
                  name = "JavaSE-17",
                  path = "/opt/kela/java/default",
                  default = true,
                },
              },
            },
          },
        },
      })

      lspconfig.lemminx.setup({
        settings = {}
      })

      lspconfig.lua_ls.setup({
        settings = lua_ls_settings
      })

      lspconfig.jsonls.setup({
        settings = {}
      })

      lspconfig.yamlls.setup({
        settings = {
          yaml = {
            format = {
              enable = true
            }
          }
        }
      })
    end
  },
}
