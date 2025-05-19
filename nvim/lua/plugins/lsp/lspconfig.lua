return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		{ "j-hui/fidget.nvim", opts = {} },
	},
	config = function()
		-- import lspconfig plugin
		local lspconfig = require("lspconfig")

		-- import mason_lspconfig plugin
		local mason_lspconfig = require("mason-lspconfig")

		local keymap = vim.keymap

		vim.api.nvim_create_autocmd("LspAttach", {
			group = vim.api.nvim_create_augroup("UserLspConfig", {}),
			callback = function(ev)
				-- Buffer local mappings.
				-- See `:help vim.lsp.*` for documentation on any of the below functions
				local opts = { buffer = ev.buf, silent = true }

				-- set keybinds
				opts.desc = "Show documentation on hover"
				keymap.set("n", "K", vim.lsp.buf.hover, opts)

				opts.desc = "Go to definition"
				keymap.set("n", "<F12>", "<cmd>FzfLua lsp_definitions<CR>", opts)

				opts.desc = "[g]o to [D]eclaration"
				keymap.set("n", "gD", "<cmd>FzfLua lsp_declarations<CR>", opts)

				opts.desc = "[g]o to [i]mplementation"
				keymap.set("n", "gi", "<cmd>FzfLua lsp_implementations<CR>", opts)

				opts.desc = "[g]o to [t]ype_definition"
				keymap.set("n", "gt", "<cmd>FzfLua lsp_typedefs<CR>", opts)

				opts.desc = "[g]o to [r]eferences"
				keymap.set("n", "gr", "<cmd>FzfLua lsp_references<CR>", opts)

				opts.desc = "[c]ode [a]ctions"
				keymap.set("n", "<leader>ca", "<cmd>FzfLua lsp_code_actions<CR>", opts)

				opts.desc = "[g]o to [s]ignature_help"
				keymap.set("n", "gs", vim.lsp.buf.signature_help, opts)

				opts.desc = "Rename smartly"
				keymap.set("n", "<F2>", vim.lsp.buf.rename, opts)

				opts.desc = "Open diagnostic"
				keymap.set("n", "gl", vim.diagnostic.open_float)

				opts.desc = "Go to next [d]iagnostic"
				keymap.set("n", "[d", vim.diagnostic.goto_prev)

				opts.desc = "Go to previous [d]iagnostic"
				keymap.set("n", "]d", vim.diagnostic.goto_next)

				local client = vim.lsp.get_client_by_id(ev.data.client_id)
				-- Stop the language server from providing formatting, we want
				-- to use the conform plugin instead
				client.server_capabilities.documentFormattingProvider = false
				client.server_capabilities.documentFormattingRangeProvider = false
			end,
		})

		-- used to enable autocompletion (assign to every lsp server config)
		local original_capabilities = vim.lsp.protocol.make_client_capabilities()
		local capabilities = require("blink-cmp").get_lsp_capabilities(original_capabilities)

		-- Change the Diagnostic symbols in the sign column (gutter)
		-- (not in youtube nvim video)
		local signs = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }
		for type, icon in pairs(signs) do
			local hl = "DiagnosticSign" .. type
			vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
		end

		mason_lspconfig.setup_handlers({
			-- default handler for installed servers
			function(server_name)
				lspconfig[server_name].setup({
					capabilities = capabilities,
				})
			end,
			lspconfig.lua_ls.setup({
				settings = {
					Lua = {
						diagnostics = {
							-- Get the language server to recognize the `vim` global
							globals = { "vim" },
						},
					},
				},
				capabilities = capabilities,
			}),
			lspconfig.gopls.setup({
				capabilities = capabilities,
			}),
			lspconfig.rust_analyzer.setup({
				capabilities = capabilities,
				settings = {
					["rust-analyzer"] = {
						check = {
							command = "clippy",
						},
					},
				},
			}),
			lspconfig.basedpyright.setup({
				capabilities = capabilities,
				settings = {
					basedpyright = {
						analysis = {
							typeCheckingMode = "off",
						},
					},
				},
			}),
			lspconfig.ruff.setup({
				capabilities = capabilities,
			}),
			lspconfig.bashls.setup({
				capabilities = capabilities,
			}),
			lspconfig.dockerls.setup({
				capabilities = capabilities,
			}),
		})
	end,
}
