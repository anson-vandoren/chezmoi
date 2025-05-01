return {
	{
		-- tree-line, sidebar filesystem browser
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v3.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons",
			"MunifTanjim/nui.nvim",
		},
		config = function()
			-- If you want icons for diagnostic errors, you'll need to define them somewhere:
			vim.fn.sign_define("DiagnosticSignError", { text = " ", texthl = "DiagnosticSignError" })
			vim.fn.sign_define("DiagnosticSignWarn", { text = " ", texthl = "DiagnosticSignWarn" })
			vim.fn.sign_define("DiagnosticSignInfo", { text = " ", texthl = "DiagnosticSignInfo" })
			vim.fn.sign_define("DiagnosticSignHint", { text = "󰌵", texthl = "DiagnosticSignHint" })

			require("neo-tree").setup({
				close_if_last_window = true, -- Close Neo-tree if it is the last window left in the tab
				filesystem = {
					follow_current_file = {
						enabled = true, -- This will find and focus the file in the active buffer every time
						--               -- the current file is changed while the tree is open.
						leave_dirs_open = false, -- `false` closes auto expanded dirs, such as with `:Neotree reveal`
					},
					window = {
						mappings = {
							["\\"] = "close_window",
						},
					},
				},
			})
		end,
		keys = {
			{ "\\", ":Neotree reveal<cr>", desc = "NeoTree reveal", silent = true },
		},
	},

	-- buffer-based filesystem browser
	{
		"stevearc/oil.nvim",
		---@module 'oil'
		---@type oil.SetupOpts
		opts = {
			columns = {
				"icon",
				"permissions",
				"size",
				"mtime",
			},
			watch_for_changes = true,
			view_options = {
				show_hidden = true,
			},
		},
		-- Optional dependencies
		dependencies = { { "echasnovski/mini.icons", opts = {} } },
		-- dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if you prefer nvim-web-devicons
		-- Lazy loading is not recommended because it is very tricky to make it work correctly in all situations.
		lazy = false,
		keys = {
			{ "-", ":Oil --float<cr>", desc = "Floating pane for files in cwd" },
		},
	},

	-- automatically go to project root when opening a file
	{
		"notjedi/nvim-rooter.lua",
		config = function()
			require("nvim-rooter").setup({
				fallback_to_parent = true,
				exclude_filetypes = { "man", "oil" },
			})
		end,
	},
}
