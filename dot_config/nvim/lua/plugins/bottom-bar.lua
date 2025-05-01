return {
	-- Status line
	-- {
	-- 	"itchyny/lightline.vim",
	-- 	lazy = false, -- load at the start since it's UI
	-- 	config = function()
	-- 		-- no need to also show mode in the cmd line since there's a bar
	-- 		vim.o.showmode = false
	-- 		vim.g.lightline = {
	-- 			active = {
	-- 				left = {
	-- 					{ "mode", "paste" },
	-- 					{ "readonly", "filename", "modified" },
	-- 				},
	-- 				right = {
	-- 					{ "lineinfo" },
	-- 					{ "percent" },
	-- 					{ "fileencoding", "filetype" },
	-- 				},
	-- 			},
	-- 			component_function = {
	-- 				filename = "LightlineFilename",
	-- 			},
	-- 		}
	-- 		function LightlineFilenameInLua(opts)
	-- 			if vim.fn.expand("%:t") == "" then
	-- 				return "[No Name]"
	-- 			else
	-- 				return vim.fn.getreg("%")
	-- 			end
	-- 		end
	--
	-- 		vim.api.nvim_exec(
	-- 			[[
	--        function! g:LightlineFilename()
	--          return v:lua.LightlineFilenameInLua()
	--        endfunction
	--        ]],
	-- 			true
	-- 		)
	-- 	end,
	-- },
	-- { "echasnovski/mini.statusline", version = "false", opts = {}, lazy = false },
	-- -- Icons as mini.statusline dependency
	-- { "echasnovski/mini.icons", version = false },
	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		opts = {
			options = {
				theme = "ayu_mirage",
			},
			sections = {
				lualine_a = { "mode" },
				lualine_b = { "branch", "diff", "diagnostics" },
				lualine_c = { "filename" },
				lualine_x = { "encoding", "filetype" },
				lualine_y = { "lsp_status" },
				lualine_z = { "location" },
			},
			inactive_sections = {
				lualine_a = {},
				lualine_b = {},
				lualine_c = { "filename" },
				lualine_x = { "location" },
				lualine_y = {},
				lualine_z = {},
			},
		},
		lazy = false,
	},
}
