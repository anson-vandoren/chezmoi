return {
	{
		-- LazyGit integration
		"kdheepak/lazygit.nvim",
		lazy = true,
		cmd = {
			"LazyGit",
			"LazyGitConfig",
			"LazyGitCurrentFile",
			"LazyGitFilter",
			"LazyGitFilterCurrentFile",
		},
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
		keys = {
			{ "<leader>lg", "<cmd>LazyGit<cr>", desc = "LazyGit" },
		},
	},

	{
		"nvim-telescope/telescope.nvim",
		-- tag = "0.1.8",
		requires = {
			{ "nvim-lua/plenary.nvim" },
		},
	},

	-- show git diff in the sign column
	-- "airblade/vim-gitgutter",
	"lewis6991/gitsigns.nvim",

	-- Diff viewer and merge tool
	"sindrets/diffview.nvim",

	-- show git blame all the time
	{
		"APZelos/blamer.nvim",
		config = function()
			vim.g.blamer_enabled = true
		end,
	},
}
