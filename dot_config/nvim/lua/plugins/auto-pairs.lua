return {
	{
		-- add closing brace, etc. when opening
		"saghen/blink.pairs",
		version = "*", -- (recommended) only required with prebuilt binaries

		-- download prebuilt binaries from github releases
		dependencies = "saghen/blink.download",

		--- @module 'blink.pairs'
		--- @type blink.pairs.Config
		opts = {
			mappings = {
				-- you can call require("blink.pairs.mappings").enable() and require("blink.pairs.mappings").disable() to enable/disable mappings at runtime
				enabled = true,
				-- see the defaults: https://github.com/Saghen/blink.pairs/blob/main/lua/blink/pairs/config/mappings.lua#L10
				pairs = {},
			},
			highlights = {
				enabled = true,
				groups = {
					"BlinkPairsOrange",
					"BlinkPairsPurple",
					"BlinkPairsBlue",
				},
				matchparen = {
					enabled = true,
					group = "MatchParen",
				},
			},
			debug = false,
		},
	},
	-- { "windwp/nvim-autopairs", event = "InsertEnter", config = true },

	-- add closing tags for HTML
	-- "alvan/vim-closetag",
}
