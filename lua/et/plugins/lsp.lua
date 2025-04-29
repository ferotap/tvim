return {

  {
    -- `lazydev` configures Lua LSP for your Neovim config, runtime and plugins
    -- used for completion, annotations and signatures of Neovim apis
    "folke/lazydev.nvim",
    ft = "lua",
    opts = {
      library = {
        -- Load luvit types when the `vim.uv` word is found
        { path = "luvit-meta/library", words = { "vim%.uv" } },
        { path = "snacks.nvim", words = { "Snacks" } },
      },
    },
  },
  { "Bilal2453/luvit-meta", lazy = true },
  {
    "neovim/nvim-lspconfig",
    opts = {
       inlay_hints = { enabled = true },
    },
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "WhoIsSethDaniel/mason-tool-installer.nvim",

      { "j-hui/fidget.nvim", opts = {} },

      -- Autoformatting
      "stevearc/conform.nvim",

      -- Schema information
      "b0o/SchemaStore.nvim",
      "saghen/blink.cmp",
    },
    config = function()
      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup('tvim-lsp-attach', { clear = true }),
        callback = function(event)
          local map = function(keys, func, description, mode)
            mode = mode or 'n'
            description = description or 'N/A'
            vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = 'LSP: ' .. description})
          end

          local fzf = require("fzf-lua")

          vim.opt_local.omnifunc = "v:lua.vim.lsp.omnifunc"
          map("<leader>cr", function() fzf.lsp_references({}) end, "Goto References")
          map("<leader>cd", function() fzf.lsp_definitions({}) end, "Goto Definition")
          map("<leader>cD", function() fzf.lsp_declarations({}) end, "Declarations")
          map("<leader>ct", function() fzf.lsp_typedefs({}) end, "Type Definitions")
          map("<leader>ci", function() fzf.lsp_implementations({}) end,"Implementations")
          map("<leader>ds", function() fzf.lsp_document_symbols({}) end, "Document Symbols")
          map("<leader>ws", function() fzf.lsp_workspace_symbols({}) end, "Workspace Symbols")
          map("<leader>cl", function() fzf.lsp_live_workspace_symbols({}) end, "Workspace Symbols (live)")
          map("<leader>ci", function() fzf.lsp_incoming_calls({}) end, "Incoming Calls")
          map("<leader>co", function() fzf.lsp_outgoing_calls({}) end, "Outgoing Calls")
          map("<leader>cc", function() fzf.lsp_code_actions({}) end, "Code Actions")
          map("<leader>cF", function() fzf.lsp_finder({}) end,  "All LSP locations, combined view")
          map("<leader>cx", function() fzf.lsp_document_diagnostics({}) end, "diagnostics_document")
          map("<leader>cX", function() fzf.lsp_workspace_diagnostics({}) end, "diagnostics_workspace")

          -- DAP
          map("<leader>Dc", function() fzf.dap_commands() end, "DAP builtin commands")
          map("<leader>DC", function() fzf.dap_configurations() end, "DAP configurations")
          map("<leader>Db", function() fzf.dap_breakpoints() end, "DAP breakpoints")
          map("<leader>Dv", function() fzf.dap_variables() end, "DAP active session variables")
          map("<leader>Df", function() fzf.dap_frames() end, "DAP active session jump to frame")


          -- Formatting
          map("<leader>cf", function() vim.lsp.buf.format({}) end,  "(LSP) Format")
          -- map("gD", vim.lsp.buf.declaration, { buffer = 0 })
          -- map("gT", vim.lsp.buf.type_definition, { buffer = 0 })
          -- map("K", vim.lsp.buf.hover, { buffer = 0 })
          --
          -- vim.keymap.set("n", "<space>cr", vim.lsp.buf.rename, { buffer = 0 })
          -- vim.keymap.set("n", "<space>ca", vim.lsp.buf.code_action, { buffer = 0 })

          local client = vim.lsp.get_client_by_id(event.data.client_id)
          if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight) then
            local highlight_augroup = vim.api.nvim_create_augroup('tvim-lsp-highlight', { clear = false })
            vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
              buffer = event.buf,
              group = highlight_augroup,
              callback = vim.lsp.buf.document_highlight,
            })

            vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
              buffer = event.buf,
              group = highlight_augroup,
              callback = vim.lsp.buf.clear_references,
            })

            vim.api.nvim_create_autocmd('LspDetach', {
              group = vim.api.nvim_create_augroup('tvim-lsp-detach', { clear = true }),
              callback = function(event2)
                vim.lsp.buf.clear_references()
                vim.api.nvim_clear_autocmds { group = 'tvim-lsp-highlight', buffer = event2.buf }
              end,
            })
          end

          -- The following code creates a keymap to toggle inlay hints in your
          -- code, if the language server you are using supports them
          --
          -- This may be unwanted, since they displace some of your code
          if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint) then
            map('<leader>th', function()
              vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = event.buf })
            end, '[T]oggle Inlay [H]ints')
          end
        end,
      })

      local servers = {
        -- java is setup in 'java.lua'jdtls = {},
        jdtls = {},
        jsonls = {
          settings = {
            json = {
              schemas = require("schemastore").json.schemas(),
              validate = { enable = true },
            },
          },
        },
        lemminx = {},
        lua_ls = {
          runtime = {
            version = "LuaJIT",
          },
          diagnostics = {
            globals = {
              "vim",
            },
          },
          workspace = {
            library = {
              [vim.fn.expand("$VIMRUNTIME/lua")] = true,
              [vim.fn.stdpath("config")] = true,
            },
          },
          telemetry = { enabled = false },
        },
        -- yamlls = {
        --   settings = {
        --     yaml = {
        --       schemaStore = {
        --         enable = false,
        --         url = "",
        --       },
        --       schemas = require("schemastore").yaml.schemas(),
        --     },
        --   },
        -- },
      }
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities = vim.tbl_deep_extend("force", capabilities, require("blink.cmp").get_lsp_capabilities())

      require('mason').setup()
      local ensure_installed = vim.tbl_keys(servers or {})
      vim.list_extend(ensure_installed, {
        "stylua", -- Used to format Lua code
      })

      require("mason-tool-installer").setup({ ensure_installed = ensure_installed })


      require('mason-lspconfig').setup {
        ensure_installed = {},
        automatic_installation = true,
        handlers = {
          function(server_name)
            local server = servers[server_name] or {}
            -- This handles overriding only values explicitly passed
            -- by the server configuration above. Useful when disabling
            -- certain features of an LSP (for example, turning off formatting for ts_ls)
            server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})
            require('lspconfig')[server_name].setup(server)
          end,
        },
      }

      -- Autoformatting Setup
      require("conform").setup({
        formatters_by_ft = {
          lua = { "stylua" },
        },
        {
          java = {},
        },
      })

      -- vim.api.nvim_create_autocmd("BufWritePre", {
      --   callback = function(args)
      --     require("conform").format({
      --       bufnr = args.buf,
      --       lsp_fallback = true,
      --       quiet = true,
      --     })
      --   end,
      -- })
    end,
  },
}
