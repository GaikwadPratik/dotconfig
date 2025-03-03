return {
	{
		"neovim/nvim-lspconfig",
		config = function()
			local lspconfig = require("lspconfig")
			lspconfig.lua_ls.setup({})

			lspconfig.gopls.setup({})

			lspconfig.rust_analyzer.setup({
				settings = {
					["rust-analyzer"] = {
						check = {
							command = "clippy",
						},
					},
				},
			})

			vim.keymap.set("n", "gl", vim.diagnostic.open_float)
			vim.keymap.set("n", "[d", vim.diagnostic.goto_prev)
			vim.keymap.set("n", "]d", vim.diagnostic.goto_next)
			vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist)

			vim.api.nvim_create_autocmd("LspAttach", {
				group = vim.api.nvim_create_augroup("UserLspConfig", {}),
				callback = function(ev)
					-- vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

					-- buffer-local mappings
					local opts = { buffer = ev.buf }
					vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
					vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
					vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
					vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
					vim.keymap.set("n", "go", vim.lsp.buf.type_definition, opts)
					vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
					vim.keymap.set("n", "gs", vim.lsp.buf.signature_help, opts)

					local client = vim.lsp.get_client_by_id(ev.data.client_id)

					-- None of this semantics tokens business.
					-- https://www.reddit.com/r/neovim/comments/143efmd/is_it_possible_to_disable_treesitter_completely/
					-- client.server_capabilities.semanticTokensProvider = nil

					-- Stop the language server from providing formatting, we want
					-- to use the conform plugin instead
					client.server_capabilities.documentFormattingProvider = false
					client.server_capabilities.documentFormattingRangeProvider = false
				end,
			})
		end,
	},
}
