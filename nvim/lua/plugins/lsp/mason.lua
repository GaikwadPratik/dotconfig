return {
	"mason-org/mason-lspconfig.nvim",
	dependencies = {
		{
			"mason-org/mason.nvim",
			opts = {
				ui = {
					icons = {
						package_installed = "✓",
						package_pending = "➜",
						package_uninstalled = "✗",
					},
				},
			},
		},
		"neovim/nvim-lspconfig",
	},
	opts = {
		--list of server for Mason to install
		ensure_installed = {
			"rust_analyzer",
			"gopls",
			"lua_ls",
			"ruff",
			"basedpyright",
			"bashls",
			"dockerls",
		},

		automatic_enable = true,
	},
}
