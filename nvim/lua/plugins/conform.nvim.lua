return {
	"stevearc/conform.nvim",
	config = function()
		local conform = require("conform")
		conform.setup({
			formatters_by_ft = {
				go = { "golines" },
				python = { "ruff_format", "ruff_organize_imports" },
				rust = { "rustfmt" },
				sh = { "shfmt" },
				lua = { "stylua" },
			},
			format_on_save = {
				lsp_format = "never",
				timeout_ms = 1000,
			},
		})

		conform.formatters.golines = {
			prepend_args = { "--base-formatter=gofumpt" },
		}

		vim.keymap.set("n", "gq", conform.format, { noremap = true })
	end,
}
