return {
	"williamboman/mason-lspconfig.nvim",
	dependencies = {
		"williamboman/mason.nvim",
	},
	config = function()
		require("mason-lspconfig").setup({
			ensure_installed = {
				"rust_analyzer",
				"gopls",
				"lua_ls",
				"ruff",
				"basedpyright",
			},
			automatic_installation = true,
		})
		require("mason-lspconfig").setup_handlers({
			function(server_name)
				require("lspconfig")[server_name].setup({})
			end,
		})
	end,
}
