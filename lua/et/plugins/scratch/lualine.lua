local function treesitter_active()
  return vim.treesitter.highlighter.active[vim.api.nvim_get_current_buf()]
end

local tree_sitter = {
  cond = treesitter_active(),
  icon = require("nvim-web-devicons").get_icon_by_filetype(".bashrc", {}),
}

return {
  "nvim-lualine/lualine.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
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
        lualine_z = {
          tree_sitter,
        },
      },
      extensions = { "neo-tree", "lazy" },
    }
  end,
}
