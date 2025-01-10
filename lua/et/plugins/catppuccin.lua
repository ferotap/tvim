local color = "catppuccin-mocha"
return {

  -- tokyonight
  {
    "folke/tokyonight.nvim",
    lazy = true,
    opts = { style = "moon" },
  },

  -- catppuccin
  {
    "catppuccin/nvim",
    priority = 1200,
    name = "catppuccin",
    opts = {
      dim_inactive = {
        enabled = true, -- dims the background color of inactive window
        shade = "light",
        percentage = 0.55, -- percentage of the shade to apply to the inactive window
      },
      integrations = {
        aerial = true,
        alpha = true,
        blink_cmp = true,
        dashboard = true,
        flash = true,
        grug_far = true,
        headlines = true,
        illuminate = true,
        indent_blankline = { enabled = false },
        leap = true,
        lsp_trouble = true,
        mason = true,
        markdown = true,
        native_lsp = {
          enabled = true,
          underlines = {
            errors = { "undercurl" },
            hints = { "undercurl" },
            warnings = { "undercurl" },
            information = { "undercurl" },
          },
        },
        navic = { enabled = true, custom_bg = "heirline" },
        neotest = true,
        neotree = true,
        noice = true,
        semantic_tokens = true,
        telescope = true,
        treesitter_context = true,
        which_key = true,
      },
    },
    config = function(opts)
      local ok, cat = pcall(require, "catppuccin")
      if not ok then
        vim.notify("failed to configure colorscheme", vim.log.levels.WARN)
        return false
      end
      cat.setup(opts)
      -- vim.cmd.colorscheme 'catppuccin'
      vim.cmd.colorscheme(color)
    end,
  },
}
