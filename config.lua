-- Read the docs: https://www.lunarvim.org/docs/configuration
-- Video Tutorials: https://www.youtube.com/watch?v=sFA9kX-Ud_c&list=PLhoH5vyxr6QqGu0i7tt_XoVK9v-KvZ3m6
-- Forum: https://www.reddit.com/r/lunarvim/
-- Discord: https://discord.com/invite/Xb9B4Ny
lvim.builtin.terminal.open_mapping = "<c-v>"
vim.cmd("command! QQ q!")
vim.cmd("command! Q q")
vim.cmd("command! WQ wq")
lvim.keys.normal_mode[";"] = ":"
lvim.keys.normal_mode["."] = ";"
lvim.keys.normal_mode["qq"] = ":q!"
lvim.keys.normal_mode["qQ"] = ":q!"
lvim.keys.normal_mode["Qq"] = ":q!"
lvim.keys.normal_mode["QQ"] = ":q!"

lvim.format_on_save.enabled = true
local formatters = require("lvim.lsp.null-ls.formatters")
formatters.setup({
	{ name = "stylua" },
	{ name = "clang_format" },
	{ name = "prettierd" },
	{ name = "black" },
})

local linters = require("lvim.lsp.null-ls.linters")
linters.setup({
	{ name = "ruff" },
})

require("lvim.lsp.manager").setup("cssls", {
	settings = {
		css = { validate = true, lint = {
			unknownAtRules = "ignore",
		} },
		scss = { validate = true, lint = {
			unknownAtRules = "ignore",
		} },
		less = { validate = true, lint = {
			unknownAtRules = "ignore",
		} },
	},
})

local opts = {
	root_dir = { "*.asm" },
}

require("lvim.lsp.manager").setup("asm_lsp", opts)

require("lvim.lsp.manager").setup("astro", {
	init_options = {
		typescript = { tsdk = vim.fs.normalize("./node_modules/typescript/lib") },
	},
})

lvim.plugins = {
	"AckslD/swenv.nvim",
	"stevearc/dressing.nvim",
	{
		"max397574/better-escape.nvim",
		event = "InsertEnter",
		config = function()
			require("better_escape").setup()
		end,
	},
	{
		"ellisonleao/glow.nvim",
		config = true,
		cmd = "Glow",
	},
	{
		"christoomey/vim-tmux-navigator",
		cmd = {
			"TmuxNavigateLeft",
			"TmuxNavigateDown",
			"TmuxNavigateUp",
			"TmuxNavigateRight",
			"TmuxNavigatePrevious",
		},
		keys = {
			{ "<c-h>", "<cmd><C-U>TmuxNavigateLeft<cr>" },
			{ "<c-j>", "<cmd><C-U>TmuxNavigateDown<cr>" },
			{ "<c-k>", "<cmd><C-U>TmuxNavigateUp<cr>" },
			{ "<c-l>", "<cmd><C-U>TmuxNavigateRight<cr>" },
			{ "<c-\\>", "<cmd><C-U>TmuxNavigatePrevious<cr>" },
		},
	},
	{
		"mistricky/codesnap.nvim",
		build = "make",
		lazy = "true",
		cmd = "CodeSnapPreviewOn",
	},
	{
		"folke/flash.nvim",
		event = "VeryLazy",
		-- 	---@type Flash.Config
		opts = {},
  -- stylua: ignore
  keys = {
     { "<leader><leader>", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
     { "S", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
     { "r", mode = "o", function() require("flash").remote() end, desc = "Remote Flash" },
     { "R", mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
     { "<c-s>", mode = { "c" }, function() require("flash").toggle() end, desc = "Toggle Flash Search" },
    },
	},
}

lvim.builtin.which_key.mappings["C"] = {
	name = "Python",
	c = { "<cmd>lua require('swenv.api').pick_venv()<cr>", "Choose Env" },
}

lvim.builtin.which_key.mappings["n"] = {
	name = "Number",
	n = { "<cmd>set relativenumber!<CR>", "Toggle relative line numbers" },
}

-- X closes a buffer
-- lvim.keys.normal_mode["<Tab>"] = ":BufferKill<CR>"
