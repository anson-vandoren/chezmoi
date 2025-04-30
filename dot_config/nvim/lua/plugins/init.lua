return {
	-- main color theme
	{
		"wincent/base16-nvim",
		lazy = false, -- load at start
		priority = 1000, -- load first
		config = function()
			vim.cmd([[colorscheme ayu-dark]])
			-- vim.o.background = "light"
		end,
	},

	"xiyaowong/transparent.nvim",

	{
		"nvim-telescope/telescope-fzf-native.nvim",
		build = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release",
	},

	-- Diff viewer and merge tool
	"sindrets/diffview.nvim",

	{
		"rcarriga/nvim-notify",
		config = function()
			require("notify").setup({
				background_colour = "#000000",
			})
		end,
	},
	-- lazy.nvim
	{
		"folke/noice.nvim",
		event = "VeryLazy",
		opts = {
			-- add any options here
		},
		dependencies = {
			"MunifTanjim/nui.nvim",
			"rcarriga/nvim-notify",
		},
	},

	-- TODO highlighting and browser
	{
		"folke/todo-comments.nvim",
		opts = {
			keywords = {
				FIX = {
					icon = " ", -- icon used for the sign, and in search results
					color = "error", -- can be a hex color, or a named color (see below)
					alt = { "FIXME", "BUG", "FIXIT", "ISSUE" }, -- a set of other keywords that all map to this FIX keywords
					-- signs = false, -- configure signs for some keywords individually
				},
				TODO = { icon = " ", color = "info" },
				HACK = { icon = " ", color = "warning" },
				WARN = { icon = " ", color = "warning", alt = { "WARNING", "XXX" } },
				PERF = { icon = " ", color = "perf", alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE", "BETTER" } },
				NOTE = { icon = " ", color = "hint", alt = { "INFO" } },
				TEST = { icon = "⏲ ", color = "test", alt = { "TESTING", "PASSED", "FAILED" } },
			},
			-- list of named colors where we try to extract the guifg from the
			-- list of highlight groups or use the hex color if hl not found as a fallback
			colors = {
				error = { "DiagnosticError", "ErrorMsg", "#DC2626" },
				warning = { "DiagnosticWarn", "WarningMsg", "#FBBF24" },
				info = { "DiagnosticInfo", "#2563EB" },
				hint = { "DiagnosticHint", "#10B981" },
				default = { "Identifier", "#7C3AED" },
				test = { "Identifier", "#FF00FF" },
				perf = { "#BC8191" },
			},
		},
	},

	-- Search and replace
	{
		"MagicDuck/grug-far.nvim",
		opts = { headerMaxWidth = 80 },
		cmd = "GrugFar",
		keys = {
			{
				"<leader>sr",
				function()
					local grug = require("grug-far")
					local ext = vim.bo.buftype == "" and vim.fn.expand("%:e")
					grug.open({
						transient = true,
						prefills = {
							filesFilter = ext and ext ~= "" and "*." .. ext or nil,
						},
					})
				end,
				mode = { "n", "v" },
				desc = "Search and Replace",
			},
		},
	},

	-- flashier search
	{
		"folke/flash.nvim",
		event = "VeryLazy",
		vscode = true,
		---@type Flash.Config
		opts = {},
    -- stylua: ignore
    keys = {
      { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
      { "S", mode = { "n", "o", "x" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
      { "r", mode = "o", function() require("flash").remote() end, desc = "Remote Flash" },
      { "R", mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
      { "<c-s>", mode = { "c" }, function() require("flash").toggle() end, desc = "Toggle Flash Search" },
    },
	},

	-- top bar
	{
		"akinsho/bufferline.nvim",
		event = "VeryLazy",
		keys = {
			{ "<leader>bp", "<Cmd>BufferLineTogglePin<CR>", desc = "Toggle Pin" },
			{ "<leader>bP", "<Cmd>BufferLineGroupClose ungrouped<CR>", desc = "Delete Non-Pinned Buffers" },
			{ "<leader>br", "<Cmd>BufferLineCloseRight<CR>", desc = "Delete Buffers to the Right" },
			{ "<leader>bl", "<Cmd>BufferLineCloseLeft<CR>", desc = "Delete Buffers to the Left" },
		},
		opts = {
			options = {
      -- stylua: ignore
      close_command = function(n) Snacks.bufdelete(n) end,
      -- stylua: ignore
      right_mouse_command = function(n) Snacks.bufdelete(n) end,
				diagnostics = "nvim_lsp",
				always_show_bufferline = false,
				diagnostics_indicator = function(_, _, diag)
					local icons = {
						Error = " ",
						Warn = " ",
						Hint = " ",
						Info = " ",
					}
					local ret = (diag.error and icons.Error .. diag.error .. " " or "")
						.. (diag.warning and icons.Warn .. diag.warning or "")
					return vim.trim(ret)
				end,
				offsets = {
					{
						filetype = "neo-tree",
						text = "Neo-tree",
						highlight = "Directory",
						text_align = "left",
					},
				},
				---@param opts bufferline.IconFetcherOpts
				get_element_icon = function(opts)
					if require("nvim-web-devicons").has_loaded() == false then
						require("nvim-web-devicons").setup()
					end
					return require("nvim-web-devicons").get_icon(opts.path, opts.extension)
				end,
			},
		},
		config = function(_, opts)
			require("bufferline").setup(opts)
			-- Fix bufferline when restoring a session
			vim.api.nvim_create_autocmd({ "BufAdd", "BufDelete" }, {
				callback = function()
					vim.schedule(function()
						pcall(nvim_bufferline)
					end)
				end,
			})
		end,
	},

	-- Misc QoL stuff
	{
		"folke/snacks.nvim",
		priority = 1000,
		lazy = false,
		--@type snacks.Config
		opts = {
			gitbrowse = { enabled = true },
			indent = {
				only_scope = true,
				animate = {
					enabled = false,
				},
			},
			bufdelete = { enabled = true },
			picker = { enabled = true },
			terminal = { win = { style = "terminal" } },
		},
	},

	-- icons used elsewhere
	{ "nvim-tree/nvim-web-devicons", opts = {} },

	-- LazyGit integration
	{
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

	-- session management
	{
		"folke/persistence.nvim",
		event = "BufReadPre",
		opts = {},
    -- stylua: ignore
    keys = {
      { "<leader>qs", function() require("persistence").load() end, desc = "Restore Session" },
      { "<leader>qS", function() require("persistence").select() end,desc = "Select Session" },
      { "<leader>ql", function() require("persistence").load({ last = true }) end, desc = "Restore Last Session" },
      { "<leader>qd", function() require("persistence").stop() end, desc = "Don't Save Current Session" },
    },
	},

	-- bottom bar
	{
		"itchyny/lightline.vim",
		lazy = false, -- load at the start since it's UI
		config = function()
			-- no need to also show mode in the cmd line since there's a bar
			vim.o.showmode = false
			vim.g.lightline = {
				active = {
					left = {
						{ "mode", "paste" },
						{ "readonly", "filename", "modified" },
					},
					right = {
						{ "lineinfo" },
						{ "percent" },
						{ "fileencoding", "filetype" },
					},
				},
				component_function = {
					filename = "LightlineFilename",
				},
			}
			function LightlineFilenameInLua(opts)
				if vim.fn.expand("%:t") == "" then
					return "[No Name]"
				else
					return vim.fn.getreg("%")
				end
			end

			vim.api.nvim_exec(
				[[
        function! g:LightlineFilename()
          return v:lua.LightlineFilenameInLua()
        endfunction
        ]],
				true
			)
		end,
	},

	{
		"nvim-telescope/telescope.nvim",
		-- tag = "0.1.8",
		requires = {
			{ "nvim-lua/plenary.nvim" },
		},
	},

	-- automatically go to project root when opening a file
	{
		"notjedi/nvim-rooter.lua",
		config = function()
			require("nvim-rooter").setup({
				fallback_to_parent = true,
				exclude_filetypes = { "man" },
			})
		end,
	},

	-- highlight other occurrances of a symbol
	"RRethy/vim-illuminate",

	-- change surrounding containers
	"tpope/vim-surround",

	-- add closing tags for HTML
	-- "alvan/vim-closetag",

	-- add closing brace, etc. when opening
	{
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

	-- show git diff in the sign column
	"airblade/vim-gitgutter",

	-- show git blame all the time
	{
		"APZelos/blamer.nvim",
		config = function()
			vim.g.blamer_enabled = true
		end,
	},

	-- see what keys are bound to what commands
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		opts = {
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
	},

	-- filesystem browser
	{
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v3.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons",
			"MunifTanjim/nui.nvim",
		},
		config = function()
			-- If you want icons for diagnostic errors, you'll need to define them somewhere:
			vim.fn.sign_define("DiagnosticSignError", { text = " ", texthl = "DiagnosticSignError" })
			vim.fn.sign_define("DiagnosticSignWarn", { text = " ", texthl = "DiagnosticSignWarn" })
			vim.fn.sign_define("DiagnosticSignInfo", { text = " ", texthl = "DiagnosticSignInfo" })
			vim.fn.sign_define("DiagnosticSignHint", { text = "󰌵", texthl = "DiagnosticSignHint" })

			require("neo-tree").setup({
				close_if_last_window = true, -- Close Neo-tree if it is the last window left in the tab
				filesystem = {
					follow_current_file = {
						enabled = true, -- This will find and focus the file in the active buffer every time
						--               -- the current file is changed while the tree is open.
						leave_dirs_open = false, -- `false` closes auto expanded dirs, such as with `:Neotree reveal`
					},
					window = {
						mappings = {
							["\\"] = "close_window",
						},
					},
				},
			})
		end,
		keys = {
			{ "\\", ":Neotree reveal<cr>", desc = "NeoTree reveal", silent = true },
		},
	},

	-- Typescript LSP
	{
		"pmizio/typescript-tools.nvim",
		dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
		opts = {},
	},

	-- { "mbbill/undotree" },

	-- LSP
	{
		"neovim/nvim-lspconfig",
		dependencies = { "saghen/blink.cmp" },
		opts = {
			servers = {
				lua_ls = {},
			},
		},
		config = function(_, opts)
			-- setup language servers
			local lspconfig = require("lspconfig")

			-- enable blink
			for server, config in pairs(opts.servers) do
				-- passing config.capabilities to blink.cmp merges with the capabilities in your
				-- `opts[server].capabilities, if you've defined it
				config.capabilities = require("blink.cmp").get_lsp_capabilities(config.capabilities)
				lspconfig[server].setup(config)
			end

			vim.diagnostic.config({
				update_in_insert = true,
			})

			-- Rust
			local capabilities = require("blink-cmp").get_lsp_capabilities()
			lspconfig.rust_analyzer.setup({
				capabilities = capabilities,
				on_attach = function(_, bufnr)
					vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
				end,

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
					format = function(diagnostic)
						local diagnostic_message = {
							[vim.diagnostic.severity.ERROR] = diagnostic.message,
							[vim.diagnostic.severity.WARN] = diagnostic.message,
							[vim.diagnostic.severity.INFO] = diagnostic.message,
							[vim.diagnostic.severity.HINT] = diagnostic.message,
						}
						return diagnostic_message[diagnostic.severity]
					end,
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
					-- Enable completion triggered by <c-x><c->
					vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"

					-- Buffer local mappings
					-- See `:help vim.lsp.*` for documentation
					local map = function(keys, func, desc, mode)
						mode = mode or "n"
						vim.keymap.set(mode, keys, func, { buffer = ev.buf, desc = "LSP: " .. desc })
					end
					map("gd", require("telescope.builtin").lsp_definitions, "Go to Definition")
					map("gr", function()
						Snacks.picker.lsp_references()
					end, "Go to References")
					map("gh", vim.lsp.buf.hover, "Hover Action")
					map("gs", vim.lsp.buf.signature_help, "Signature Help")
					map("<C-t>", require("telescope.builtin").lsp_dynamic_workspace_symbols, "Search Workspace Symbols")
					map("<leader>rn", vim.lsp.buf.rename, "Rename")
					map("<C-.>", vim.lsp.buf.code_action, "Code Action", { "n", "v", "i" })
					map("<leader>fs", function()
						Snacks.picker.lsp_symbols()
					end, "Find Symbols")
					map("<leader>fsw", function()
						Snacks.picker.lsp_symbols()
					end, "Find Symbols (Workspace)")
				end,
			})
		end,
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
		},
		-- There are additional nvim-treesitter modules that you can use to interact
		-- with nvim-treesitter. You should go explore a few and see what interests you:
		--
		--    - Incremental selection: Included, see `:help nvim-treesitter-incremental-selection-mod`
		--    - Show your current context: https://github.com/nvim-treesitter/nvim-treesitter-context
		--    - Treesitter + textobjects: https://github.com/nvim-treesitter/nvim-treesitter-textobjects
	},

	{ "nvim-treesitter/nvim-treesitter-context" },
	-- autoformat
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

	-- highligh, edit, navigate code
	-- different code completion
	{
		"saghen/blink.cmp",
		version = "*",
		opts = {
			keymap = { preset = "super-tab" },
			appearance = {
				use_nvim_cmp_as_default = true,
				nerd_font_variant = "mono",
			},
			cmdline = { enabled = true },
			completion = {
				accept = { auto_brackets = { enabled = false } },
				ghost_text = { enabled = true },
				keyword = { range = "prefix" },
				list = { selection = { preselect = true, auto_insert = false } },
				trigger = { show_in_snippet = false },
			},
			signature = { enabled = true },
			sources = {
				default = { "lsp", "path", "snippets", "buffer" },
			},
			fuzzy = { implementation = "prefer_rust_with_warning" },
		},
	},

	-- language support

	-- toml
	"cespare/vim-toml",

	-- yaml
	{
		"cuducos/yaml.nvim",
		ft = { "yaml" },
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
		},
	},

	-- rust
	-- {
	-- 	"rust-lang/rust.vim",
	-- 	ft = { "rust" },
	-- 	config = function()
	-- 		vim.g.rustfmt_emit_files = 1
	-- 		vim.g.rustfmt_fail_silently = 0
	-- 		vim.g.rust_clip_command = "xclip -sel clip"
	-- 	end,
	-- },

	-- markdown
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

	-- LALRPOP
	"qnighy/lalrpop.vim",
}
