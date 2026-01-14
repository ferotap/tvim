return {
  -- Highlight, edit, and navigate code
  {
    "nvim-treesitter/nvim-treesitter",
    lazy = false,
    build = ":TSUpdate",
  },

  {
  "nvim-treesitter/nvim-treesitter-textobjects",
  branch = "main",
  init = function()
    -- Disable entire built-in ftplugin mappings to avoid conflicts.
    -- See https://github.com/neovim/neovim/tree/master/runtime/ftplugin for built-in ftplugins.
    vim.g.no_plugin_maps = true

    -- Or, disable per filetype (add as you like)
    -- vim.g.no_python_maps = true
    -- vim.g.no_ruby_maps = true
    -- vim.g.no_rust_maps = true
    -- vim.g.no_go_maps = true
  end,
  config = function()
    -- put your config here
  end,
}
}

-- function M.config()
--   local config = require("nvim-treesitter.config")
--   config.setup({
--     modules = {},
--     sync_install = false,
--     auto_install = true,
--     ignore_install = {},
--     highlight = { enable = true },
--     indent = { enable = true },
--     incremental_selection = {
--       enable = true,
--       keymaps = {
--         init_selection = "<C-space>",
--         node_incremental = "<C-space>",
--         scope_incremental = false,
--         node_decremental = "<bs>",
--       },
--     },
--     textobjects = {
--       move = {
--         enable = true,
--         goto_next_start = { ["]f"] = "@function.outer", ["]c"] = "@class.outer" },
--         goto_next_end = { ["]F"] = "@function.outer", ["]C"] = "@class.outer" },
--         goto_previous_start = { ["[f"] = "@function.outer", ["[c"] = "@class.outer" },
--         goto_previous_end = { ["[F"] = "@function.outer", ["[C"] = "@class.outer" },
--       },
--     },
--     ensure_installed = {
--       "bash",
--       "c",
--       "cmake",
--       "diff",
--       "dockerfile",
--       "graphql",
--       "html",
--       "http",
--       "jq",
--       "java",
--       "javascript",
--       "json",
--       "jsonc",
--       "lua",
--       "markdown",
--       "markdown_inline",
--       "python",
--       "sql",
--       "query",
--       "toml",
--       "typescript",
--       "vim",
--       "vimdoc",
--       "yaml",
--     },
--   })
-- end
--
-- return M
