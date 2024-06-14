vim.cmd([[ let g:neo_tree_remove_legacy_commands = 1 ]])

return {
	"nvim-neo-tree/neo-tree.nvim",
	version = "*",
	branch = "v3.x",
	cmd = "Neotree",
	keys = {
		{
			"<leader>e",
			function()
				require("neo-tree.command").execute({ toggle = true, dir = vim.loop.cwd() })
			end,
			desc = "Explorer NeoTree (cwd)",
		},
	},
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
		"MunifTanjim/nui.nvim",
	},
	opts = function()
		return {
			auto_clean_after_session_restore = true,
			close_if_last_window = true,
			sources = { "filesystem", "buffers", "git_status" },
			window = {
				width = 30,
				mappings = {
					["<space>"] = false, -- disable space until we figure out which-key disabling
					["[b"] = "prev_source",
					["]b"] = "next_source",
				},
				fuzzy_finder_mappings = { -- define keymaps for filter popup window in fuzzy_finder_mode
					["<C-j>"] = "move_cursor_down",
					["<C-k>"] = "move_cursor_up",
				},
			},
			filesystem = {
				follow_current_file = { enabled = true },
				use_libuv_file_watcher = true,
			},
		}
	end,
}
