local function treesitter_active()
  return vim.treesitter.highlighter.active[vim.api.nvim_get_current_buf()]
end

local tree_sitter = {
  cond = treesitter_active(),
  icon = require("echasnovski/mini.icons").get_icon_by_filetype(".bashrc", {}),
}

return {
  {
    "echasnovski/mini.icons"
  },
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "echasnovski/mini.icons" },
    config = function()
      local lualine = require "lualine"
      local lazy_status = require "lazy.status" -- to configure lazy pending updates count

      -- configure lualine with modified theme
      lualine.setup {
        options = {
          -- theme = "catppuccin",
          theme = "auto",
        },
        sections = {
          lualine_a = {
            "mode",
          },
          lualine_b = {
            "branch",
            "diff",
            "diagnostics",
          },
          lualine_c = {
            "filename",
          },
          lualine_x = {
            {
              lazy_status.updates,
              cond = lazy_status.has_updates,
              color = { fg = "#ff9e64" },
            },
            { "encoding" },
            { "fileformat" },
            { "filetype" },
          },
          lualine_y = {
            { "progress", separator = " ",                  padding = { left = 1, right = 0 } },
            { "location", padding = { left = 0, right = 1 } },
          },
          lualine_z = {
            tree_sitter,
          },
        },
        extensions = { "neo-tree", "lazy", "fzf" },
      }
    end,
  },
}
