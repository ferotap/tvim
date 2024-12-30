return {
  "ibhagwan/fzf-lua",
  -- optional for icon support
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    -- calling `setup` is optional for customization
    local fzf = require("fzf-lua")
    local map = vim.keymap.set
    fzf.setup({
      keys = {
        -- buffers and files
        map("n", "<leader>fb", function() fzf.buffers({}) end, { desc = "Buffers (FZF)" }),
        map("n", "<leader>ff", function() fzf.files({}) end, { desc = "Files (FZF)" }),
        map("n", "<leader>fo", function() fzf.oldfiles({}) end, { desc = "Recent Files (FZF)" }),
        map("n", "<leader>fc", function() fzf.quickfix({}) end, { desc = "Quickfix List (FZF)" }),
        map("n", "<leader>fC", function() fzf.quickfix_stack({}) end, { desc = "Quickfix Stack (FZF)" }),
        map("n", "<leader>fl", function() fzf.loclist({}) end, { desc = "Loclist List (FZF)" }),
        map("n", "<leader>fL", function() fzf.loclist_stack({}) end, { desc = "Loclist Stack (FZF)" }),
        map("n", "<leader>ft", function() fzf.treesitter({}) end, { desc = "Treesitter Symbols(FZF)" }),

        -- git
        map("n", "<leader>gc", function() fzf.git_commits({}) end, { desc = "git commit log (project) (FZF)" }),
        map("n", "<leader>gC", function() fzf.git_bcommits({}) end, { desc = "git commit log (buffer) (FZF)" }),
        map("n", "<leader>gf", function() fzf.ls_files({}) end, { desc = "git ls-files (FZF)" }),
        map("n", "<leader>gs", function() fzf.git_status({}) end, { desc = "git status (FZF)" }),
        map("n", "<leader>gb", function() fzf.git_blame({}) end, { desc = "git blame (FZF)" }),
        map("n", "<leader>gt", function() fzf.git_tags({}) end, { desc = "git tags (FZF)" }),

        -- search
        map("n", "<leader>sg", function() fzf.live_grep({}) end, { desc = "Live Grep (FZF)" }),
        map("n", "<leader>sG", function() fzf.live_grep({}) end, { desc = "Live Grep --glob (FZF)" }),
        map("n", "<leader>sr", function() fzf.live_grep_resume({}) end, { desc = "Resume Search Pattern (FZF)" }),
        map("n", "<leader>sw", function() fzf.cword({}) end, { desc = "Search Word Under Cursor (FZF)" }),
        map("n", "<leader>sW", function() fzf.cWORD({}) end, { desc = "Search WORD Under Cursor (FZF)" }),
        map("n", "<leader>sm", function() fzf.manpages({}) end, { desc = "Man pages (FZF)" }),
        map("n", "<leader>sh", function() fzf.help_tags({}) end, { desc = "Man pages (FZF)" }),
        map("n", "<leader>sk", function() fzf.keymaps({}) end, { desc = "Key mappings (FZF)" }),

        -- tags
        map("n", "<leader>tf", function() fzf.tags({}) end, { desc = "Search Project Tgs (FZF)" }),
        map("n", "<leader>tb", function() fzf.btags({}) end, { desc = "Search Buffer Tags (FZF)" }),

        -- LSP

        map("n", "<leader>lr", function() fzf.lsp_references({}) end, {desc = "References (FZF)" }),
        map("n", "<leader>ld", function() fzf.lsp_definitions({}) end, {desc = "Definitions (FZF)" }),
        map("n", "<leader>lD", function() fzf.lsp_declarations({}) end, {desc = "Declarations (FZF)" }),
        map("n", "<leader>lt", function() fzf.lsp_typedefs({}) end, {desc = "Type Definitions (FZF)" }),
        map("n", "<leader>li", function() fzf.lsp_implementations({}) end, {desc = "Implementations (FZF)" }),
        map("n", "<leader>ld", function() fzf.lsp_document_symbols({}) end, {desc = "Document Symbols (FZF)" }),
        map("n", "<leader>lw", function() fzf.lsp_workspace_symbols({}) end, {desc = "Workspace Symbols (FZF)" }),
        map("n", "<leader>ll", function() fzf.lsp_live_workspace_symbols({}) end, {desc = "Workspace Symbols (live query) (FZF)" }),
        map("n", "<leader>li", function() fzf.lsp_incoming_calls({}) end, {desc = "Incoming Calls (FZF)" }),
        map("n", "<leader>lo", function() fzf.lsp_outgoing_calls({}) end, {desc = "Outgoing Calls (FZF)" }),
        map("n", "<leader>lc", function() fzf.lsp_code_actions({}) end, {desc = "Code Actions (FZF)" }),
        map("n", "<leader>lf", function() fzf.lsp_finder({}) end, {desc = "All LSP locations, combined view (FZF)" }),
        map("n", "<leader>lx", function() fzf.lsp_document_diagnostics({}) end, {desc = "diagnostics_document (FZF)" }),
        map("n", "<leader>lX", function() fzf.lsp_workspace_diagnostics({}) end, {desc = "diagnostics_workspace (FZF)" }),

        -- misc
        map("n", "<leader>tb", function() fzf.tags({}) end, { desc = "Search Buffer Tags (FZF)" }),
      },
    })
  end
}
