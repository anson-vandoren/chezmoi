return {
	{
		"stevearc/conform.nvim",
		event = { "BufWritePre" },
		cmd = { "ConformInfo" },
		keys = {
			{
				"<leader>f",
				function()
					require("conform").format({ async = true, lsp_format = "never" })
				end,
				mode = "",
				desc = "Format buffer",
			},
		},
		opts = {
			notify_on_error = true,
			format_on_save = {
				timeout_ms = 500,
			},
			formatters_by_ft = {
				lua = { "stylua" },
				rust = { "rustfmt" },
				typescript = { "prettier" },
			},
			formatters = {
				rustfmt = {
					prepend_args = {
						"--config-path",
						".rustfmt.stable.toml",
						"--config",
						"unstable_features=true",
						"--config",
						"imports_granularity=Crate",
						"--config",
						"reorder_impl_items=true",
						"--config",
						"group_imports=StdExternalCrate",
					},
				},
			},
		},
	},
}
