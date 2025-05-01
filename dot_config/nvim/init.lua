-- Make sure to setup `mapLeader` and `mapLocalLeader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
vim.g.mapleader = ","
vim.g.maplocalleader = "\\"

------------------------------
-- general nvim preferences --
------------------------------

-- disable folding
-- vim.opt.foldenable = false
-- vim.opt.foldmethod = manual
-- vim.opt.foldlevelstart = 99

-- keep more context on screen while scrolling
vim.opt.scrolloff = 2
-- don't show linebreaks if they're not really there
vim.opt.wrap = false
-- always draw the sign column to prevent buffer shifting right/left
vim.opt.signcolumn = "yes"
-- relative line numbers
vim.opt.relativenumber = true
-- except for the current line, show the absolute line number
vim.opt.number = true
-- keep current content top + left when splitting
vim.opt.splitright = true
vim.opt.splitbelow = true
-- infinite undo (in ~/.local/state/nvim/undo)
vim.opt.undofile = true
-- wildmenu
-- for completions, when there is more than one match,
-- list all matches and only complete the longest common match
-- vim.opt.wildmode = "list:longest"
-- when opening a file like with :e, don't suggest these sorts of files:
vim.opt.wildignore = ".hg,.svn,*~,*.png,*.jpg,*.gif,*.min.js,*.swp,*.o,vendor,dist,_site"
-- tabs
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2
vim.opt.tabstop = 2
vim.opt.expandtab = true
-- case-insensitive search/replace
vim.opt.ignorecase = true
-- unless the search term contains uppercase
vim.opt.smartcase = true
-- no audible beep
vim.opt.vb = true
-- improve diffs (nvim -d)
-- ignore whitespace
vim.opt.diffopt:append("iwhite")
-- use a smarter algorithm
--- https://stackoverflow.com/questions/32365271/whats-the-difference-between-git-diff-patience-and-git-diff-histogram
--- https://luppeng.wordpress.com/2020/10/10/when-to-use-each-of-the-git-diff-algorithms/
vim.opt.diffopt:append("algorithm:histogram")
vim.opt.diffopt:append("indent-heuristic")
-- show a column at 120 chars as a guide for long lines
vim.opt.colorcolumn = "120"
-- use system clipboard
vim.api.nvim_set_option("clipboard", "unnamedplus")
-- current line highlighting
vim.opt.cursorline = true

-------------
-- hotkeys --
-------------

local map = vim.keymap.set
-- leader-space to stop searching
map("n", "<esc>", "<cmd>nohlsearch<cr>")

-- always center search results
map("n", "n", "nzz", { silent = true })
map("n", "N", "Nzz", { silent = true })
map("n", "*", "*zz", { silent = true })

-- "very magic" (less escaping needed) regexes by default
map("n", "?", "?\\v")
map("n", "/", "/\\v")
map("n", "%s/", "%sm/")

-- switch buffers left and right with arrow keys
map("n", "<left>", ":bp<cr>")
map("n", "<right>", ":bn<cr>")

-- j and k move by visual line, not actual line
map("n", "j", "gj")
map("n", "k", "gk")

-- delete this buffer
map("n", "<leader>bd", function()
	Snacks.bufdelete()
end, { desc = "Delete Buffer" })

-- delete the other buffers
map("n", "<leader>bo", function()
	Snacks.bufdelete.other()
end, { desc = "Delete Other Buffers" })

-- better indenting
map("v", "<", "<gv")
map("v", ">", ">gv")

-- lazy console
map("n", "<leader>l", "<cmd>Lazy<cr>", { desc = "Lazy" })

-- lazygit
if vim.fn.executable("lazygit") == 1 then
	local LazyRoot = require("config.root")
	LazyRoot.setup()
	map("n", "<leader>gf", function()
		Snacks.picker.git_log_file()
	end, { desc = "Git Current File History" })
	map("n", "<leader>gl", function()
		Snacks.picker.git_log({ cwd = LazyRoot.git() })
	end, { desc = "Git Log" })
end

-- quit
map("n", "<leader>qq", "<cmd>qa<cr>", { desc = "Quit All" })

-- open git remote
map({ "n", "x" }, "<leader>gB", function()
	Snacks.gitbrowse()
end, { desc = "Git Browse (open)" })

-- Undo
map("n", "<leader>fu", function()
	Snacks.picker.undo()
end, { desc = "Search Undos" })

-- TODOs
map("n", "<leader>tn", function()
	require("todo-comments").jump_next()
end, { desc = "Next TODO" })
map("n", "<leader>tp", function()
	require("todo-comments").jump_next()
end, { desc = "Previous TODO" })
map("n", "<leader>tt", "<cmd>TodoTelescope<cr>", { desc = "Toggle TODO list" })

-- Git diff view (merge conflict resolution)
map("n", "<leader>dv", "<cmd>DiffviewOpen<cr>", { desc = "Open Diff View" })

------------------
-- autocommands --
------------------

-- highlight yanked text
vim.api.nvim_create_autocmd("TextYankPost", {
	pattern = "*",
	command = "silent! lua vim.highlight.on_yank({ timeout = 700 })",
})
-- jump to last edit position on opening file
vim.api.nvim_create_autocmd("BufReadPost", {
	pattern = "*",
	callback = function()
		if vim.fn.line("'\"") > 1 and vim.fn.line("'\"") <= vim.fn.line("$") then
			-- except for in git commit messages
			-- https://stackoverflow.com/questions/31449496/vim-ignore-specifc-file-in-autocommand
			if not vim.fn.expand("%:p"):find(".git", 1, true) then
				vim.cmd('exe "normal! g\'\\""')
			end
		end
	end,
})
-- autosave on lose focus
vim.api.nvim_create_autocmd({ "BufLeave", "FocusLost" }, {
	pattern = "*",
	command = "silent! wall",
})

-- finally, load plugins via lazyvim
require("config.lazy")

require("noice").setup({
	lsp = {
		-- override markdown rendering so that **cmp** and other plugins use **Treesitter**
		override = {
			["vim.lsp.util.convert_input_to_markdown_lines"] = true,
			["vim.lsp.util.stylize_markdown"] = true,
			["cmp.entry.get_documentation"] = true, -- requires hrsh7th/nvim-cmp
		},
	},
	-- you can enable a preset for easier configuration
	presets = {
		bottom_search = true, -- use a classic bottom cmdline for search
		command_palette = true, -- position the cmdline and popupmenu together
		long_message_to_split = true, -- long messages will be sent to a split
		inc_rename = false, -- enables an input dialog for inc-rename.nvim
		lsp_doc_border = false, -- add a border to hover docs and signature help
	},
})
