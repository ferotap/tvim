local map = vim.keymap.set
return {
  {
    "lewis6991/gitsigns.nvim",
    init = function()
      -- gitsigns mappings
      map("n", "<leader>gsp", "<cmd>Gitsigns preview_hunk<cr>", { desc = "Preview hunk(Gitsigns)"  })
      map("n", "<leader>gstl", "<cmd>Gitsigns toggle_current_line_blame<cr>", { desc = "Toggle inline blame(Gitsigns)"  })
      map("n", "<leader>gsts", "<cmd>Gitsigns toggle_signs<cr>", { desc = "Toggle signs(Gitsigns)"  })

      -- putting fzf-lua mappings here to avoid overlappings in the mappins
      local fzf = require("fzf-lua")
      map("n", "<leader>gc", function() fzf.git_commits({}) end, { desc = "git commit log (project) (FZF)" })
      map("n", "<leader>gC", function() fzf.git_bcommits({}) end, { desc = "git commit log (buffer) (FZF)" })
      map("n", "<leader>gf", function() fzf.ls_files({}) end, { desc = "git ls-files (FZF)" })
      map("n", "<leader>gs", function() fzf.git_status({}) end, { desc = "git status (FZF)" })
      map("n", "<leader>gb", function() fzf.git_blame({}) end, { desc = "git blame (FZF)" })
      map("n", "<leader>gt", function() fzf.git_tags({}) end, { desc = "git tags (FZF)" })
      map("n", "<leader>gl", function() fzf.git_files({}) end, { desc = "git git_files  (FZF)" })
      map("n", "<leader>gL", function()
        fzf.grep({raw_cmd =
          [[git status -su | rg "^\s*M" | cut -d ' ' -f3 | xargs rg --hidden --column --line-number --no-heading --color=always  --with-filename -e '']]
        })
      end, { desc = "changed gitfiles  (FZF)" })
    end,
    opts = {
    },
  },
}
