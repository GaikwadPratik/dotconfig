return {
    "williamboman/mason.nvim",
	dependencies = {
		"williamboman/mason-lspconfig.nvim",
	},
	config = function()
		-- import mason
		local mason = require("mason")

		-- import mason-lspconfig
		local masonLspConfig = require("mason-lspconfig")

		mason.setup({
			ui = {
			    icons = {
					package_installed = "✓",
					package_pending = "➜",
					package_uninstalled = "✗"
				}
			}
		})

		masonLspConfig.setup({
			--list of server for Mason to install
			ensure_installed = {
				"rust_analyzer",
				"gopls",
				"lua_ls",
				"ruff",
				"basedpyright",
			},

			-- auto-installed configured servers (with lspconfig)
			automatic_installation = true,
		})
	end
}
