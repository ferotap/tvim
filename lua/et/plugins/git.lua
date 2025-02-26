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
      map("n", "<leader>gfc", function() fzf.git_commits({}) end, { desc = "git commit log (project) (FZF)" })
      map("n", "<leader>gfC", function() fzf.git_bcommits({}) end, { desc = "git commit log (buffer) (FZF)" })
      map("n", "<leader>gff", function() fzf.ls_files({}) end, { desc = "git ls-files (FZF)" })
      map("n", "<leader>gfs", function() fzf.git_status({}) end, { desc = "git status (FZF)" })
      map("n", "<leader>gfb", function() fzf.git_blame({}) end, { desc = "git blame (FZF)" })
      map("n", "<leader>gft", function() fzf.git_tags({}) end, { desc = "git tags (FZF)" })
      map("n", "<leader>gfl", function() fzf.git_files({}) end, { desc = "git git_files  (FZF)" })
      map("n", "<leader>gfL", function()
        fzf.grep({raw_cmd =
          [[git status -su | rg "^\s*M" | cut -d ' ' -f3 | xargs rg --hidden --column --line-number --no-heading --color=always  --with-filename -e '']]
        })
      end, { desc = "changed gitfiles  (FZF)" })
    end,
    opts = {
    },
  },
}
