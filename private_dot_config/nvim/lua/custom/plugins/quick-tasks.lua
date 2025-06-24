return {
	"quick-tasks",
	dev = true,
	dir = "~/.config/nvim/lua/custom/plugins/quick-tasks.lua",
	-- dir = vim.fn.stdpath 'config' .. '/lua/quick-tasks',
	config = function()
		local M = {}

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

			-- Execute the task in a new terminal split
			-- TODO: see how did this for existing `<leader>ff/fg/fv/fb`
			vim.cmd("split | terminal " .. script_path .. " " .. task_letter)
		end

		-- Set up keymaps
		vim.keymap.set("n", "<leader>fq", create_task_script, {
			desc = "Create quick task script",
		})

		vim.keymap.set("n", "<leader>rr", function()
			run_task("a")
		end, {
			desc = "Run quick task A",
		})

		vim.keymap.set("n", "<leader>rt", function()
			run_task("b")
		end, {
			desc = "Run quick task B",
		})

		vim.keymap.set("n", "<leader>rf", function()
			run_task("c")
		end, {
			desc = "Run quick task C",
		})

		vim.keymap.set("n", "<leader>rg", function()
			run_task("d")
		end, {
			desc = "Run quick task D",
		})

		-- Optional: Add command for manual task script creation
		vim.api.nvim_create_user_command("QuickTaskCreate", create_task_script, {
			desc = "Create quick task script in current directory",
		})

		-- Optional: Add command to run specific tasks
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
	end,
}
