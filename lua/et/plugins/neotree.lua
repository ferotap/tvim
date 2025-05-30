-- return {}

vim.cmd([[ let g:neo_tree_remove_legacy_commands = 1 ]])
return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    cmd = "Neotree",
    keys = {
      -- {
      --   "<leader>fe",
      --   function()
      --     require("neo-tree.command").execute({ toggle = true, dir = LazyVim.root() })
      --   end,
      --   desc = "Explorer NeoTree (Root Dir)",
      -- },
      {
        "<leader>fE",
        function()
          require("neo-tree.command").execute({ toggle = true, dir = vim.uv.cwd() })
        end,
        desc = "Explorer NeoTree (cwd)",
      },
      {
        "<leader>e",
        function()
          require("neo-tree.command").execute({ toggle = true, dir = vim.loop.cwd() })
        end,
        desc = "Explorer NeoTree (cwd)",
      },
      {
        "<leader>ge",
        function()
          require("neo-tree.command").execute({ source = "git_status", toggle = true })
        end,
        desc = "Git Explorer",
      },
      {
        "<leader>be",
        function()
          require("neo-tree.command").execute({ source = "buffers", toggle = true })
        end,
        desc = "Buffer Explorer",
      },
    },
    dependencies = {
      "nvim-lua/plenary.nvim",
      "echasnovski/mini.icons", -- not strictly required, but recommended
      "MunifTanjim/nui.nvim",
    },
    deactivate = function()
      vim.cmd([[Neotree close]])
    end,
    init = function()
      -- FIX: use `autocmd` for lazy-loading neo-tree instead of directly requiring it,
      -- because `cwd` is not set up properly.
      vim.api.nvim_create_autocmd("BufEnter", {
        group = vim.api.nvim_create_augroup("Neotree_start_directory", { clear = true }),
        desc = "Start Neo-tree with directory",
        once = true,
        callback = function()
          if package.loaded["neo-tree"] then
            return
          else
            local stats = vim.uv.fs_stat(vim.fn.argv(0))
            if stats and stats.type == "directory" then
              require("neo-tree")
            end
          end
        end,
      })
    end,
    opts = {
      sources = { "filesystem", "buffers", "git_status" },
      open_files_do_not_replace_types = { "terminal", "Trouble", "trouble", "qf", "Outline" },
      filesystem = {
        bind_to_cwd = false,
        follow_current_file = { enabled = true },
        use_libuv_file_watcher = true,
      },
      window = {
        mappings = {
          ["l"] = "open",
          ["h"] = "close_node",
          ["<space>"] = "none",
          ["u"] = "close_all_subnodes",
          ["U"] = "expand_all_subnodes",
          ["z"] = "close_all_nodes",
          ["Z"] = "expand_all_nodes",
          ["Y"] = {
            function(state)
              local node = state.tree:get_node()
              local path = node:get_id()
              vim.fn.setreg("+", path, "c")
            end,
            desc = "Copy Path to Clipboard",
          },
          ["O"] = {
            function(state)
              require("lazy.util").open(state.tree:get_node().path, { system = true })
            end,
            desc = "Open with System Application",
          },
          ["P"] = { "toggle_preview", config = { use_float = true } },
        },
      },
      default_component_configs = {
        indent = {
          with_expanders = true, -- if nil and file nesting is enabled, will enable expanders
          expander_collapsed = "",
          expander_expanded = "",
          expander_highlight = "NeoTreeExpander",
        },
        git_status = {
          symbols = {
            unstaged = "󰄱",
            staged = "󰱒",
          },
        },
      },
    },
    config = function(_, opts)
      local function on_move(data)
        Snacks.rename.on_rename_file(data.source, data.destination)
      end

      local events = require("neo-tree.events")
      opts.event_handlers = opts.event_handlers or {}
      vim.list_extend(opts.event_handlers, {
        { event = events.FILE_MOVED,   handler = on_move },
        { event = events.FILE_RENAMED, handler = on_move },
      })
      require("neo-tree").setup(opts)
      vim.api.nvim_create_autocmd("TermClose", {
        pattern = "*lazygit",
        callback = function()
          if package.loaded["neo-tree.sources.git_status"] then
            require("neo-tree.sources.git_status").refresh()
          end
        end,
      })
    end,
  },
}

-- return {
-- 	"nvim-neo-tree/neo-tree.nvim",
-- 	version = "*",
-- 	branch = "v3.x",
-- 	cmd = "Neotree",
-- 	keys = {
-- 		{
-- 			"<leader>e",
-- 			function()
-- 				require("neo-tree.command").execute({ toggle = true, dir = vim.loop.cwd() })
-- 			end,
-- 			desc = "Explorer NeoTree (cwd)",
-- 		},
-- 	},
-- 	dependencies = {
-- 		"nvim-lua/plenary.nvim",
-- 		"nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
-- 		"MunifTanjim/nui.nvim",
-- 	},
-- 	opts = function()
-- 		return {
-- 			auto_clean_after_session_restore = true,
-- 			close_if_last_window = true,
-- 			sources = { "filesystem", "buffers", "git_status" },
-- 			window = {
-- 				width = 30,
-- 				mappings = {
-- 					["<space>"] = false, -- disable space until we figure out which-key disabling
-- 					["[b"] = "prev_source",
-- 					["]b"] = "next_source",
-- 				},
-- 				fuzzy_finder_mappings = { -- define keymaps for filter popup window in fuzzy_finder_mode
-- 					["<C-j>"] = "move_cursor_down",
-- 					["<C-k>"] = "move_cursor_up",
-- 				},
-- 			},
-- 			filesystem = {
-- 				follow_current_file = { enabled = true },
-- 				use_libuv_file_watcher = true,
-- 			},
-- 		}
-- 	end,
-- }
