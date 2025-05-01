return {
	-- Misc QoL stuff
	{
		"folke/snacks.nvim",
		priority = 1000,
		lazy = false,
		--@type snacks.Config
		opts = {
			bufdelete = { enabled = true },
			gitbrowse = { enabled = true },
			indent = {
				only_scope = true,
				animate = {
					enabled = false,
				},
			},
			lazygit = {},
			picker = { enabled = true },
			terminal = { win = { style = "terminal" } },
		},

		keys = {
			{
				"<leader>lg",
				function()
					Snacks.lazygit()
				end,
				desc = "LazyGit (via Snacks)",
			},
			{
				"<leader>ft",
				function()
					Snacks.terminal()
				end,
				desc = "Open Floating Terminal (via Snacks)",
			},
		},
	},

	-- icons used elsewhere
	{ "nvim-tree/nvim-web-devicons", opts = {} },

	-- highlight other occurrances of a symbol
	"RRethy/vim-illuminate",

	-- change surrounding containers
	"tpope/vim-surround",

	-- { "mbbill/undotree" },

	-- LSP
	{
		"neovim/nvim-lspconfig",
		dependencies = { "saghen/blink.cmp" },
		config = function()
			local lspconfig = require("lspconfig")

			-- vim.diagnostic.config({
			-- 	update_in_insert = true,
			-- })

			local capabilities = require("blink-cmp").get_lsp_capabilities()
			lspconfig.lua_ls.setup({ capabilities = capabilities })

			-- Rust
			lspconfig.rust_analyzer.setup({
				capabilities = capabilities,

				-- server-specific settings
				settings = {
					["rust-analyzer"] = {
						assist = {
							emitMustUse = true,
							autoImport = true,
						},
						cargo = {
							allFeatures = true,
							allTargets = true,
						},
						check = {
							-- clippy is nice, but it's stupidly expensive
							-- command = "clippy",
							features = "all",
							allTargets = true,
						},
						checkOnSave = { enable = true },
						completion = {
							privateEditable = { enable = true },
							termSearch = { enable = true, fuel = 2000 },
						},
						diagnostics = {
							disabled = { "inactive-code" },
							experimental = { enable = true },
							styleLints = { enable = true },
						},
						files = {
							exclude = { "$HOME", "$HOME/.cargo/**", "$HOME/.rustup/**" },
						},
						hover = {
							actions = {
								references = { enable = true },
							},
						},
						imports = {
							granularity = { enforce = true },
							group = {
								enable = true,
							},
						},
						inlayHints = {
							bindingModeHints = { enable = true },
							chainingHints = { enable = true },
							closingBraceHints = { enable = true, minLines = 1 },
							closureCaptureHints = { enable = true },
							discriminantHints = { enable = true },
						},
						lens = {
							enable = true,
							references = {
								adt = { enable = true },
								enumVariant = { enable = true },
								method = { enable = true },
								trait = { enable = true },
							},
						},
					},
				},
			})

			-- Diagnostic Config
			-- See :help vim.diagnostic.Opts
			vim.diagnostic.config({
				severity_sort = true,
				float = { border = "rounded", source = "if_many" },
				underline = { severity = vim.diagnostic.severity.ERROR },
				signs = {
					text = {
						[vim.diagnostic.severity.ERROR] = "󰅚 ",
						[vim.diagnostic.severity.WARN] = "󰀪 ",
						[vim.diagnostic.severity.INFO] = "󰋽 ",
						[vim.diagnostic.severity.HINT] = "󰌶 ",
					},
				},
				virtual_text = {
					source = "if_many",
					spacing = 2,
				},
			})

			-- Global mappings
			-- See ':help vim.diagnostic.*' for documentation on any of the below
			vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float)
			vim.keymap.set("n", "<F8>", vim.diagnostic.goto_prev)
			vim.keymap.set("n", "<F9>", vim.diagnostic.goto_next)
			vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist)

			-- use LspAttach autocommand to only map the following keys
			-- after the language server attaches to the current buffer
			vim.api.nvim_create_autocmd("LspAttach", {
				group = vim.api.nvim_create_augroup("UserLspConfig", {}),

				callback = function(ev)
					vim.lsp.inlay_hint.enable(true, { bufnr = ev.buf })
					-- Enable completion triggered by <c-x><c->
					vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"

					-- Buffer local mappings
					-- See `:help vim.lsp.*` for documentation
					local map = function(keys, func, desc, mode)
						mode = mode or "n"
						vim.keymap.set(mode, keys, func, { buffer = ev.buf, desc = "LSP: " .. desc })
					end
					map("gd", "<Cmd>FzfLua lsp_definitions<CR>", "Go to Definition (FzfLua)")
					map("gr", "<Cmd>FzfLua lsp_references<CR>", "Go to References (FzfLua)")
					map("gh", vim.lsp.buf.hover, "Hover Action")
					map("gs", vim.lsp.buf.signature_help, "Signature Help")
					map("<C-t>", require("fzf-lua").lsp_live_workspace_symbols, "Search Workspace Symbols")
					map("<leader>rn", vim.lsp.buf.rename, "Rename")
					map(
						"<C-.>",
						"<Cmd>FzfLua lsp_code_actions winopts={height=0.15,width=0.6,row=0.55}<CR>",
						"Code Action (FzfLua)",
						{ "n", "v", "i" }
					) -- TODO: FzfLua can do this, but needs to be smaller
					map("<leader>fs", "<Cmd>FzfLua lsp_document_symbols<CR>", "Find Document Symbols (FzfLua)")
					map("<leader>fsw", "<Cmd>FzfLua lsp_workspace_symbols<CR>", "Find Workspace Symbols (FzfLua)")
				end,
			})
		end,
	},

	{
		"stevearc/aerial.nvim",
		opts = {},
		-- Optional dependencies
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
			"nvim-tree/nvim-web-devicons",
		},
		keys = {
			{ "<leader>{", "<Cmd>AerialToggle<CR>", desc = "Toggle Aerial" },
		},
	},

	{ -- Highlight, edit, and navigate code
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		main = "nvim-treesitter.configs", -- Sets main module to use for opts
		-- [[ Configure Treesitter ]] See `:help nvim-treesitter`
		opts = {
			ensure_installed = {
				"bash",
				"c",
				"diff",
				"elixir",
				"erlang",
				"html",
				"javascript",
				"json",
				"lua",
				"luadoc",
				"markdown",
				"markdown_inline",
				"query",
				"rust",
				"typescript",
				"vim",
				"vimdoc",
			},
			-- Autoinstall languages that are not installed
			auto_install = true,
			highlight = {
				enable = true,
				-- Some languages depend on vim's regex highlighting system (such as Ruby) for indent rules.
				--  If you are experiencing weird indenting issues, add the language to
				--  the list of additional_vim_regex_highlighting and disabled languages for indent.
				additional_vim_regex_highlighting = { "ruby" },
			},
			indent = { enable = true, disable = { "ruby" } },
			incremental_selection = {
				enable = true,
				keymaps = {
					init_selection = "<Enter>",
					node_incremental = "<Enter>",
					scope_incremental = false,
					node_decremental = "<Backspace>",
				},
			},
		},
		-- There are additional nvim-treesitter modules that you can use to interact
		-- with nvim-treesitter. You should go explore a few and see what interests you:
		--
		--    - Incremental selection: Included, see `:help nvim-treesitter-incremental-selection-mod`
		--    - Show your current context: https://github.com/nvim-treesitter/nvim-treesitter-context
		--    - Treesitter + textobjects: https://github.com/nvim-treesitter/nvim-treesitter-textobjects
	},

	{ "nvim-treesitter/nvim-treesitter-context" },
}
