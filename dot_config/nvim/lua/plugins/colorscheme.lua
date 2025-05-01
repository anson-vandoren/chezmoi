return {
	{
		"wincent/base16-nvim",
		lazy = false, -- load at start
		priority = 1000, -- load first
		config = function()
			vim.cmd([[colorscheme ayu-dark]])
			vim.cmd([[set termguicolors]])
			vim.o.background = "dark"
		end,
	},

	"xiyaowong/transparent.nvim",
}
