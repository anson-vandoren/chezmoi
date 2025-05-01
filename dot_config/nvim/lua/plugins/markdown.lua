return {
	{
		"plasticboy/vim-markdown",
		ft = { "markdown" },
		dependencies = {
			"godlygeek/tabular",
		},
		config = function()
			-- folding in markdown is annoying
			vim.g.vim_markdown_folding_disabled = 1
			-- support front-matter
			vim.g.vim_markdown_frontmatter = 1
			-- 'o' on a list item should insert at same level
			vim.g.markdown_new_list_item_indent = 0
			-- don't add bullest when wrapping
			vim.g.vim_markdown_auto_insert_bullets = 0
		end,
	},

	{
		-- markdown rendering
		"MeanderingProgrammer/render-markdown.nvim",
		dependencies = { "nvim-treesitter/nvim-treesitter", "echasnovski/mini.icons" }, -- if you use the mini.nvim suite
		---@module 'render-markdown'
		---@type render.md.UserConfig
		opts = {
			completions = { blink = { enabled = true } },
		},
	},
}
