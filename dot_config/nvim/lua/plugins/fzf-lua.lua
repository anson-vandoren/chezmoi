return {
	"ibhagwan/fzf-lua",
	-- optional for icon support
	-- dependencies = { "nvim-tree/nvim-web-devicons" },
	-- or if using mini.icons/mini.nvim
	dependencies = { "echasnovski/mini.icons" },
	version = "*",
	event = "VeryLazy",
	keys = {
		{ "<leader>fz", "<Cmd>FzfLua resume<CR>", desc = "Resume FzfLua" },
		{ "<leader>fo", "<Cmd>FzfLua oldfiles<CR>", desc = "Find Old Files (FzfLua)" },
		{ "<leader>fl", "<Cmd>FzfLua lines<CR>", desc = "Find Lines in Current Buffer (FzfLua)" },
		{ "<leader>fd", "<Cmd>FzfLua diagnostics_workspace<CR>", desc = "Find Workspace Diagnostics (FzfLua)" },
		{ "<leader><leader>", "<Cmd>FzfLua buffers<CR>", desc = "Find Buffer (FzfLua)" },
		{ "<C-p>", "<Cmd>FzfLua files<CR>", desc = "Find Files (FzfLua)" },
		{ "<leader>a", "<Cmd>FzfLua live_grep_native<CR>", desc = "Live grep Project (FzfLua)" },
		{ "<leader>/", "<Cmd>FzfLua lgrep_curbuf<CR>", desc = "Live grep Current Buffer (FzfLua)" },
		{ "<leader>fw", "<Cmd>FzfLua grep_cword<CR>", desc = "Find Current Word (FzfLua)" },
		{ "<leader>fW", "<Cmd>FzfLua grep_cWORD<CR>", desc = "Find Current WORD (FzfLua)" },
		{ "<leader>fj", "<Cmd>FzfLua jumps<CR>", desc = "Find Jumps (FzfLua)" },
		{ "<leader>fr", "<Cmd>FzfLua registers<CR>", desc = "Find in Registers (FzfLua)" },
		{ "<leader>fO", "<Cmd>FzfLua nvim_options<CR>", desc = "Find in Neovim Options (FzfLua)" },
		{ "<leader>fc", "<Cmd>FzfLua command_history<CR>", desc = "Find in Command History (FzfLua)" },
		{ "<leader>fC", "<Cmd>FzfLua commands<CR>", desc = "Find Neovim Command (FzfLua)" },
		{ "<leader>fh", "<Cmd>FzfLua helptags<CR>", desc = "Find Neovim Help Tags (FzfLua)" },
		{ "<leader>fm", "<Cmd>FzfLua manpages<CR>", desc = "Find Man Pages (FzfLua)" },
		{ "<leader>fk", "<Cmd>FzfLua keymaps<CR>", desc = "Find Keymaps (FzfLua)" },
		{
			"<leader>fvf",
			function()
				require("fzf-lua").files({ cwd = vim.fn.stdpath("config") })
			end,
			desc = "Find Files in Neovim Config (FzfLua)",
		},
		{
			"<leader>fva",
			function()
				require("fzf-lua").live_grep({ cwd = vim.fn.stdpath("config") })
			end,
			desc = "Live grep in Neovim Config (FzfLua)",
		},
	},
	opts = {
		"hide",
		winopts = {
			backdrop = 100,
		},
	},
}
