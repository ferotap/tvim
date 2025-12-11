return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  opts = {
    -- your configuration comes here
    -- or leave it empty to use the default settings
    -- refer to the configuration section below
    bigfile = { enabled = true },
    dashboard = { enabled = true },
    indent = { enabled = true },
    input = { enabled = true },
    notifier = { enabled = true },
    quickfile = { enabled = true },
    scroll = { enabled = true },
    statuscolumn = { enabled = true },
    words = { enabled = true },
  },
  keys = {},
  init = function()
    vim.api.nvim_create_autocmd("User", {
      pattern = "VeryLazy",
      callback = function()
        -- Setup some globals for debugging (lazy-loaded)
        _G.dd = function(...)
          Snacks.debug.inspect(...)
        end
        _G.bt = function()
          Snacks.debug.backtrace()
        end
        vim.print = _G.dd -- Override print to use snacks for `:=` command

        -- Create some toggle mappings
        Snacks.toggle.option("spell", { name = "Spelling" }):map("<leader>us")
        Snacks.toggle.option("wrap", { name = "Wrap" }):map("<leader>uw")
        Snacks.toggle.option("relativenumber", { name = "Relative Number" }):map("<leader>uL")
        Snacks.toggle.diagnostics():map("<leader>ud")
        Snacks.toggle.line_number():map("<leader>ul")
        Snacks.toggle
            .option("conceallevel", { off = 0, on = vim.o.conceallevel > 0 and vim.o.conceallevel or 2 })
            :map("<leader>uc")
        Snacks.toggle.treesitter():map("<leader>uT")
        Snacks.toggle.option("background", { off = "light", on = "dark", name = "Dark Background" }):map("<leader>ub")
        Snacks.toggle.inlay_hints():map("<leader>uh")
        Snacks.toggle.indent():map("<leader>ug")
        Snacks.toggle.dim():map("<leader>uD")
        -- lazygit
        if vim.fn.executable("lazygit") == 1 then
          local map = vim.keymap.set
          map("n", "<leader>gg", function()
            Snacks.lazygit({ cwd = Snacks.git.get_root() })
          end, { desc = "LazyGit (Root Dir)" })

          map("n", "<leader>gG", function()
            Snacks.lazygit()
          end, { desc = "Lazygit (cwd)" })

          map("n", "<leader>glf", function()
            Snacks.lazygit.log_file()
          end, { desc = "Lazygit Current File History" })

          map("n", "<leader>gll", function()
            Snacks.lazygit.log({ cwd = Snacks.git.get_root() })
          end, { desc = "Lazygit Log" })
          map("n", "<leader>glL", function()
            Snacks.lazygit.log()
          end, { desc = "Lazygit Log (cwd)" })
        end
      end,
    })
  end,
}
