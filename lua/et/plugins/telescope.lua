-- Telescope live_grep in git root
-- Function to find the git root directory based on the current buffer's path
local function find_git_root()
  -- Use the current buffer's path as the starting point for the git search
  local current_file = vim.api.nvim_buf_get_name(0)
  local current_dir
  local cwd = vim.fn.getcwd()
  -- If the buffer is not associated with a file, return nil
  if current_file == "" then
    current_dir = cwd
  else
    -- Extract the directory from the current file's path
    current_dir = vim.fn.fnamemodify(current_file, ":h")
  end

  -- Find the Git root directory from the current file's path
  local git_root = vim.fn.systemlist("git -C " .. vim.fn.escape(current_dir, " ") .. " rev-parse --show-toplevel")[1]
  if vim.v.shell_error ~= 0 then
    print("Not a git repository. Searching on current working directory")
    return cwd
  end
  return git_root
end

-- Custom live_grep function to search in git root
local function live_grep_git_root()
  local git_root = find_git_root()
  if git_root then
    require("telescope.builtin").live_grep({
      search_dirs = { git_root },
    })
  end
end

vim.api.nvim_create_user_command("LiveGrepGitRoot", live_grep_git_root, {})

return {
  {
    "nvim-telescope/telescope.nvim",
    branch = "0.1.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      -- Fuzzy Finder Algorithm which requires local dependencies to be built.
      -- Only load if `make` is available. Make sure you have the system
      -- requirements installed.
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        -- NOTE: If you are having trouble with this installation,
        --       refer to the README for telescope-fzf-native for more instructions.
        build = "make",
        cond = function()
          return vim.fn.executable("make") == 1
        end,
      },
      {
        "nvim-telescope/telescope-live-grep-args.nvim",
      },
    },
    config = function()
      -- [[ Configure Telescope ]]
      -- See `:help telescope` and `:help telescope.setup()`

      local map = vim.keymap.set
      local ok, lga_actions, lga_shortcuts
      ok, lga_actions = pcall(require, "telescope-live-grep-args.actions")
      if not ok then
        vim.notify("telescope-live-grep actions not found", vim.log.levels.ERROR)
      end

      ok, lga_shortcuts = pcall(require, "telescope-live-grep-args.shortcuts")
      if not ok then
        vim.notify("telescope-live-grep actions not found", vim.log.levels.ERROR)
      end

      -- Telescope keymaps
      map("v", "<leader>sv", lga_shortcuts.grep_word_under_cursor)
      map("n", "<leader>sw", lga_shortcuts.grep_word_under_cursor)
      map("n", "<leader>fo", require("telescope.builtin").oldfiles, { desc = "[?] Find recently opened files" })
      map("n", "<leader>fb", require("telescope.builtin").buffers, { desc = "[ ] Find existing buffers" })
      map("n", "<leader>ff", require("telescope.builtin").find_files, { desc = "[S]earch [F]iles" })
      map("n", "<leader>fg", require("telescope.builtin").git_files, { desc = "Search [G]it [F]iles" })
      map("n", "<leader>s/", function()
        -- You can pass additional configuration to telescope to change theme, layout, etc.
        require("telescope.builtin").current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
          winblend = 10,
          previewer = false,
        }))
      end, { desc = "[/] Fuzzily search in current buffer" })

      local function telescope_live_grep_open_files()
        require("telescope.builtin").live_grep({
          grep_open_files = true,
          prompt_title = "Live Grep in Open Files",
        })
      end
      local function telescope_live_grep_args()
        require("telescope").extensions.live_grep_args.live_grep_args()
      end
      map("n", "<leader>sg", telescope_live_grep_args, { desc = "Live grep with args" })
      map("n", "<leader>s/", telescope_live_grep_open_files, { desc = "[S]earch [/] in Open Files" })
      map("n", "<leader>ss", require("telescope.builtin").builtin, { desc = "[S]earch [S]elect Telescope" })
      map("n", "<leader>sh", require("telescope.builtin").help_tags, { desc = "[S]earch [H]elp" })
      map("n", "<leader>sw", require("telescope.builtin").grep_string, { desc = "[S]earch current [W]ord" })
      -- map('n', '<leader>sg', require('telescope.builtin').live_grep, { desc = '[S]earch by [G]rep' })
      map("n", "<leader>sG", ":LiveGrepGitRoot<cr>", { desc = "[S]earch by [G]rep on Git Root" })
      map("n", "<leader>sd", require("telescope.builtin").diagnostics, { desc = "[S]earch [D]iagnostics" })
      map("n", "<leader>sr", require("telescope.builtin").resume, { desc = "[S]earch [R]esume" })

      require("telescope").setup({
        extensions = {
          ["ui-select"] = {},
          live_grep_args = {
            auto_quoting = false, -- enable/disable auto-quoting
            -- define mappings, e.g.
            mappings = {          -- extend mappings
              i = {
                ["<C-k>"] = lga_actions.quote_prompt(),
                ["<C-i>"] = lga_actions.quote_prompt({ postfix = " --iglob " }),
                ["<C-j>"] = lga_actions.quote_prompt({ postfix = " --iglob '**/src/main/java/**'" }),
                ["<C-t>"] = lga_actions.quote_prompt({ postfix = " --iglob '**/src/test/java/**'" }),
              },
            },
          },
        },
        defaults = {
          mappings = {
            i = {
              ["<C-u>"] = false,
              ["<C-d>"] = false,
            },
          },
        },
      })
      -- Enable telescope fzf native, if installed
      pcall(require("telescope").load_extension, "fzf")
      pcall(require("telescope").load_extension, "live_grep_args")
      pcall(require("telescope").load_extension, "ui-select")
    end,
  },
  {
    "nvim-telescope/telescope-ui-select.nvim",
  },
}
