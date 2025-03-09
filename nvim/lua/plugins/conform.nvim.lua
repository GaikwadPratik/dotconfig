return {
	"stevearc/conform.nvim",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		local conform = require("conform")
		vim.keymap.set("n", "gq", conform.format, { desc = "Invoke conform formatter", noremap = true })
		conform.setup({
			format_on_save = {
				timeout_ms = 500,
				lsp_format = "never",
			},
			formatters_by_ft = {
				go = { "gofumpt" },
				python = { "ruff_format", "ruff_organize_imports" },
				rust = { "rustfmt" },
				sh = { "shfmt" },
				lua = { "stylua" },
			},
		})
	end,
}
