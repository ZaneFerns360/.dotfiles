-- Read the docs: https://www.lunarvim.org/docs/configuration
-- Video Tutorials: https://www.youtube.com/watch?v=sFA9kX-Ud_c&list=PLhoH5vyxr6QqGu0i7tt_XoVK9v-KvZ3m6
-- Forum: https://www.reddit.com/r/lunarvim/
-- Discord: https://discord.com/invite/Xb9B4Ny
lvim.builtin.terminal.open_mapping = "<c-v>"
vim.cmd("command! QQ q!")
vim.cmd("command! Q q")
vim.api.nvim_set_keymap("n", "Q!", ":q!<CR>", { noremap = true })
vim.cmd("command! WQ wq")
lvim.keys.normal_mode[";"] = ":"
lvim.keys.normal_mode["."] = ";"

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
}

lvim.builtin.which_key.mappings["C"] = {
	name = "Python",
	c = { "<cmd>lua require('swenv.api').pick_venv()<cr>", "Choose Env" },
}
