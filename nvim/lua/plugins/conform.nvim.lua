return {
	"stevearc/conform.nvim",
	keys = {
		{
			"gq",
			function()
				require("conform").format()
			end,
			desc = "Invoke conform formatter",
		},
	},
	opts = {
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
	},
}
