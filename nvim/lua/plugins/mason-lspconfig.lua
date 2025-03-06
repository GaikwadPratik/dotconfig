return {
	"williamboman/mason-lspconfig.nvim",
	config = function()
		require("mason-lspconfig").setup({
			ensure_installed = {
				"rust_analyzer",
				"gopls",
				"lua_ls",
				"ruff",
				"pyright",
			},
			automatic_installation = true,
		})
	end,
}
