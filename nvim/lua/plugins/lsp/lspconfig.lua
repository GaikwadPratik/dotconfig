local function on_lsp_attch(ev)
	local function map(lhs, rhs, desc)
		vim.keymap.set("n", lhs, rhs, { buffer = ev.buf, silent = true, desc = desc })
	end

	map("K", vim.lsp.buf.hover, "Show documentation on hover")
	map("<F12>", "<cmd>FzfLua lsp_definitions<CR>", "Go to definition")
	map("gD", "<cmd>FzfLua lsp_declarations<CR>", "Go to declaration")
	map("gi", "<cmd>FzfLua lsp_implementations<CR>", "Go to implementations")
	map("gt", "<cmd>FzfLua lsp_typedefs<CR>", "Go to type definition")
	map("gr", "<cmd>FzfLua lsp_references<CR>", "Go to references")
	map("<leader>ca", "<cmd>FzfLua lsp_code_actions<CR>", "Code actions")
	map("gs", vim.lsp.buf.signature_help, "Signature help")
	map("<F2>", vim.lsp.buf.rename, "Rename symbol")

	local client = vim.lsp.get_client_by_id(ev.data.client_id)
	if not client then
		return
	end

	-- Keep formatting with Conform
	client.server_capabilities.documentFormattingProvider = false
	client.server_capabilities.documentRangeFormattingProvider = false
end

local function configure_diagnostics()
	local severity = vim.diagnostic.severity

	vim.diagnostic.config({
		signs = {
			text = {
				[severity.ERROR] = " ",
				[severity.WARN] = " ",
				[severity.HINT] = "󰠠 ",
				[severity.INFO] = " ",
			},
		},
		jump = {
			on_jump = function(diagnostic, bufnr)
				if not diagnostic then
					return
				end
				vim.diagnostic.open_float({ bufnr = bufnr, scope = "cursor", focus = false })
			end,
		},
	})
	vim.keymap.set("n", "gl", vim.diagnostic.open_float, { desc = "Open diagnostic" })
end

return {
	"neovim/nvim-lspconfig",
	dependencies = {
		{ "j-hui/fidget.nvim", opts = {} },
		"saghen/blink.cmp",
	},
	config = function()
		configure_diagnostics()

		vim.api.nvim_create_autocmd("LspAttach", {
			group = vim.api.nvim_create_augroup("UserLspConfig", { clear = true }),
			callback = on_lsp_attch,
		})

		vim.lsp.config("*", {
			capabilities = require("blink.cmp").get_lsp_capabilities(),
		})

		vim.lsp.config("lua_ls", {
			settings = {
				Lua = {
					diagnostics = {
						globals = { "require" },
					},
				},
			},
		})

		vim.lsp.config("rust_analyzer", {
			settings = {
				["rust-analyzer"] = {
					check = { command = "clippy" },
				},
			},
		})

		vim.lsp.config("basedpyright", {
			settings = {
				basedpyright = {
					analysis = { typeCheckingMode = "off" },
				},
			},
		})

		vim.lsp.config("gopls", {
			settings = {
				gopls = {
					templateExtensions = { "gotmpl" },
				},
			},
		})
	end,
}
