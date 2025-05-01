return {
	-- show git diff in the sign column
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
