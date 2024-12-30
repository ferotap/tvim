return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "folke/neodev.nvim",
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "WhoIsSethDaniel/mason-tool-installer.nvim",

      { "j-hui/fidget.nvim", opts = {} },

      -- Autoformatting
      "stevearc/conform.nvim",

      -- Schema information
      "b0o/SchemaStore.nvim",
    },
    config = function()
      require("neodev").setup {
        -- library = {
        --   plugins = { "nvim-dap-ui" },
        --   types = true,
        -- },
      }

      local capabilities = nil
      if pcall(require, "cmp_nvim_lsp") then
        capabilities = require("cmp_nvim_lsp").default_capabilities()
      end

      local lspconfig = require "lspconfig"
      local server_config = require "et.config.lsp"
      local servers = server_config.servers

      local servers_to_install = vim.tbl_filter(function(key)
        local t = servers[key]
        if type(t) == "table" then
          return not t.manual_install
        else
          return t
        end
      end, vim.tbl_keys(servers))

      require("mason").setup()
      local ensure_installed = server_config.ensure_installed

      vim.list_extend(ensure_installed, servers_to_install)
      require("mason-tool-installer").setup { ensure_installed = ensure_installed }

      for name, config in pairs(servers) do
        if config == true then
          config = {}
        end
        config = vim.tbl_deep_extend("force", {}, {
          capabilities = capabilities,
        }, config)

        lspconfig[name].setup(config)
      end

      local disable_semantic_tokens = {
        lua = true,
      }

      vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(args)
          local bufnr = args.buf
          local client = assert(vim.lsp.get_client_by_id(args.data.client_id), "must have valid client")

          local settings = servers[client.name]
          if type(settings) ~= "table" then
            settings = {}
          end

          local fzf = require("fzf-lua")
          local map = vim.keymap.set

          vim.opt_local.omnifunc = "v:lua.vim.lsp.omnifunc"
          map("n", "<leader>lr", function() fzf.lsp_references({}) end, {desc = "References (FZF)" })
          map("n", "<leader>ld", function() fzf.lsp_definitions({}) end, {desc = "Definitions (FZF)" })
          map("n", "<leader>lD", function() fzf.lsp_declarations({}) end, {desc = "Declarations (FZF)" })
          map("n", "<leader>lt", function() fzf.lsp_typedefs({}) end, {desc = "Type Definitions (FZF)" })
          map("n", "<leader>li", function() fzf.lsp_implementations({}) end, {desc = "Implementations (FZF)" })
          map("n", "<leader>ld", function() fzf.lsp_document_symbols({}) end, {desc = "Document Symbols (FZF)" })
          map("n", "<leader>lw", function() fzf.lsp_workspace_symbols({}) end, {desc = "Workspace Symbols (FZF)" })
          map("n", "<leader>ll", function() fzf.lsp_live_workspace_symbols({}) end, {desc = "Workspace Symbols (live query) (FZF)" })
          map("n", "<leader>li", function() fzf.lsp_incoming_calls({}) end, {desc = "Incoming Calls (FZF)" })
          map("n", "<leader>lo", function() fzf.lsp_outgoing_calls({}) end, {desc = "Outgoing Calls (FZF)" })
          map("n", "<leader>lc", function() fzf.lsp_code_actions({}) end, {desc = "Code Actions (FZF)" })
          map("n", "<leader>lf", function() fzf.lsp_finder({}) end, {desc = "All LSP locations, combined view (FZF)" })
          map("n", "<leader>lx", function() fzf.lsp_document_diagnostics({}) end, {desc = "diagnostics_document (FZF)" })
          map("n", "<leader>lX", function() fzf.lsp_workspace_diagnostics({}) end, {desc = "diagnostics_workspace (FZF)" })


          map("n", "gD", vim.lsp.buf.declaration, { buffer = 0 })
          map("n", "gT", vim.lsp.buf.type_definition, { buffer = 0 })
          map("n", "K", vim.lsp.buf.hover, { buffer = 0 })

          vim.keymap.set("n", "<space>cr", vim.lsp.buf.rename, { buffer = 0 })
          vim.keymap.set("n", "<space>ca", vim.lsp.buf.code_action, { buffer = 0 })

          local filetype = vim.bo[bufnr].filetype
          if disable_semantic_tokens[filetype] then
            client.server_capabilities.semanticTokensProvider = nil
          end

          -- Override server capabilities
          if settings.server_capabilities then
            for k, v in pairs(settings.server_capabilities) do
              if v == vim.NIL then
                ---@diagnostic disable-next-line: cast-local-type
                v = nil
              end

              client.server_capabilities[k] = v
            end
          end
        end,
      })

      -- Autoformatting Setup
      require("conform").setup {
        formatters_by_ft = {
          lua = { "stylua" },
        },
        {
          java = {},
        },
      }

      vim.api.nvim_create_autocmd("BufWritePre", {
        callback = function(args)
          require("conform").format {
            bufnr = args.buf,
            lsp_fallback = true,
            quiet = true,
          }
        end,
      })
    end,
  },
}
