return {
	"romgrk/barbar.nvim",
	dependencies = {
	  "lewis6991/gitsigns.nvim", -- OPTIONAL: for git status
	  "nvim-tree/nvim-web-devicons", -- OPTIONAL: for file icons
	},
	init = function()
		vim.g.barbar_auto_setup = false
	end,
	config=function()
		require("barbar").setup({
			focus_on_close = "previous",
			hide = {
				extensions = "visible"
			},
			clickable = true,
			tabpages = false,
			insert_at_end = true,
			icons = {
				button = 'x',
				buffer_index = true,
				filetype = {	enabled = true	},
				visible = {
					modified = {	buffer_number = true	},
				},
				gitsigns = {
					added = {enabled = true, icon = '+'},
					changed = {enabled = true, icon = '~'},
					deleted = {enabled = true, icon = '-'},
				},
			},
		});

		local map = vim.api.nvim_set_keymap
		local opts = { noremap = true, silent = true }

		vim.keymap.set("n", "<Space>gt", "<Cmd>BufferPrevious<CR>", opts)
		vim.keymap.set("n", "<Space>gT", "<Cmd>BufferNext<CR>", opts)
	end,
}
