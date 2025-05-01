return {
	-- see what keys are bound to what commands
	"folke/which-key.nvim",
	event = "VeryLazy",
	opts = {
		delay = 0,
		spec = {
			mode = { "n", "v" },
			{ "<leader>f", group = "file/find" },
			{ "<leader>x", group = "diagnostics/quickfix", icon = { icon = "󱖫 ", color = "green" } },
			{ "<leader>t", group = "TODOs" },
			{
				"<leader>b",
				group = "buffer",
				expand = function()
					return require("which-key.extras").expand.buf()
				end,
			},
			{
				"<leader>w",
				group = "windows",
				proxy = "<c-w>",
				expand = function()
					return require("which-key.extras").expand.win()
				end,
			},
		},
	},
	keys = {
		{
			"<leader>?",
			function()
				require("which-key").show({ global = false })
			end,
			desc = "Buffer Local Keymaps (which-key)",
		},
	},
}
