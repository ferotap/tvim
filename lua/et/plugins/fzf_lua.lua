local map = vim.keymap.set
return {
  "ibhagwan/fzf-lua",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  keys = {
    -- buffers and files
    map("n", "<leader>fb", function() require("fzf-lua").buffers({}) end, { desc = "Buffers (FZF)" }),
    map("n", "<leader>ff", function() require("fzf-lua").files({}) end, { desc = "Files  (FZF)" }),
    map("n", "<leader>fo", function() require("fzf-lua").oldfiles({}) end, { desc = "Recent Files (FZF)" }),
    map("n", "<leader>fc", function() require("fzf-lua").quickfix({}) end, { desc = "Quickfix List (FZF)" }),
    map("n", "<leader>fC", function() require("fzf-lua").quickfix_stack({}) end, { desc = "Quickfix Stack (FZF)" }),
    map("n", "<leader>fl", function() require("fzf-lua").loclist({}) end, { desc = "Loclist List (FZF)" }),
    map("n", "<leader>fL", function() require("fzf-lua").loclist_stack({}) end, { desc = "Loclist Stack (FZF)" }),
    map("n", "<leader>ft", function() require("fzf-lua").treesitter({}) end, { desc = "Treesitter Symbols(FZF)" }),

    -- git
    map("n", "<leader>gc", function() require("fzf-lua").git_commits({}) end, { desc = "git commit log (project) (FZF)" }),
    map("n", "<leader>gC", function() require("fzf-lua").git_bcommits({}) end, { desc = "git commit log (buffer) (FZF)" }),
    map("n", "<leader>gf", function() require("fzf-lua").ls_files({}) end, { desc = "git ls-files (FZF)" }),
    map("n", "<leader>gs", function() require("fzf-lua").git_status({}) end, { desc = "git status (FZF)" }),
    map("n", "<leader>gb", function() require("fzf-lua").git_blame({}) end, { desc = "git blame (FZF)" }),
    map("n", "<leader>gt", function() require("fzf-lua").git_tags({}) end, { desc = "git tags (FZF)" }),

    -- search
    map("n", "<leader>sg", function() require("fzf-lua").live_grep({}) end, { desc = "Live Grep (FZF)" }),
    map("n", "<leader>sG", function() require("fzf-lua").live_grep_glob({}) end, { desc = "Live Grep --iglob(FZF)" }),
    map("n", "<leader>sr", function() require("fzf-lua").resume({}) end,
      { desc = "Resume Search Pattern (FZF)" }),
    map("n", "<leader>sw", function() require("fzf-lua").cword({}) end, { desc = "Search Word Under Cursor (FZF)" }),
    map("n", "<leader>sW", function() require("fzf-lua").cWORD({}) end, { desc = "Search WORD Under Cursor (FZF)" }),
    map("n", "<leader>sm", function() require("fzf-lua").manpages({}) end, { desc = "Man pages (FZF)" }),
    map("n", "<leader>sh", function() require("fzf-lua").help_tags({}) end, { desc = "Man pages (FZF)" }),
    map("n", "<leader>sk", function() require("fzf-lua").keymaps({}) end, { desc = "Key mappings (FZF)" }),

    -- tags
    map("n", "<leader>tf", function() require("fzf-lua").tags({}) end, { desc = "Search Project Tgs (FZF)" }),
    map("n", "<leader>tb", function() require("fzf-lua").btags({}) end, { desc = "Search Buffer Tags (FZF)" }),

    -- --LSP mappings in plugins/lsp.lua
    -- misc
    map("n", "<leader>tb", function() require("fzf-lua").tags({}) end, { desc = "Search Buffer Tags (FZF)" }),
  },
  opts = {
    files = {
      cwd_prompt = false,
    },
  }
}
