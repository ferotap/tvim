local map = vim.keymap.set
return {
  "ibhagwan/fzf-lua",
  -- commit = "86d8ee3dee6539dad1af07cdfb482ef7ceb0a96c",
  -- pin = true,
  dependencies = { "echasnovski/mini.icons" },
  keys = {
    -- buffers and files
    map("n", "<leader>fb", function() require("fzf-lua").buffers({ sort_mru = true, sort_lastused = true }) end,
      { desc = "Buffers (FZF)" }),
    map("n", "<leader>ff", function() require("fzf-lua").files({}) end, { desc = "Files  (FZF, root)" }),
    map("n", "<leader>fF", function() require("fzf-lua").files({}) end, { desc = "Files  (FZF, cwd)" }),
    map("n", "<leader>fr", function() require("fzf-lua").oldfiles({}) end, { desc = "Recent Files (FZF)" }),
    map("n", "<leader>fc", function() require("fzf-lua").quickfix({}) end, { desc = "Quickfix List (FZF)" }),
    map("n", "<leader>fC", function() require("fzf-lua").quickfix_stack({}) end, { desc = "Quickfix Stack (FZF)" }),
    map("n", "<leader>fl", function() require("fzf-lua").loclist({}) end, { desc = "Loclist List (FZF)" }),
    map("n", "<leader>fL", function() require("fzf-lua").loclist_stack({}) end, { desc = "Loclist Stack (FZF)" }),
    map("n", "<leader>fs", function() require("fzf-lua").treesitter({}) end, { desc = "Treesitter Symbols(FZF)" }),

    -- fzf-lua git mappings in git.lua
    -- search
    map("n", "<leader>sg", function() require("fzf-lua").live_grep({}) end, { desc = "Live Grep (FZF)" }),
    map("n", "<leader>sG", function() require("fzf-lua").live_grep_glob({}) end, { desc = "Live Grep --iglob(FZF)" }),
    map("n", "<leader>sR", function() require("fzf-lua").resume({}) end,
      { desc = "Resume Search Pattern (FZF)" }),
    map("n", "<leader>sw", function() require("fzf-lua").cword({}) end, { desc = "Search Word Under Cursor (FZF)" }),
    map("n", "<leader>sW", function() require("fzf-lua").cWORD({}) end, { desc = "Search WORD Under Cursor (FZF)" }),
    map("n", "<leader>sm", function() require("fzf-lua").manpages({}) end, { desc = "Man pages (FZF)" }),
    map("n", "<leader>sh", function() require("fzf-lua").help_tags({}) end, { desc = "Man pages (FZF)" }),
    map("n", "<leader>sk", function() require("fzf-lua").keymaps({}) end, { desc = "Key mappings (FZF)" }),
    map("n", '<leader>s"', "<cmd>FzfLua registers<cr>", { desc = "Registers" } ),

    -- tags
    map("n", "<leader>tf", function() require("fzf-lua").tags({}) end, { desc = "Search Project Tgs (FZF)" }),
    map("n", "<leader>tb", function() require("fzf-lua").btags({}) end, { desc = "Search Buffer Tags (FZF)" }),

    -- --LSP mappings in plugins/lsp.lua
    -- misc
    map("n", "<leader>tb", function() require("fzf-lua").tags({}) end, { desc = "Search Buffer Tags (FZF)" }),
  },
  opts = function()
    local fzf = require("fzf-lua")
    local config = fzf.config
    local actions = fzf.actions
    config.defaults.keymap.fzf["ctrl-q"] = "select-all+accept"
    config.defaults.keymap.fzf["ctrl-u"] = "half-page-up"
    config.defaults.keymap.fzf["ctrl-d"] = "half-page-down"
    config.defaults.keymap.fzf["ctrl-x"] = "jump"
    config.defaults.keymap.fzf["ctrl-f"] = "preview-page-down"
    config.defaults.keymap.fzf["ctrl-b"] = "preview-page-up"
    config.defaults.keymap.builtin["<c-f>"] = "preview-page-down"
    config.defaults.keymap.builtin["<c-b>"] = "preview-page-up"
    return {
      defaults = {
        formatter = "path.filename_first",
        -- formatter = "path.dirname_first",
      },
      previewers = {
        builtin = {
          extensions = {
            -- neovim terminal only supports `viu` block output
            ["png"] = { "viu", "-b" },
            ["jpg"] = { "ueberzug" },
          },
          -- When using 'ueberzug' we can also control the way images
          -- fill the preview area with ueberzug's image scaler, set to:
          --   false (no scaling), "crop", "distort", "fit_contain",
          --   "contain", "forced_cover", "cover"
          -- For more details see:
          -- https://github.com/seebye/ueberzug
          ueberzug_scaler = "cover",
        }
      },
      winopts = {
        preview = {
          -- default = "bat",
          -- layout = "flex",
          layout = "vertical",
          -- up = true,
          down = true,
          wrap = true,
        },
      },
      files = {
        cwd_prompt = false,
        actions = {
          ["alt-i"] = { actions.toggle_ignore },
          ["alt-h"] = { actions.toggle_hidden },
        },
      },
      grep = {
        actions = {
          ["alt-i"] = { actions.toggle_ignore },
          ["alt-h"] = { actions.toggle_hidden },
        },
        rg_glob = true,
        rg_glob_fn = function(query, opts)
          local regex, flags = query:match("^(.-)%s%-%-(.*)$")
          -- If no separator is detected will return the original query
          return (regex or query), flags
        end
      }
    }
  end
}
