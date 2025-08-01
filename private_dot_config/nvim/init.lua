--@diagnostic disable: undefined-global
--[[
- https://learnxinyminutes.com/docs/lua/
- `:help lua-guide` reference for how Neovim integrates Lua.
- (or HTML version): https://neovim.io/doc/user/lua-guide.html
]]
--

vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Set to true if you have a Nerd Font installed and selected in the terminal
vim.g.have_nerd_font = true

-- [[ Setting options ]] ,opts

-- Make line numbers default
vim.opt.number = true
-- Relative line numbers
vim.opt.relativenumber = true

-- Enable mouse mode, useful for resizing splits
vim.opt.mouse = "a"

-- Don't show the mode, since it's already in the status line
vim.opt.showmode = false

-- Sync clipboard between OS and Neovim. See `:help 'clipboard'`
vim.opt.clipboard = "unnamedplus"

-- Enable break indent :: wrapped lines maintain the original lines visual indent
vim.opt.breakindent = true

-- Save undo history
vim.opt.undofile = true

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Keep signcolumn on by default
vim.opt.signcolumn = "yes"

-- Decrease update time :: If this many milliseconds nothing is typed the swap file will be written to disk (see |crash-recovery|).
vim.opt.updatetime = 250

-- Decrease mapped sequence wait time
-- Displays which-key popup sooner
vim.opt.timeoutlen = 300

-- Configure how new splits should be opened
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Sets how neovim will display certain whitespace characters in the editor.
--  `:help 'list'`
--  `:help 'listchars'`
vim.opt.list = true
vim.opt.listchars = { tab = "  ", trail = "·", nbsp = "␣" }
-- tab = "␣",

-- Preview substitutions live, as you type!
vim.opt.inccommand = "split"

-- Show which line your cursor is on :: brighten line number and highlight line
vim.opt.cursorline = true

-- Minimal number of screen lines to keep above and below the cursor.
vim.opt.scrolloff = 10

vim.opt.termguicolors = true

vim.opt.tabstop = 4
vim.opt.shiftwidth = 4

vim.opt.background = "light"

local function toggle_bg()
	local curr_bg = vim.api.nvim_get_option_value("background", {})
	if curr_bg == "light" then
		vim.opt.background = "dark"
	else
		vim.opt.background = "light"
	end
	local new_bg = vim.api.nvim_get_option_value("background", {})
	print("Background set to " .. new_bg)
end

vim.api.nvim_create_user_command("ToggleBackground", toggle_bg, {})
vim.keymap.set("n", "<leader>bg", ":ToggleBackground<CR>", { desc = "Toggle background light/dark" })

-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`

local km_opts = { noremap = true, silent = true }

local function add_desc_std_opts(desc)
	return vim.tbl_deep_extend("force", km_opts, { desc = desc })
end

-- Set highlight on search, but clear on pressing <Esc> in normal mode
vim.opt.hlsearch = true
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- Diagnostic keymaps
vim.keymap.set("n", "<leader>kk", vim.diagnostic.goto_prev, { desc = "Go to previous [D]iagnostic message" })
vim.keymap.set("n", "<leader>kj", vim.diagnostic.goto_next, { desc = "Go to next [D]iagnostic message" })
vim.keymap.set("n", "<leader>ke", vim.diagnostic.open_float, { desc = "Show diagnostic [E]rror messages" })
vim.keymap.set("n", "<leader>kq", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--  See `:help wincmd` for a list of all window commands

-- using non modifier has unwanted interactions with fullscreen plugins
-- vim.keymap.set("n", "sh", "<C-w><C-h>", { desc = "Move focus to the left window" })
-- vim.keymap.set("n", "sl", "<C-w><C-l>", { desc = "Move focus to the right window" })
-- vim.keymap.set("n", "sj", "<C-w><C-j>", { desc = "Move focus to the lower window" })
-- vim.keymap.set("n", "sk", "<C-w><C-k>", { desc = "Move focus to the upper window" })

vim.keymap.set("n", "ss", ":split<Return>", km_opts)
vim.keymap.set("n", "sv", ":vsplit<Return>", km_opts)

-- select all
vim.keymap.set("n", "<C-a>", "gg<S-v>G", km_opts)

-- increment/decrement
vim.keymap.set("n", "+", "<C-a>", km_opts)
vim.keymap.set("n", "-", "<C-x>", km_opts)

-- buffers
vim.keymap.set("n", "<leader>bd", ":bd<CR>", km_opts)
vim.keymap.set("n", "<C-s>", ":update<CR>", km_opts)

-- ,diffview
vim.keymap.set("n", "<leader>vd", ":DiffviewOpen<CR>", { desc = "[v]iew [d]iff on buffer", noremap = true })
vim.keymap.set("n", "<leader>vx", ":DiffviewClose<CR>", { desc = "[v]iew diff close [x]", noremap = true })
vim.keymap.set(
	"n",
	"<leader>vD",
	":DiffviewOpen origin/main...HEAD --imply-local<CR>",
	{ desc = "[v]iew [d]iff against main branch", noremap = true }
)
vim.keymap.set("n", "<leader>VD", ":DiffviewOpen", { desc = "[v]iew [d]iff cmd entry", noremap = true })

vim.keymap.set("n", "<leader>do", "2do", { desc = "diff obtain hunk from rev OURS, Diffview 3way", noremap = true })
vim.keymap.set("n", "<leader>dt", "3do", { desc = "diff obtain hunk from rev THEIRS, Diffview 3way", noremap = true })

vim.keymap.set(
	"n",
	"<leader>vh",
	":DiffviewFileHistory %",
	{ desc = "[v]iew [d]iff current file history", noremap = true }
)
vim.keymap.set(
	"n",
	"<leader>VH",
	":DiffviewFileHistory ",
	{ desc = "[v]iew [d]iff file history cmd entry", noremap = true }
)

-- ,fugitive
-- vim.keymap.set("n", "<leader>gg", ":G<CR>", { noremap = true })
-- vim.keymap.set("n", "<leader>gf", ":Gedit :<CR>", { desc = "Fullscreen git view", noremap = true })
--
vim.keymap.set("n", "<leader>gB", ":G blame<CR>", add_desc_std_opts("[g]it [B]lame"))
-- vim.keymap.set("n", "<leader>gl", ":G log<CR>", { noremap = true })
-- vim.keymap.set("n", "<leader>gh", ":G log -s<CR>", { noremap = true })
-- vim.keymap.set("n", "<leader>gp", ":G push<CR>", { noremap = true })
-- vim.keymap.set("n", "<leader>gd", ":G diff<CR>", { noremap = true })
--
-- vim.keymap.set("n", "<leader>g-", ":Git stash<CR>:e<CR>", { noremap = true })
-- vim.keymap.set("n", "<leader>g+", ":Git stash pop<CR>:e<CR>", { noremap = true })
vim.keymap.set("n", "<leader>gw", "GBrowse", add_desc_std_opts("[g]it bro[w]ser github view"))
-- git checkout -- filename  # operates on buffer not file.
-- Can use undo and not get warnings about file changing outside vim
vim.keymap.set("n", "<leader>gr", ":Gread<CR>", add_desc_std_opts("[g]it [r]ead"))
-- writes to both the work tree and index versions of a file, making it like git add when
-- called from a work tree file and like git checkout when called from the index or a blob in history.
vim.keymap.set("n", "<leader>gw", ":Gwrite<CR>", add_desc_std_opts("[g]it [w]rite"))
-- vim.keymap.set("n", "<leader>gH",  ":G log<CR>:set nofoldenable<CR>")
-- vim.keymap.set("n", "<leader>gL", ":exe ':!cd ' . expand('%:p:h') . '; git la'<CR>")
-- vim.keymap.set("n", "<leader>gl", ":exe ':!cd ' . expand('%:p:h') . '; git las'<CR>")

-- ,neogit
vim.keymap.set("n", "<leader>gl", ":Neogit log<CR>", { desc = "Neogit log", noremap = true })
-- vim.keymap.set("n", "<leader>gc", ":Neogit commit<CR>", add_desc_std_opts("Neogit commit"))
vim.keymap.set("n", "<leader>gp", ":Neogit push<CR>", { desc = "Neogit push", noremap = true })
vim.keymap.set("n", "<leader>gP", ":Neogit pull<CR>", add_desc_std_opts("Neogit pull"))

-- git telescope
vim.keymap.set("n", "<leader>gb", ":Telescope git_branches<CR>", add_desc_std_opts("Fuzzy search [g]it [b]ranches"))
vim.keymap.set("n", "<leader>gc", ":Telescope git_commits<CR>", add_desc_std_opts("Telescope [g]it [c]ommit"))

-- ez vim commands
vim.keymap.set({ "n", "v" }, ";", ":", km_opts)
-- vim.keymap.set("v", ";", ":", km_opts) -- TODO: can this be consolidated?
vim.keymap.set("n", "<Space>;", ";", km_opts)
vim.keymap.set("n", "<Space>,", ",", km_opts)

-- ez justfile
vim.keymap.set("n", "<leader>j", ":! just ", { noremap = true })

-- Terminal
vim.keymap.set("n", "<c-t>", ":ToggleTerm direction=float<CR>", { desc = "open ToggleTerm" })
vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })
-- TODO: enter terminal mode?

-- git
vim.keymap.set("n", "<leader>gs", ":G status<CR>", { noremap = true })

-- NeoGit
vim.keymap.set("n", "<leader>gg", ":Neogit<CR>", { noremap = true })

-- lua
vim.keymap.set("n", "<leader>lf", ":luafile ", { noremap = true })
vim.keymap.set("n", "<leader>lc", ":luafile %<CR>", { noremap = true })

-- system clipboard (yank into system clipboard, paste from clipboard register)
-- TODO: ISS: skips cursor line and yanks below it?
vim.keymap.set("n", "<leader>y", "+y<CR>", { noremap = true })
vim.keymap.set("n", "<leader>pc", "+p<CR>", { noremap = true })
vim.keymap.set("n", "<leader>pp", '"_dP', { noremap = true })

-- intriguing keymap used by Takuya
-- vim.keymap.set('n', 'dw', 'vb_d', { noremap = true, silent = true })

vim.keymap.set("n", "<leader>m", ":messages<CR>", { noremap = true, desc = "cmd :messages" })

vim.keymap.set("n", "<leader>lr", ":LspRestart<CR>", { noremap = true, desc = "[L]SP [R]estart" })
vim.keymap.set("n", "<leader>ls", ":LspStart<CR>", { noremap = true, desc = "[L]SP [S]tart" })
vim.keymap.set("n", "<leader>li", ":LspInfo<CR>", { noremap = true, desc = "[L]SP [I]nfo" })

-- move lines up or down
-- see `mini.move`
-- vim.keymap.set("n", "<A-j>", ":m .+1<CR>==", { noremap = true, desc = "move line down (n)" })
-- vim.keymap.set("n", "<A-k>", ":m .-2<CR>==", { noremap = true, desc = "move line up (n)" })
-- vim.keymap.set("v", "<A-j>", ":m '>+1<CR>gv=gv", { noremap = true, desc = "move line up (v)" })
-- vim.keymap.set("v", "<A-k>", ":m '>-2<CR>gv=gv", { noremap = true, desc = "move line down (v)" })

-- for gamedev, specifically odin hot reloading w/ sokol
vim.keymap.set("n", "<leader>fr", function()
	-- vim.cmd("!./build.py -hot-reload -debug -run")
	vim.cmd("botright split")
	vim.cmd("terminal ./build.py -hot-reload -debug -run")
	vim.cmd("startinsert")
end, { desc = "Run build+run hot reload script" })

-- Odin build
vim.keymap.set("n", "<leader>ob", function()
	-- Get the toggleterm module
	local Terminal = require("toggleterm.terminal").Terminal

	-- Create a floating terminal instance
	local terminal = Terminal:new({
		cmd = "!odin build src",
		direction = "float",
		float_opts = {
			border = "curved",
		},
		-- Optional: close on exit
		on_exit = function(t, job, exit_code, name)
			if exit_code == 0 then
				-- Auto close on successful exit
				vim.defer_fn(function()
					t:close()
				end, 2000) -- Close after 2 seconds
			end
		end,
	})
	-- Toggle/open the terminal
	terminal:toggle()
end, { desc = "Default odin build command" })

-- Key binding for running an odin program
vim.keymap.set("n", "<leader>or", function()
	-- Get the toggleterm module
	local Terminal = require("toggleterm.terminal").Terminal

	-- Create a floating terminal instance
	local terminal = Terminal:new({
		-- cmd = "./src.bin",
		cmd = "odin run src",
		direction = "float",
		float_opts = {
			border = "curved",
		},
		-- Optional: close on exit
		on_exit = function(t, job, exit_code, name)
			if exit_code == 0 then
				-- Auto close on successful exit
				vim.defer_fn(function()
					t:close()
				end, 2000) -- Close after 2 seconds
			end
		end,
	})
	-- Toggle/open the terminal
	terminal:toggle()
end, { desc = "Default odin run executable" })

-- Quick Tasks functionality for project-specific task.sh scripts
do
	-- Get the task script path for current project
	local function get_task_script_path()
		return vim.fn.getcwd() .. "/task.sh"
	end

	-- Check if task script exists
	local function task_script_exists()
		local script_path = get_task_script_path()
		return vim.fn.filereadable(script_path) == 1
	end

	-- Create the initial task script
	local function create_task_script()
		local script_path = get_task_script_path()

		if task_script_exists() then
			vim.notify("Task script already exists at: " .. script_path)
			return
		end

		local script_content = {
			"#!/bin/bash",
			"",
			"# Quick tasks script for " .. vim.fn.fnamemodify(vim.fn.getcwd(), ":t"),
			"# Usage: ./task.sh {a|b|c|d}",
			"",
			'case "$1" in',
			'    "a")',
			'        echo "Executing task A..."',
			"        # Add your task here",
			"        ;;",
			'    "b")',
			'        echo "Executing task B..."',
			"        # Add your task here",
			"        ;;",
			'    "c")',
			'        echo "Executing task C..."',
			"        # Add your task here",
			"        ;;",
			'    "d")',
			'        echo "Executing task D..."',
			"        # Add your task here",
			"        ;;",
			"    *)",
			'        echo "Usage: $0 {a|b|c|d}"',
			'        echo "  a - Task A"',
			'        echo "  b - Task B"',
			'        echo "  c - Task C"',
			'        echo "  d - Task D"',
			"        exit 1",
			"        ;;",
			"esac",
		}

		-- Write the script file
		vim.fn.writefile(script_content, script_path)

		-- Make it executable
		vim.fn.system("chmod +x " .. script_path)

		vim.notify("Created quick-tasks script: " .. script_path)

		-- Open the script for editing
		vim.cmd("edit " .. script_path)
	end

	-- Execute a specific task
	local function run_task(task_letter)
		local script_path = get_task_script_path()

		if not task_script_exists() then
			vim.notify("No task script found. Use <leader>fq to create one.", vim.log.levels.WARN)
			return
		end

		if vim.fn.executable(script_path) == 0 then
			vim.notify("Task script is not executable: " .. script_path, vim.log.levels.ERROR)
			return
		end

		-- get toggleterm module
		local Terminal = require("toggleterm.terminal").Terminal

		-- Create float term instance
		local task_terminal = Terminal:new({
			cmd = script_path .. " " .. task_letter,
			direction = "float",
			float_opts = {
				border = "curved",
			},
			-- close_on_exit = false,
			-- Optional: close on exit
			on_exit = function(t, job, exit_code, name)
				if exit_code == 0 then
					-- Auto close on successful exit
					vim.defer_fn(function()
						t:close()
					end, 2000) -- Close after 2 seconds
				end
			end,
		})
		-- toggle the terminal
		task_terminal:toggle()
	end

	-- Set up keymaps
	vim.keymap.set("n", "<leader>fq", create_task_script, {
		desc = "Create quick task script",
	})

	vim.keymap.set("n", "<leader>ff", function()
		run_task("a")
	end, {
		desc = "Run quick task A",
	})

	vim.keymap.set("n", "<leader>fg", function()
		run_task("b")
	end, {
		desc = "Run quick task B",
	})

	vim.keymap.set("n", "<leader>fv", function()
		run_task("c")
	end, {
		desc = "Run quick task C",
	})

	vim.keymap.set("n", "<leader>fb", function()
		run_task("d")
	end, {
		desc = "Run quick task D",
	})

	-- Add command for manual task script creation
	vim.api.nvim_create_user_command("QuickTaskCreate", create_task_script, {
		desc = "Create quick task script in current directory",
	})

	-- Add command to run specific tasks
	vim.api.nvim_create_user_command("QuickTask", function(opts)
		local task = opts.args
		if task and task:match("^[abcd]$") then
			run_task(task)
		else
			vim.notify("Usage: :QuickTask {a|b|c|d}")
		end
	end, {
		nargs = 1,
		complete = function()
			return { "a", "b", "c", "d" }
		end,
		desc = "Run specific quick task",
	})
end

-- Autocommands  ,autocmd See `:help lua-guide-autocommands`

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end,
})

-- Prevent continueing comment on insert newline aka `o`
vim.api.nvim_create_autocmd("BufEnter", {
	desc = "Disable auto-commenting insert newline from a current line comment",
	group = vim.api.nvim_create_augroup("no-newline-comment", { clear = true }),
	callback = function()
		vim.opt.formatoptions:remove({ "r", "c", "o" })
	end,
})

-- https://www.reddit.com/r/neovim/comments/10pkzpw/what_is_your_saving_method_what_keys_have_to/
-- save anytime a buffer is left or neovim focus ist lost
-- commented out on 250402, due to mass errors every time these event triggers occur
-- vim.api.nvim_create_autocmd({ "BufLeave", "FocusLost" }, {
-- 	callback = function()
-- 		if vim.bo.modified and not vim.bo.readonly and vim.fn.expand("%") ~= "" and vim.bo.buftype == "" then
-- 			vim.api.nvim_command("silent update")
-- 		end
-- 	end,
-- })

-- run nvim-lint linters. To run on every text change use event "TextChanged"
vim.api.nvim_create_autocmd({ "InsertLeave", "BufWritePost" }, {
	callback = function()
		local lint_status, lint = pcall(require, "lint")
		if lint_status then
			lint.try_lint()
		end
	end,
})

-- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`

-- Disable LSP formatting
local orig_lsp_buf_request = vim.lsp.buf_request

vim.lsp.buf_request = function(bufnr, method, params, handler)
	if method == "textDocument/formatting" or method == "textDocument/rangeFormatting" then
		-- Optionally log the blocked format request
		-- print("LSP format request blocked for method: " .. method)
		return -- Silently block the format request
	end
	return orig_lsp_buf_request(bufnr, method, params, handler)
end

-- Override the built-in format functions to do nothing
vim.lsp.buf.format = function(options)
	-- Optionally log the blocked format attempt
	-- print("LSP format attempt blocked")
end

vim.lsp.buf.formatting = vim.lsp.buf.format
vim.lsp.buf.formatting_sync = function(options, timeout_ms)
	-- Optionally log the blocked sync format attempt
	-- print("LSP sync format attempt blocked")
end

-- Create a custom augroup for any formatting-related autocommands
local format_augroup = vim.api.nvim_create_augroup("CustomFormatting", { clear = true })

-- Prevent "format on save" functionality
vim.api.nvim_create_autocmd("BufWritePre", {
	group = format_augroup,
	callback = function(args)
		-- Instead of clearing autocommands, we'll just ensure our blocking is in place
		-- This approach avoids errors from non-existent groups
		local client = vim.lsp.get_active_clients({ bufnr = args.buf })[1]
		if client then
			client.server_capabilities.documentFormattingProvider = false
			client.server_capabilities.documentRangeFormattingProvider = false
		end
	end,
})

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
	if vim.v.shell_error ~= 0 then
		error("Error cloning lazy.nvim:\n" .. out)
	end
end ---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
	-- spec = {
	-- 	{ "LazyVim/LazyVim",  import = "lazyvim.plugins" },
	-- 	{ import = "lazyvim.plugins.extras.coding.copilot" },
	-- 	{ import = "plugins" },
	-- },
	"tpope/vim-sleuth", -- Detect tabstop and shiftwidth automatically
	-- NOTE: Plugins can also be configured to run Lua code when they are loaded.
	--
	-- This is often very useful to both group configuration, as well as handle
	-- lazy loading plugins that don't need to be loaded immediately at startup.
	--
	-- For example, in the following configuration, we use:
	--  event = 'VimEnter'
	--
	-- which loads which-key before all the UI elements are loaded. Events can be
	-- normal autocommands events (`:help autocmd-events`).
	--
	-- Then, because we use the `config` key, the configuration only runs
	-- after the plugin has been loaded:
	{ -- Useful plugin to show you pending keybinds.
		"folke/which-key.nvim",
		event = "VimEnter", -- Sets the loading event to 'VimEnter'
		config = function() -- This is the function that runs, AFTER loading
			local wk = require("which-key")
			wk.setup()

			-- Document existing key chains
			wk.add({
				{ "<leader>c", group = "[C]ode" },
				{ "<leader>d", group = "[D]ocument" },
				{ "<leader>r", group = "[R]ename" },
				{ "<leader>s", group = "[S]earch" },
				{ "<leader>t", group = "[T]oggle" },
				{ "<leader>w", group = "[W]orkspace" },
				{ "<leader>h", { "Git [H]unk" }, mode = { "n", "v" } },
			})
		end,
	},

	{
		"nvim-telescope/telescope.nvim",
		event = "VimEnter",
		branch = "0.1.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			{
				"nvim-telescope/telescope-fzf-native.nvim",

				-- `build` is used to run some command when the plugin is installed/updated.
				-- This is only run then, not every time Neovim starts up.
				build = "make",

				-- `cond` is a condition used to determine whether this plugin should be
				-- installed and loaded.
				cond = function()
					return vim.fn.executable("make") == 1
				end,
			},
			{ "nvim-telescope/telescope-ui-select.nvim" },

			-- Useful for getting pretty icons, but requires a Nerd Font.
			{ "nvim-tree/nvim-web-devicons", lazy = true, enabled = vim.g.have_nerd_font },
		},
		config = function()
			-- :Telescope help_tags
			-- Two important keymaps to use while in Telescope are:
			--  - Insert mode: <c-/>
			--  - Normal mode: ?
			-- This opens a window that shows you all of the keymaps for the current
			-- Telescope picker. This is really useful to discover what Telescope can
			-- do as well as how to actually do it!

			-- [[ Configure Telescope ]]
			-- See `:help telescope` and `:help telescope.setup()`
			require("telescope").setup({
				--  All the info you're looking for is in `:help telescope.setup()`
				-- defaults = {
				--   mappings = {
				--     i = { ['<c-enter>'] = 'to_fuzzy_refine' },
				--   },
				-- },
				-- pickers = {}
				extensions = {
					["ui-select"] = {
						require("telescope.themes").get_dropdown(),
					},
				},
			})

			-- Enable Telescope extensions if they are installed
			pcall(require("telescope").load_extension, "fzf")
			pcall(require("telescope").load_extension, "ui-select")

			-- See `:help telescope.builtin`
			local builtin = require("telescope.builtin")
			vim.keymap.set("n", "<leader>sh", builtin.help_tags, { desc = "[S]earch [H]elp" })
			vim.keymap.set("n", "<leader>sk", builtin.keymaps, { desc = "[S]earch [K]eymaps" })
			vim.keymap.set("n", "<leader>sf", builtin.find_files, { desc = "[S]earch [F]iles" })
			vim.keymap.set("n", "<leader>ss", builtin.builtin, { desc = "[S]earch [S]elect Telescope" })
			vim.keymap.set("n", "<leader>sw", builtin.grep_string, { desc = "[S]earch current [W]ord" })
			vim.keymap.set("n", "<leader>sg", builtin.live_grep, { desc = "[S]earch by [G]rep" })
			vim.keymap.set("n", "<leader>sd", builtin.diagnostics, { desc = "[S]earch [D]iagnostics" })
			vim.keymap.set("n", "<leader>sr", builtin.resume, { desc = "[S]earch [R]esume" })
			vim.keymap.set("n", "<leader>s.", builtin.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
			vim.keymap.set("n", "<leader><leader>", builtin.buffers, { desc = "[__] Find existing buffers" })

			-- Slightly advanced example of overriding default behavior and theme
			vim.keymap.set("n", "<leader>/", function()
				-- You can pass additional configuration to Telescope to change the theme, layout, etc.
				builtin.current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
					winblend = 10,
					previewer = false,
				}))
			end, { desc = "[/] Fuzzily search in current buffer" })

			-- It's also possible to pass additional configuration options.
			--  See `:help telescope.builtin.live_grep()` for information about particular keys
			vim.keymap.set("n", "<leader>s/", function()
				builtin.live_grep({
					grep_open_files = true,
					prompt_title = "Live Grep in Open Files",
				})
			end, { desc = "[S]earch [/] in Open Files" })

			-- Shortcut for searching your Neovim configuration files
			vim.keymap.set("n", "<leader>sn", function()
				builtin.find_files({ cwd = vim.fn.stdpath("config") })
			end, { desc = "[S]earch [N]eovim files" })
		end,
	},

	{
		"neovim/nvim-lspconfig",
		dependencies = {
			-- Automatically install LSPs and related tools to stdpath for Neovim
			{ "williamboman/mason.nvim", config = true }, -- NOTE: Must be loaded before dependants
			"williamboman/mason-lspconfig.nvim",
			"WhoIsSethDaniel/mason-tool-installer.nvim",
			"mfussenegger/nvim-lint",

			-- Useful status updates for LSP.
			{ "j-hui/fidget.nvim", opts = {} },

			-- `neodev` configures Lua LSP for your Neovim config, runtime and plugins
			-- used for completion, annotations and signatures of Neovim apis
			{ "folke/neodev.nvim", opts = {} },
		},
		config = function()
			vim.api.nvim_create_autocmd("LspAttach", {
				group = vim.api.nvim_create_augroup("kickstart-lsp-attach", { clear = true }),
				callback = function(event)
					-- In this case, we create a function that lets us more easily define mappings specific
					-- for LSP related items. It sets the mode, buffer and description for us each time.
					local map = function(keys, func, desc)
						vim.keymap.set("n", keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
					end

					--  To jump back, press <C-t>.
					map("gd", require("telescope.builtin").lsp_definitions, "[G]oto [D]efinition")
					map("gr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences") -- Find references for the word under your cursor.

					-- Jump to the implementation of the word under your cursor.
					map("gI", require("telescope.builtin").lsp_implementations, "[G]oto [I]mplementation")

					-- Jump to the type of the word under your cursor.
					--  Useful when you're not sure what type a variable is and you want to see
					--  the definition of its *type*, not where it was *defined*.
					map("<leader>D", require("telescope.builtin").lsp_type_definitions, "Type [D]efinition")

					map("<leader>ds", require("telescope.builtin").lsp_document_symbols, "[D]ocument [S]ymbols")

					map(
						"<leader>ws",
						require("telescope.builtin").lsp_dynamic_workspace_symbols,
						"[W]orkspace [S]ymbols"
					)

					map("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")
					map("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")

					map("K", vim.lsp.buf.hover, "Hover Documentation")

					--  For example, in C this would take you to the header.
					map("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")

					vim.lsp.buf.format({
						filter = function(client)
							local disabled_formatters = { "vtsls" }
							-- not vtsls, eslin
							return not vim.tbl_contains(disabled_formatters, client.name)
						end,
					})
					-- lsp formatter here, versus conform formatter
					map("<leader>cF", vim.lsp.buf.format, "[c]ode [F]ormat")

					-- The following two autocommands are used to highlight references of the
					-- word under your cursor when your cursor rests there for a little while.
					--    See `:help CursorHold` for information about when this is executed
					--
					-- When you move your cursor, the highlights will be cleared (the second autocommand).
					local client = vim.lsp.get_client_by_id(event.data.client_id)
					if client and client.server_capabilities.documentHighlightProvider then
						local highlight_augroup =
							vim.api.nvim_create_augroup("kickstart-lsp-highlight", { clear = false })
						vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
							buffer = event.buf,
							group = highlight_augroup,
							callback = vim.lsp.buf.document_highlight,
						})

						vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
							buffer = event.buf,
							group = highlight_augroup,
							callback = vim.lsp.buf.clear_references,
						})

						vim.api.nvim_create_autocmd("LspDetach", {
							group = vim.api.nvim_create_augroup("kickstart-lsp-detach", { clear = true }),
							callback = function(event2)
								vim.lsp.buf.clear_references()
								vim.api.nvim_clear_autocmds({ group = "kickstart-lsp-highlight", buffer = event2.buf })
							end,
						})
					end

					-- TODO: Consider removing
					-- The following autocommand is used to enable inlay hints in your
					-- code, if the language server you are using supports them
					-- This may be unwanted, since they displace some of your code
					if client and client.server_capabilities.inlayHintProvider and vim.lsp.inlay_hint then
						map("<leader>th", function()
							vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({}))
						end, "[T]oggle Inlay [H]ints")
					end

					-- -- Disable formatting for specific LSP servers
					-- local disable_formatting = { "tsserver", "vtsls" }
					--
					-- if client and vim.tbl_contains(disable_formatting, client.name) then
					--     client.server_capabilities.documentFormattingProvider = false
					--     client.server_capabilities.documentRangeFormattingProvider = false
					-- end

					-- Unsure if this disables autoformatting on new buffer enter (or whatever it is that is happening whenever I open a file and things format via LSP)
					-- Try to disable all formatting done by LSPs, only allow conform (or other dedicated formatter)
					if client and client.server_capabilities then
						client.server_capabilities.documentFormattingProvider = false
						client.server_capabilities.documentRangeFormattingProvider = false
					end
				end,
			})

			-- LSP servers and clients are able to communicate to each other what features they support.
			--  By default, Neovim doesn't support everything that is in the LSP specification.
			--  When you add nvim-cmp, luasnip, etc. Neovim now has *more* capabilities.
			--  So, we create new capabilities with nvim cmp, and then broadcast that to the servers.
			local capabilities = vim.lsp.protocol.make_client_capabilities()
			capabilities = vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())

			-- Enable the following language servers
			--  Feel free to add/remove any LSPs that you want here. They will automatically be installed.
			--
			--  Add any additional override configuration in the following tables. Available keys are:
			--  - cmd (table): Override the default command used to start the server
			--  - filetypes (table): Override the default list of associated filetypes for the server
			--  - capabilities (table): Override fields in capabilities. Can be used to disable certain LSP features.
			--  - settings (table): Override the default settings passed when initializing the server.
			--        For example, to see the options for `lua_ls`, you could go to: https://luals.github.io/wiki/settings/
			--
			-- `:help lspconfig-all` for a list of all the pre-configured LSPs ,lsps
			local servers = {
				ts_ls = { enabled = false },
				vtsls = {
					filetypes = {
						"javascript",
						"javascriptreact",
						"javascript.jsx",
						"typescript",
						"typescriptreact",
						"typescript.tsx",
					},
					settings = {
						complete_function_calls = true,
						vtsls = {
							enableMoveToFileCodeAction = true,
							autoUseWorkspaceTsdk = true,
							experimental = {
								completion = {
									enableServerSideFuzzyMatch = true,
								},
							},
						},
						typescript = {
							updateImportsOnFileMove = { enabled = "always" },
							suggest = {
								completeFunctionCalls = true,
								autoImports = true,
							},
							inlayHints = {
								enumMemberValues = { enabled = true },
								functionLikeReturnTypes = { enabled = true },
								parameterNames = { enabled = "literals" },
								parameterTypes = { enabled = true },
								propertyDeclarationTypes = { enabled = true },
								variableTypes = { enabled = false },
							},
							referencesCodeLens = { enabled = true },
							watch = true,
							tsserver = {
								watchOptions = {
									watchFile = "useFsEvents",
									watchDirectory = "useFsEvents",
									fallbackPolling = "dynamicPriorityPolling",
								},
							},
						},
						-- on_attach = function(client, bufnr)
						--     client.server_capabilities.documentFormattingProvider = false
						--     client.server_capabilities.documentRangeFormattingProvider = false
						-- end,
					},
				},
				eslint = {
					enabled = false,
					-- settings = {
					-- 	on_attach = function(client, bufnr)
					-- 		client.server_capabilities.documentFormattingProvider = false
					-- 		client.server_capabilities.documentRangeFormattingProvider = false
					-- 	end,
					-- },
				},
				clangd = {},
				rust_analyzer = {},
				ols = {},
				pyright = {},
				bashls = {},
				cmake = {},
				html = {},
				cssls = {},
				cssmodules_ls = {},
				jsonls = {},
				docker_compose_language_service = {},
				dockerls = {},
				prismals = {},
				-- tailwindcss = {}, -- CPU hog, cfg later
				lua_ls = {
					-- cmd = {...},
					-- filetypes = { ...},
					-- capabilities = {},
					settings = {
						update_on_insert = true,
						Lua = {
							completion = {
								callSnippet = "Replace",
							},
							-- You can toggle below to ignore Lua_LS's noisy `missing-fields` warnings
							-- diagnostics = { disable = { 'missing-fields' } },
						},
					},
				},
			}

			require("mason").setup()

			local ensure_installed = vim.tbl_keys(servers or {})
			vim.list_extend(ensure_installed, {
				-- Install formatters here, but use conform to config them
				"stylua",
				"rust_analyzer",
				"prettier",
				"clang-format",
			})

			require("mason-tool-installer").setup({ ensure_installed = ensure_installed })

			require("mason-lspconfig").setup({
				handlers = {
					-- default handler
					function(server_name)
						local server = servers[server_name] or {}
						-- This handles overriding only values explicitly passed
						-- by the server configuration above. Useful when disabling
						-- certain features of an LSP (for example, turning off formatting for tsserver)
						server.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
						require("lspconfig")[server_name].setup(server)
					end,
					["eslint"] = function()
						local lspconfig = require("lspconfig")
						lspconfig.eslint.setup({
							settings = {
								workingDirectory = { mode = "location" },
							},
							-- root_dir = lspc.util.find_git_ancestor,
							root_dir = lspconfig.util.root_pattern(
								"eslint.config.js",
								"eslint.config.mjs",
								"eslint.config.cjs",
								".eslintrc.js",
								".eslintrc.cjs",
								".eslintrc.yaml",
								".eslintrc.yml",
								".eslintrc.json"
								-- Disabled to prevent "No ESLint configuration found" exceptions
								-- 'package.json',
							),
						})
					end,
				},
			})
		end,
	},
	{
		"yioneko/nvim-vtsls",
		ft = {
			"javascript",
			"javascriptreact",
			"typescript",
			"typescriptreact",
		},
	},
	{
		"mfussenegger/nvim-lint",
		config = function()
			local lint = require("lint")
			lint.linters_by_ft = {
				javascript = { "eslint_d" },
				typescript = { "eslint_d" },
				javascriptreact = { "eslint_d" },
				typescriptreact = { "eslint_d" },
				zsh = { "zsh" },
			}
		end,
	},
	{ -- Autoformat ,fmt :: use explicit external formatters, don't default to formatting via lsp
		"stevearc/conform.nvim",
		lazy = false,
		keys = {
			{
				"<leader>cf",
				function()
					require("conform").format({ async = true, lsp_fallback = true, timeout_ms = 3000 })
				end,
				mode = "",
				desc = "Formatter: [c]ode [f]ormat buffer",
			},
		},
		opts = {
			-- log_level = vim.log.levels.DEBUG,
			notify_on_error = false,
			format_on_save = function(bufnr)
				-- Disable "format_on_save lsp_fallback" for languages that don't
				-- have a well standardized coding style. You can add additional
				-- languages here or re-enable it for the disabled ones.
				-- local disable_filetypes = { c = true, cpp = true }
				return {
					timeout_ms = 500,
					-- lsp_fallback = not disable_filetypes[vim.bo[bufnr].filetype],
					lsp_fallback = false,
				}
			end,
			-- Conform can also run multiple formatters sequentially
			-- You can use a sub-list to tell conform to run *until* a formatter is found.
			formatters_by_ft = {
				lua = { "stylua" },
				rust = { "rust_analyzer" },
				odin = { "ols" },
				javascript = { "prettier" },
				typescript = { "prettier" },
				typescriptreact = { "prettier" },
				javascriptreact = { "prettier" },
				json = { "prettier" },
				css = { "prettier" },
				astro = { "prettier" },
				yml = { "prettier" },
				-- c = { "clang-format" },
			},
		},
	},

	{ -- Autocompletion ,cmp
		"hrsh7th/nvim-cmp",
		event = "InsertEnter",
		dependencies = {
			-- Snippet Engine & its associated nvim-cmp source
			{
				"L3MON4D3/LuaSnip",
				build = (function()
					-- Build Step is needed for regex support in snippets.
					-- This step is not supported in many windows environments.
					-- Remove the below condition to re-enable on windows.
					if vim.fn.has("win32") == 1 or vim.fn.executable("make") == 0 then
						return
					end
					return "make install_jsregexp"
				end)(),
				config = function()
					require("luasnip.loaders.from_vscode").load({ paths = { "~/.config/my-snippets" } }) -- Load snippets from my-snippets folder
				end,
				-- prefer my own
				-- dependencies = {
				-- 	{ -- https://github.com/rafamadriz/friendly-snippets
				-- 		"rafamadriz/friendly-snippets",
				-- 		config = function()
				-- 			require("luasnip.loaders.from_vscode").lazy_load()
				-- 		end,
				-- 	},
				-- },
			},
			"saadparwaiz1/cmp_luasnip",

			-- Adds other completion capabilities.
			--  nvim-cmp does not ship with all sources by default. They are split
			--  into multiple repos for maintenance purposes.
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-path",
		},
		config = function()
			-- See `:help cmp`
			local cmp = require("cmp")
			local luasnip = require("luasnip")
			luasnip.config.setup({})

			cmp.setup({
				snippet = {
					expand = function(args)
						luasnip.lsp_expand(args.body)
					end,
				},
				completion = { completeopt = "menu,menuone,noinsert" },

				-- For an understanding of why these mappings were
				-- chosen, you will need to read `:help ins-completion`
				--
				-- TODO:use these cmp nav bindings or tab/s-tab/enter?
				-- No, but seriously. Please read `:help ins-completion`, it is really good!
				mapping = cmp.mapping.preset.insert({
					["<C-n>"] = cmp.mapping.select_next_item(),
					["<C-p>"] = cmp.mapping.select_prev_item(),
					-- Scroll the documentation window [b]ack / [f]orward
					["<C-b>"] = cmp.mapping.scroll_docs(-4),
					["<C-f>"] = cmp.mapping.scroll_docs(4),
					-- Accept ([y]es) the completion.
					["<Tab>"] = cmp.mapping.confirm({ select = true }),

					-- If you prefer more traditional completion keymaps,
					--['<CR>'] = cmp.mapping.confirm { select = true },
					--['<Tab>'] = cmp.mapping.select_next_item(),
					--['<S-Tab>'] = cmp.mapping.select_prev_item(),

					-- Manually trigger a completion from nvim-cmp.
					--  Generally you don't need this, because nvim-cmp will display
					--  completions whenever it has completion options available.
					["<C-Space>"] = cmp.mapping.complete({}),

					-- Think of <c-l> as moving to the right of your snippet expansion.
					--  So if you have a snippet that's like:
					--  function $name($args)
					--    $body
					--  end
					--
					-- <c-l> will move you to the right of each of the expansion locations.
					-- <c-h> is similar, except moving you backwards.
					["<C-l>"] = cmp.mapping(function()
						if luasnip.expand_or_locally_jumpable() then
							luasnip.expand_or_jump()
						end
					end, { "i", "s" }),
					["<C-h>"] = cmp.mapping(function()
						if luasnip.locally_jumpable(-1) then
							luasnip.jump(-1)
						end
					end, { "i", "s" }),

					-- For more advanced Luasnip keymaps (e.g. selecting choice nodes, expansion) see:
					--    https://github.com/L3MON4D3/LuaSnip?tab=readme-ov-file#keymaps
				}),
				-- e.g. add AI completions here
				sources = {
					{ name = "nvim_lsp" },
					{ name = "luasnip" },
					{ name = "path" },
					{ name = "copilot" },
				},
			})
		end,
	},
	{
		"rebelot/kanagawa.nvim",
		lazy = false, -- load during startup, since main colorscheme
		priority = 1000, -- load before all other start plugins
		init = function()
			vim.cmd.colorscheme("kanagawa")
			vim.cmd.hi("Comment gui=none")
		end,
		opts = {
			theme = "wave",
			background = { dark = "dragon", light = "wave" },
			colors = { theme = { all = { ui = { bg_gutter = "none" } } } },
		},
	},
	{
		"tjdevries/colorbuddy.nvim",
	},
	{
		"folke/todo-comments.nvim",
		event = "VimEnter",
		dependencies = { "nvim-lua/plenary.nvim" },
		opts = { signs = false },
	},
	{
		"echasnovski/mini.nvim",
		config = function()
			-- Better Around/Inside textobjects
			-- eg:
			--  - va)  - [V]isually select [A]round [)]paren
			--  - yinq - [Y]ank [I]nside [N]ext [']quote
			--  - ci'  - [C]hange [I]nside [']quote
			require("mini.ai").setup({ n_lines = 500 })

			-- Add/delete/replace surroundings (brackets, quotes, etc.)
			-- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
			-- - sd'   - [S]urround [D]elete [']quotes
			-- - sr)'  - [S]urround [R]eplace [)] [']
			require("mini.surround").setup({
				mappings = {
					highlight = "sH", -- default `sh` conflicts with my switch window focus
				},
			})

			local statusline = require("mini.statusline")
			-- set use_icons to true if you have a Nerd Font
			statusline.setup({ use_icons = vim.g.have_nerd_font })
			-- You can configure sections in the statusline by overriding their
			-- default behavior. For example, here we set the section for
			-- cursor location to LINE:COLUMN
			---@diagnostic disable-next-line: duplicate-set-field
			statusline.section_location = function()
				return "%2l:%-2v"
			end

			local indentscope = require("mini.indentscope")
			indentscope.gen_animation.none()
			indentscope.setup()

			-- advanced text objects
			-- require("mini.ai").setup({
			-- 	version = "*",
			-- 	event = "VeryLazy",
			-- 	config = function()
			-- 		LazyVim.on_load("which-key.nvim", function()
			-- 			vim.schedule(LazyVim.mini.ai_whichkey)
			-- 		end)
			-- 		local ai = require("mini.ai")
			-- 		return {
			-- 			n_lines = 500,
			-- 			custom_textobjects = {
			-- 				o = ai.gen_spec.treesitter({ -- code block
			-- 					a = { "@block.outer", "@conditional.outer", "@loop.outer" },
			-- 					i = { "@block.inner", "@conditional.inner", "@loop.inner" },
			-- 				}),
			-- 				f = ai.gen_spec.treesitter({ a = "@function.outer", i = "@function.inner" }), -- function
			-- 				c = ai.gen_spec.treesitter({ a = "@class.outer", i = "@class.inner" }), -- class
			-- 				t = { "<([%p%w]-)%f[^<%w][^<>]->.-</%1>", "^<.->().*()</[^/]->$" }, -- tags
			-- 				d = { "%f[%d]%d+" }, -- digits
			-- 				e = { -- Word with case
			-- 					{
			-- 						"%u[%l%d]+%f[^%l%d]",
			-- 						"%f[%S][%l%d]+%f[^%l%d]",
			-- 						"%f[%P][%l%d]+%f[^%l%d]",
			-- 						"^[%l%d]+%f[^%l%d]",
			-- 					},
			-- 					"^().*()$",
			-- 				},
			-- 				i = LazyVim.mini.ai_indent, -- indent
			-- 				g = LazyVim.mini.ai_buffer, -- buffer
			-- 				u = ai.gen_spec.function_call(), -- u for "Usage"
			-- 				U = ai.gen_spec.function_call({ name_pattern = "[%w_]" }), -- without dot in function name
			-- 			},
			-- 		}
			-- 	end,
			-- })
		end,
	},
	{
		"JoosepAlviste/nvim-ts-context-commentstring",
		lazy = true,
		opts = { enable_autocmd = false },
	},
	{
		"echasnovski/mini.comment",
		version = "*",
		event = "VeryLazy",
		opts = {
			options = {
				custom_commentstring = function()
					local ft = vim.bo.filetype
					if ft == "c" then
						return "// %s"
					end
					return require("ts_context_commentstring.internal").calculate_commentstring()
						or vim.bo.commentstring
				end,
			},
		},
	},
	{
		"echasnovski/mini.files",
		version = "*",
		opts = {
			options = {
				use_as_default_explorer = true,
			},
		},
		keys = {
			{
				"<leader>fe",
				function()
					require("mini.files").open(vim.api.nvim_buf_get_name(0), true)
				end,
				desc = "Open mini.files (Directory of Current File)",
			},
			{
				"<leader>fE",
				function()
					require("mini.files").open(vim.uv.cwd(), true)
				end,
				desc = "Open mini.files (cwd)",
			},
		},
		config = function(_, opts)
			require("mini.files").setup({ opts })

			-- mapping to show/hide dot-files
			local show_dotfiles = true
			local filter_show = function(_)
				return true
			end
			local filter_hide = function(fs_entry)
				return not vim.startswith(fs_entry.name, ".")
			end

			local toggle_dotfiles = function()
				show_dotfiles = not show_dotfiles
				local new_filter = show_dotfiles and filter_show or filter_hide
				require("mini.files").refresh({ content = { filter = new_filter } })
			end

			vim.api.nvim_create_autocmd("User", {
				pattern = "MiniFilesBufferCreate",
				callback = function(args)
					local buf_id = args.data.buf_id
					vim.keymap.set("n", "g.", toggle_dotfiles, { buffer = buf_id, desc = "Toggle Hidden Files" })
				end,
			})

			-- use lsp for file renames
			vim.api.nvim_create_autocmd("User", {
				pattern = "MiniFilesActionRename",
				callback = function(event)
					LazyVim.lsp.on_rename(event.data.from, event.data.to)
				end,
			})
		end,
	},
	{
		"echasnovski/mini.move",
		version = "*",
		opts = {},
	},
	{ -- Highlight, edit, and navigate code ,treesitter
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		opts = {
			ensure_installed = {
				"diff",
				"git_rebase",
				"git_config",
				"gitignore",
				"markdown",
				"markdown_inline",
				"query",
				"yaml",
				"toml",
				"just",
				"dockerfile",
				"prisma",
				"vim",
				"vimdoc",
				"bash",
				-- 'zsh', -- not available
				"lua",
				"luadoc",
				"c",
				"cmake",
				"make",
				"html",
				"css",
				"scss",
				"javascript",
				"jsdoc",
				"json",
				"typescript",
				"tsx",
				"rust",
				"odin",
				"python",
				"regex",
				"astro",
			},
			-- Autoinstall languages that are not installed
			auto_install = true,
			highlight = {
				enable = true,
				-- Some languages depend on vim's regex highlighting system (such as Ruby) for indent rules.
				--  If you are experiencing weird indenting issues, add the language to
				--  the list of additional_vim_regex_highlighting and disabled languages for indent.
				additional_vim_regex_highlighting = { "ruby", "c" },
			},
			indent = {
				enable = false,
				disable = { "ruby", "c" },
			},
			context_commentstring = {
				config = {
					-- enable_autocmd = false, -- disable default autocmd, use plugin (numToStr/Comment.nvim) hook function instead
				},
			},
		},
		config = function(_, opts)
			-- [[ Configure Treesitter ]] See `:help nvim-treesitter`

			-- Prefer git instead of curl in order to improve connectivity in some environments
			require("nvim-treesitter.install").prefer_git = true
			---@diagnostic disable-next-line: missing-fields
			require("nvim-treesitter.configs").setup(opts)

			-- There are additional nvim-treesitter modules that you can use to interact
			-- with nvim-treesitter. You should go explore a few and see what interests you:
			--
			--    - Incremental selection: Included, see `:help nvim-treesitter-incremental-selection-mod`
			--    - Treesitter + textobjects: https://github.com/nvim-treesitter/nvim-treesitter-textobjects
		end,
	},
	{
		"nvim-treesitter/nvim-treesitter-context",
		dependencies = { "nvim-treesitter/nvim-treesitter" },
		opts = {
			max_lines = 4,
		},
	},
	{
		"windowp/nvim-ts-autotag",
		opts = {},
	},
	require("kickstart.plugins.autopairs"),

	-- require 'kickstart.plugins.debug',
	-- require 'kickstart.plugins.indent_line',
	-- require 'kickstart.plugins.lint',
	-- require("kickstart.plugins.gitsigns"), -- adds gitsigns recommend keymaps

	-- More custom ,plugins (order not important) `:help lazy.nvim-lazy.nvim-structuring-your-plugins`
	{ -- no out-of-the-box gitsigns integration, but see my custom.plugins
		"dstein64/nvim-scrollview",
		-- opts = {
		-- signs_on_startup = { "all" }, -- defaults to search & diagnostics
		-- },
	},
	{ "tpope/vim-fugitive" },
	{ "tpope/vim-rhubarb" },
	{
		"NeogitOrg/neogit",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"sindrets/diffview.nvim",
			"nvim-telescope/telescope.nvim",
		},
		opts = {
			graph_style = "unicode",
			integrations = {
				telescope = true,
				diffview = true,
			},
			-- use_default_keymaps = true,
		},
	},
	{
		"sindrets/diffview.nvim",
		version = "*",
		opts = {
			view = {
				merge_tool = {
					layout = "diff3_mixed",
				},
			},
		},
	},
	{
		"akinsho/toggleterm.nvim",
		version = "*",
		config = true,
		opts = {
			open_mapping = [[c-t]],
			shade_terminals = true,
		},
	},
	{ -- improve native ts comments
		"folke/ts-comments.nvim",
		opts = {},
		event = "VeryLazy",
		enabled = vim.fn.has("nvim-0.10.0") == 1,
	},
	{ -- treesitter autoclose/autorename html tags
		"windwp/nvim-ts-autotag",
	},
	-- {
	-- 	"zbirenbaum/copilot.lua",
	-- 	cmd = "Copilot",
	-- 	event = "InsertEnter",
	-- 	build = ":Copilot auth",
	-- 	-- keys = {
	-- 	--     "<leader>cp",
	-- 	--     function()
	-- 	--         require("copilot.suggestion").toggle_auto_trigger()
	-- 	--     end,
	-- 	--     mode = { "n" },
	-- 	--     desc = "toggle [c]o[p]ilot autosuggestion",
	-- 	-- },
	-- 	opts = {
	-- 		suggestion = {
	-- 			enabled = true,
	-- 			auto_trigger = true,
	-- 			keymap = {
	-- 				accept = "<A-l>",
	-- 				next = "<A-)>",
	-- 				prev = "<A-(>",
	-- 				dismiss = "<A-Esc>",
	-- 			},
	-- 		},
	-- 		panel = { enabled = false },
	-- 		filetypes = {
	-- 			javascript = true,
	-- 			typescript = true,
	-- 			javascriptreact = true,
	-- 			typescriptreact = true,
	-- 			python = true,
	-- 			bash = true,
	-- 			zsh = true,
	-- 			markdown = true,
	-- 			help = true,
	-- 			rust = true,
	-- 			odin = false,
	-- 			terraform = false,
	-- 			sh = function()
	-- 				if string.match(vim.fs.basename(vim.api.nvim_buf_get_name(0)), "^%.env.*") then
	-- 					-- disable for .env files
	-- 					return false
	-- 				end
	-- 				return true
	-- 			end,
	-- 			["*"] = false, -- disable all others
	-- 		},
	-- 	},
	-- },
	{
		"nvim-neo-tree/neo-tree.nvim",
		version = "*",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
			"MunifTanjim/nui.nvim",

			-- "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
		},
		cmd = "Neotree",
		keys = {
			{ "\\", ":Neotree reveal<CR>", { desc = "Neotree reveal" } },
		},
		opts = {
			filesystem = {
				window = {
					mappings = {
						["\\"] = "close_window",
					},
				},
			},
		},
	},
	{
		"xvzc/chezmoi.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		lazy = false,
		init = function()
			-- required option
			vim.g["chezmoi#use_tmp_buffer"] = true
			-- add other options as needed
		end,
		opts = {},
	},
	{
		"lewis6991/gitsigns.nvim",
		opts = {
			on_attach = function(bufnr)
				local gitsigns = require("gitsigns")

				local function map(mode, l, r, opts)
					opts = opts or {}
					opts.buffer = bufnr
					vim.keymap.set(mode, l, r, opts)
				end

				-- Navigation
				map("n", "]c", function()
					if vim.wo.diff then
						vim.cmd.normal({ "]c", bang = true })
					else
						gitsigns.nav_hunk("next")
					end
				end, { desc = "Jump to next git [c]hange" })

				map("n", "[c", function()
					if vim.wo.diff then
						vim.cmd.normal({ "[c", bang = true })
					else
						gitsigns.nav_hunk("prev")
					end
				end, { desc = "Jump to previous git [c]hange" })

				-- Actions
				-- visual mode
				map("v", "<leader>hs", function()
					gitsigns.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
				end, { desc = "stage git hunk" })
				map("v", "<leader>hr", function()
					gitsigns.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
				end, { desc = "reset git hunk" })
				-- normal mode
				map("n", "<leader>hs", gitsigns.stage_hunk, { desc = "git [s]tage hunk" })
				map("n", "<leader>hr", gitsigns.reset_hunk, { desc = "git [r]eset hunk" })
				map("n", "<leader>hS", gitsigns.stage_buffer, { desc = "git [S]tage buffer" })
				map("n", "<leader>hu", gitsigns.undo_stage_hunk, { desc = "git [u]ndo stage hunk" })
				map("n", "<leader>hR", gitsigns.reset_buffer, { desc = "git [R]eset buffer" })
				map("n", "<leader>hp", gitsigns.preview_hunk, { desc = "git [p]review hunk" })
				map("n", "<leader>hb", gitsigns.blame_line, { desc = "git [b]lame line" })
				map("n", "<leader>hd", gitsigns.diffthis, { desc = "git [d]iff against index" })
				map("n", "<leader>hD", function()
					gitsigns.diffthis("@")
				end, { desc = "git [D]iff against last commit" })
				-- Toggles
				map("n", "<leader>tb", gitsigns.toggle_current_line_blame, { desc = "[T]oggle git show [b]lame line" })
				map("n", "<leader>tD", gitsigns.toggle_deleted, { desc = "[T]oggle git show [D]eleted" })
			end,
		},
		{ "ellisonleao/glow.nvim", config = true, cmd = "Glow" },
		{
			"iamcco/markdown-preview.nvim",
			cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
			build = "cd app && yarn install",
			init = function()
				vim.g.mkdp_filetypes = { "markdown" }
			end,
			ft = { "markdown" },
			keys = {
				{ "<leader>pm", ":MarkdownPreview<CR>", { desc = "Start markdown preview browser" } },
				{ "<leader>ps", ":MarkdownPreviewStop<CR>", { desc = "Stop markdown preview browser" } },
			},
		},
		{
			"ThePrimeagen/harpoon",
			branch = "harpoon2",
			dependencies = { "nvim-lua/plenary.nvim" },
			config = function()
				local harpoon = require("harpoon")
				harpoon:setup()
				-- basic telescope configuration
				local conf = require("telescope.config").values
				local function toggle_telescope(harpoon_files)
					local file_paths = {}
					for _, item in ipairs(harpoon_files.items) do
						table.insert(file_paths, item.value)
					end

					require("telescope.pickers")
						.new({}, {
							prompt_title = "Harpoon",
							finder = require("telescope.finders").new_table({
								results = file_paths,
							}),
							previewer = conf.file_previewer({}),
							sorter = conf.generic_sorter({}),
						})
						:find()
				end

				-- instead of harpoon ui quick menu
				vim.keymap.set("n", "<C-y>", function()
					toggle_telescope(harpoon:list())
				end, { desc = "Open harpoon window" })
				-- replaced by telescope above menu
				-- vim.keymap.set("n", "<C-y>", function()
				-- 	harpoon.ui:toggle_quick_menu(harpoon:list())
				-- end)

				vim.keymap.set("n", "<leader>a", function()
					harpoon:list():add()
				end)
				vim.keymap.set("n", "<C-g>", function()
					harpoon:list():select(1)
				end)
				vim.keymap.set("n", "<C-h>", function()
					harpoon:list():select(2)
				end)
				vim.keymap.set("n", "<C-j>", function()
					harpoon:list():select(3)
				end)
				vim.keymap.set("n", "<C-k>", function()
					harpoon:list():select(4)
				end)

				-- Toggle previous & next buffers stored within Harpoon list
				vim.keymap.set("n", "<C-S-P>", function()
					harpoon:list():prev()
				end)
				vim.keymap.set("n", "<C-S-N>", function()
					harpoon:list():next()
				end)
			end,
		},
		-- To avoid press-enter to continue annoyance
		-- {
		-- 	"folke/noice.nvim",
		-- 	dependencies = {
		-- 		"MunifTanjim/nui.nvim",
		-- 		"rcarriga/nvim-notify",
		-- 	},
		-- 	config = function()
		-- 		require("noice").setup({
		-- 			cmdline = {
		-- 				enabled = true,
		-- 				view = "cmdline_popup", -- Floating command line
		-- 			},
		-- 			messages = {
		-- 				enabled = true,
		-- 				view = "notify", -- Use notifications instead of command line
		-- 			},
		-- 		})
		-- 	end,
		-- },
	},

	{ import = "custom.plugins" },
	-- {
	-- 	"custom.contrib_gitsigns",
	-- 	config = function()
	-- 		require("contrib_gitsigns").setup()
	-- 	end,
	-- 	dependencies = {
	-- 		"lewis6991/gitsigns.nvim",
	-- 		"dstein64/nvim-scrollview",
	-- 	},
	-- },
}, {
	ui = {
		-- If you are using a Nerd Font: set icons to an empty table which will use the
		-- default lazy.nvim defined Nerd Font icons, otherwise define a unicode icons table
		icons = vim.g.have_nerd_font and {} or {
			cmd = "⌘",
			config = "🛠",
			event = "📅",
			ft = "📂",
			init = "⚙",
			keys = "🗝",
			plugin = "🔌",
			runtime = "💻",
			require = "🌙",
			source = "📄",
			start = "🚀",
			task = "📌",
			lazy = "💤 ",
		},
	},
})

-- TODO: troubleshoot when the LSP format failed, missing language server
-- print debug by showing when events are triggered: BufEnter, BufWrite, PreBufWrite, LspAttach, lsp format run,
-- vim.api.nvim_create_autocmd("LspAttach", {
--     callback = function(args)
--         local client = vim.lsp.get_client_by_id(args.data.client_id)
--         print(string.format("LSP attached: %s", client.name))
--         print(string.format("Formatting capability: %s", client.server_capabilities.documentFormattingProvider))
--     end,
-- })

-- ,colorscheme toggle
local COLORSCHEMES = {
	"kanagawa",
	-- "true-monochrome",
	-- "tmc",
	"kundalini",
	"amber",
}
local CURR_COLORSCHEME_INDEX = 1

local function get_saved_scheme()
	local home = os.getenv("HOME")
	local file = io.open(home .. "/.vim_colorscheme", "r")
	if file then
		local content = file:read("*all")
		file:close()
		return tonumber(content) or 1
	end
	return 1
end

local function save_scheme(index)
	local home = os.getenv("HOME")
	local file = io.open(home .. "/.vim_colorscheme", "w")
	if file then
		file:write(tostring(index))
		file:close()
	end
end

local function toggle_colorscheme()
	CURR_COLORSCHEME_INDEX = get_saved_scheme()
	CURR_COLORSCHEME_INDEX = (CURR_COLORSCHEME_INDEX % #COLORSCHEMES) + 1
	local new_scheme = COLORSCHEMES[CURR_COLORSCHEME_INDEX]
	vim.cmd("colorscheme " .. new_scheme)
	save_scheme(CURR_COLORSCHEME_INDEX)
	print("Colorscheme set to: " .. new_scheme)
end

vim.api.nvim_create_user_command("ToggleColorscheme", toggle_colorscheme, {})
vim.keymap.set("n", "<leader>tc", ":ToggleColorscheme<CR>", { desc = "Toggle colorscheme" })

vim.cmd("colorscheme " .. COLORSCHEMES[get_saved_scheme()])

vim.api.nvim_create_user_command("DiagnoseComments", function()
	-- Get the current colorscheme
	print("Current colorscheme: " .. vim.g.colors_name)

	-- Check various comment highlight groups
	local groups = { "Comment", "@comment", "TSComment" }
	for _, group in ipairs(groups) do
		local hl = vim.api.nvim_get_hl(0, { name = group })
		print(group .. " highlight:")
		vim.print(hl)
	end
end, {})

-- Preload Node when claude-code plugin is about to be used
vim.api.nvim_create_autocmd("VimEnter", {
	callback = function()
		vim.defer_fn(function()
			vim.fn.jobstart({ "zsh", "-c", "source ~/.zshrc && nvm use default" }, {
				detach = true,
				on_exit = function(_, code)
					if code == 0 then
						vim.g.node_loaded_for_claude = true
					end
				end,
			})
		end, 200) -- Load 200ms after startup
	end,
})

--[[
Advanced Autosave Configuration

This autocommand automatically saves files when certain events occur, with safety checks
to prevent saving inappropriate buffers or non-existent files.

Triggers (when it runs):
- BufHidden: when a buffer becomes hidden (switched away from)
- FocusLost: when Neovim loses focus (switching to another application)  
- WinLeave: when leaving a window (changing splits/tabs)
- CursorHold: after cursor stays still for 'updatetime' milliseconds (default 4000ms)

Safety checks:
- buftype == '': only saves normal file buffers (excludes terminal, help, quickfix, etc.)
- filereadable(): only saves files that actually exist on disk (prevents errors on new unsaved files)

Save behavior:
- silent: suppresses save messages to avoid UI interruption
- lockmarks: preserves mark positions during save operation
- update: only saves if buffer has actual changes (more efficient than 'write')
- ++p: creates parent directories if they don't exist
--]]

vim.api.nvim_create_autocmd({ "BufHidden", "FocusLost", "WinLeave", "CursorHold" }, {
	pattern = "*",
	callback = function()
		if vim.bo.buftype == "" and vim.fn.filereadable(vim.fn.expand("%:p")) == 1 then
			pcall(vim.cmd, "silent lockmarks update ++p")
		end
	end,
	desc = "Advanced autosave with safety checks",
})

-- Map [[ to jump to previous shell prompt in terminal buffers
vim.api.nvim_create_autocmd("TermOpen", {
	callback = function()
		vim.keymap.set("n", "[[", "<Plug>(shell-prompt-previous)", { buffer = true })
		vim.keymap.set("n", "]]", "<Plug>(shell-prompt-next)", { buffer = true })
	end,
	desc = "Set shell prompt navigation in terminal buffers",
})

-- vim: ts=4 sts=4 sw=4 et
