---@diagnostic disable: undefined-global
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
end

vim.api.nvim_create_user_command("ToggleBackground", toggle_bg, {})
vim.keymap.set("n", "<leader>bg", ":ToggleBackground<CR>", { desc = "Toggle background light/dark" })

-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`

local km_opts = { noremap = true, silent = true }

local function ext_km_opts(desc)
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

-- ,fugitive
-- vim.keymap.set("n", "<leader>gg", ":G<CR>", { noremap = true })
-- vim.keymap.set("n", "<leader>gf", ":Gedit :<CR>", { desc = "Fullscreen git view", noremap = true })
--
-- vim.keymap.set("n", "<leader>gb", ":G blame<CR>", { noremap = true })
-- vim.keymap.set("n", "<leader>gl", ":G log<CR>", { noremap = true })
-- vim.keymap.set("n", "<leader>gh", ":G log -s<CR>", { noremap = true })
-- vim.keymap.set("n", "<leader>gp", ":G push<CR>", { noremap = true })
-- vim.keymap.set("n", "<leader>gd", ":G diff<CR>", { noremap = true })
--
-- vim.keymap.set("n", "<leader>g-", ":Git stash<CR>:e<CR>", { noremap = true })
-- vim.keymap.set("n", "<leader>g+", ":Git stash pop<CR>:e<CR>", { noremap = true })
-- vim.keymap.set("n", "<leader>gw", "GBrowse", { noremap = true })
-- git checkout -- filename  # operates on buffer not file.
-- Can use undo and not get warnings about file changing outside vim
vim.keymap.set("n", "<leader>gr", ":Gread<CR>", { noremap = true })
-- writes to both the work tree and index versions of a file, making it like git add when
-- called from a work tree file and like git checkout when called from the index or a blob in history.
vim.keymap.set("n", "<leader>gw", ":Gwrite<CR>", { noremap = true })
-- vim.keymap.set("n", "<leader>gH",  ":G log<CR>:set nofoldenable<CR>")
-- vim.keymap.set("n", "<leader>gL", ":exe ':!cd ' . expand('%:p:h') . '; git la'<CR>")
-- vim.keymap.set("n", "<leader>gl", ":exe ':!cd ' . expand('%:p:h') . '; git las'<CR>")

-- easy command
vim.keymap.set("n", ";", ":", km_opts)
vim.keymap.set("v", ";", ":", km_opts) -- TODO: can this be consolidated?
vim.keymap.set("n", "<Space>;", ";", km_opts)
vim.keymap.set("n", "<Space>,", ",", km_opts)

-- Justfile tasks
vim.keymap.set("n", "<leader>j", ":! just ", { noremap = true })

-- Terminal
vim.keymap.set("n", "<c-t>", ":ToggleTerm direction=float<CR>", { desc = "open ToggleTerm" })
vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })
-- TODO: enter terminal mode?

-- git
vim.keymap.set("n", "<leader>g", ":!git ", { noremap = true })
vim.keymap.set("n", "<leader>gs", ":G status --short --branch<CR>", { noremap = true })

-- NeoGit
vim.keymap.set("n", "<leader>gg", ":Neogit<CR>", { noremap = true })

-- lua
vim.keymap.set("n", "<leader>lf", ":luafile ", { noremap = true })
vim.keymap.set("n", "<leader>lr", ":luafile %<CR>", { noremap = true })

-- system clipboard (yank into system clipboard, paste from clipboard register)
-- TODO: ISS: skips cursor line and yanks below it?
vim.keymap.set("n", "<leader>y", "+y<CR>", { noremap = true })
vim.keymap.set("n", "<leader>p", "+p<CR>", { noremap = true })

-- intriguing keymap used by Takuya
-- vim.keymap.set('n', 'dw', 'vb_d', { noremap = true, silent = true })

-- ,keymaps

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
vim.api.nvim_create_autocmd({ "BufLeave", "FocusLost" }, {
	callback = function()
		if vim.bo.modified and not vim.bo.readonly and vim.fn.expand("%") ~= "" and vim.bo.buftype == "" then
			vim.api.nvim_command("silent update")
		end
	end,
})

-- run nvim-lint linters. To run on every text change use event "TextChanged"
vim.api.nvim_create_autocmd({ "InsertLeave", "BufWritePost" }, {
	callback = function()
		local lint_status, lint = pcall(require, "lint")
		if lint_status then
			lint.try_lint()
		end
	end,
})

-- vim.api.nvim_create_autocmd("ColorScheme", {
-- 	pattern = "kanagawa",
-- 	callback = function()
-- 		if vim.o.background == "light" then
-- 			vim.fn.system("kitty +kitten themes Kanagawa_light")
-- 		elseif vim.o.background == "dark" then
-- 			vim.fn.system("kitty +kitten themes Kanagawa_dragon")
-- 		else
-- 			vim.fn.system("kitty +kitten themes Kanagawa")
-- 		end
-- 	end,
-- })

-- Use `opts = {}` to force a plugin to be loaded.
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
end ---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
	-- Extras
	-- spec = {
	-- 	{ "LazyVim/LazyVim",  import = "lazyvim.plugins" },
	-- 	{ import = "lazyvim.plugins.extras.coding.copilot" },
	-- 	{ import = "plugins" },
	-- },
	"tpope/vim-sleuth", -- Detect tabstop and shiftwidth automatically
	--  This is equivalent to:
	--    require('Comment').setup({})
	{ "numToStr/Comment.nvim", opts = {} },

	-- Here is a more advanced example where we pass configuration
	-- options to `gitsigns.nvim`. This is equivalent to the following Lua:
	--    require('gitsigns').setup({ ... })
	--
	-- See `:help gitsigns` to understand what the configuration keys do
	{ -- Adds git related signs to the gutter, as well as utilities for managing changes
		"lewis6991/gitsigns.nvim",
		opts = {
			signs = {
				add = { text = "+" },
				change = { text = "~" },
				delete = { text = "_" },
				topdelete = { text = "‾" },
				changedelete = { text = "~" },
			},
		},
	},

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
	--  config = function() ... end

	{ -- Useful plugin to show you pending keybinds.
		"folke/which-key.nvim",
		event = "VimEnter", -- Sets the loading event to 'VimEnter'
		config = function() -- This is the function that runs, AFTER loading
			require("which-key").setup()

			-- Document existing key chains
			require("which-key").register({
				["<leader>c"] = { name = "[C]ode", _ = "which_key_ignore" },
				["<leader>d"] = { name = "[D]ocument", _ = "which_key_ignore" },
				["<leader>r"] = { name = "[R]ename", _ = "which_key_ignore" },
				["<leader>s"] = { name = "[S]earch", _ = "which_key_ignore" },
				["<leader>w"] = { name = "[W]orkspace", _ = "which_key_ignore" },
				["<leader>t"] = { name = "[T]oggle", _ = "which_key_ignore" },
				["<leader>h"] = { name = "Git [H]unk", _ = "which_key_ignore" },
			})
			-- visual mode
			require("which-key").register({
				["<leader>h"] = { "Git [H]unk" },
			}, { mode = "v" })
		end,
	},

	{ -- Fuzzy Finder (files, lsp, etc)
		"nvim-telescope/telescope.nvim",
		event = "VimEnter",
		branch = "0.1.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			{ -- If encountering errors, see telescope-fzf-native README for installation instructions
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
			vim.keymap.set("n", "<leader><leader>", builtin.buffers, { desc = "[ ] Find existing buffers" })

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

	{ -- LSP Configuration & Plugins ,lsp
		"neovim/nvim-lspconfig",
		dependencies = {
			-- Automatically install LSPs and related tools to stdpath for Neovim
			{ "williamboman/mason.nvim", config = true }, -- NOTE: Must be loaded before dependants
			"williamboman/mason-lspconfig.nvim",
			"WhoIsSethDaniel/mason-tool-installer.nvim",
			"mfussenegger/nvim-lint",

			-- Useful status updates for LSP.
			-- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
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
							return client.name ~= "tsserver"
						end,
					})
					map("<leader>cF", vim.lsp.buf.format, "LSP [c]ode [F]ormat")

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
							vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
						end, "[T]oggle Inlay [H]ints")
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
				clangd = {},
				tsserver = {},
				eslint = {},
				rust_analyzer = {},
				ols = {},
				pyright = {},
				bashls = {},
				cmake = {},
				html = {},
				cssls = {},
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

			-- Ensure the servers and tools above are installed
			--  To check the current status of installed tools and/or manually install
			--  other tools, you can run
			--    :Mason
			require("mason").setup()

			-- You can add other tools here that you want Mason to install
			-- for you, so that they are available from within Neovim.
			local ensure_installed = vim.tbl_keys(servers or {})
			vim.list_extend(ensure_installed, {
				-- Install formatters for me, conform configs them
				"stylua",
				"rust_analyzer",
				"prettier",
				"prettierd",
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
					["tsserver"] = function()
						local lspconfig = require("lspconfig")
						lspconfig.tsserver.setup({
							settings = {},
						})
					end,
				},
			})

			local lspc = require("lspconfig")
			-- does this work?
			-- version A
			-- lspc.eslint.setup({
			--     on_attach = function(_client, bufnr)
			--         vim.api.nvim_create_autocmd("BufWritePre", {
			--             buffer = bufnr,
			--             command = "EslintFixAll",
			--         })
			--     end,
			--     settings = {
			--         workingDirectory = { mode = "location" },
			--     },
			--     root_dir = lspc.util.find_git_ancestor,
			-- })
			lspc.eslint.setup({
				root_dir = lspc.util.root_pattern(
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
	{
		"mfussenegger/nvim-lint",
		config = function()
			local lint = require("lint")
			lint.linters_by_ft = {
				javascript = { "eslint_d" },
				typescript = { "eslint_d" },
				javascriptreact = { "eslint_d" },
				typescriptreact = { "eslint_d" },
				-- odin = { "ols"}
			}
		end,
	},
	{ -- Autoformat ,fmt :: use external formatter if available, fallback to lsp
		"stevearc/conform.nvim",
		lazy = false,
		keys = {
			{
				"<leader>cf",
				function()
					require("conform").format({ async = true, lsp_fallback = true, timeout_ms = 3000 })
				end,
				mode = { "n", "v" },
				desc = "[c]ode [f]ormat buffer",
			},
		},
		opts = {
			log_level = vim.log.levels.DEBUG,
			notify_on_error = false,
			format_on_save = function(bufnr)
				-- Disable "format_on_save lsp_fallback" for languages that don't
				-- have a well standardized coding style. You can add additional
				-- languages here or re-enable it for the disabled ones.
				local disable_filetypes = { c = true, cpp = true }
				return {
					timeout_ms = 500,
					lsp_fallback = not disable_filetypes[vim.bo[bufnr].filetype],
				}
			end,
			formatters_by_ft = {
				lua = { "stylua" },
				rust = { "rust_analyzer" },
				-- Conform can also run multiple formatters sequentially
				-- You can use a sub-list to tell conform to run *until* a formatter is found.
				odin = { "ols" },
				javascript = { { "prettierd", "prettier" } },
				typescript = { { "prettierd", "prettier" } },
				typescriptreact = { { "prettier" } },
				javascriptriptreact = { { "prettier" } },
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
	-- {
	--   'ellisonleao/gruvbox.nvim',
	--   priority = 1000,
	--   config = true,
	--   init = function()
	--     vim.cmd.colorscheme 'gruvbox'
	--   end,
	--   opts = { contrast = 'hard' },
	-- },
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
		end,
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
	{ -- Highlight, edit, and navigate code ,treesitter
		-- TODO: explore features
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		opts = {
			ensure_installed = {
				"diff",
				"git_rebase",
				"git_config",
				"gitignore",
				"markdown",
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
	},
	-- require 'kickstart.plugins.debug',
	-- require 'kickstart.plugins.indent_line',
	-- require 'kickstart.plugins.lint',
	require("kickstart.plugins.autopairs"),
	require("kickstart.plugins.gitsigns"), -- adds gitsigns recommend keymaps

	-- Custom ,plugins `:help lazy.nvim-lazy.nvim-structuring-your-plugins`
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
		dependencies = { "nvim-lua/plenary.nvim", "sindrets/diffview.nvim", "ibhagwan/fzf-lua" },
		opts = {
			graph_style = "unicode",
			-- use_default_keymaps = true,
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
	{
		"lukas-reineke/indent-blankline.nvim",
		main = "ibl",
		opts = {},
	},
	{
		"zbirenbaum/copilot.lua",
		cmd = "Copilot",
		event = "InsertEnter",
		opts = {
			filetypes = {
				javascript = true,
				typescript = true,
				javascriptreact = true,
				typescriptreact = true,
				python = true,
				bash = true,
				zsh = true,
				rust = true,
				odin = false,
				sh = function()
					if string.match(vim.fs.basename(vim.api.nvim_buf_get_name(0)), "^%.env.*") then
						-- disable for .env files
						return false
					end
					return true
				end,
				["*"] = false, -- disable all others
			},
		},
	},
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
	-- { import = "custom.plugins" },
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

print(vim.opt.guifont)
-- vim: ts=4 sts=4 sw=4 et
