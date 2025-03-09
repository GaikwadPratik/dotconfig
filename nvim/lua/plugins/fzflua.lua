return {
	"ibhagwan/fzf-lua",
	-- optional for icon support
	-- dependencies = { "nvim-tree/nvim-web-devicons" },
	--or if using mini.icons/mini.nvim
	dependencies = { "echasnovski/mini.icons" },
	opts = {},
	config = function()
		local fzflua = require("fzf-lua")
		vim.keymap.set("n", "<leader>ff", fzflua.files, { desc = "[f]ind [f]iles in cwd" })
		vim.keymap.set("n", "<leader>fg", fzflua.live_grep, { desc = "[f]ind by [g]rep in cwd" })
		vim.keymap.set("n", "<leader>fh", fzflua.helptags, { desc = "[f]ind in [h]rep of NVIM" })
		vim.keymap.set("n", "<leader>fk", fzflua.keymaps, { desc = "[f]ind in [k]eymaps" })
		vim.keymap.set("n", "<leader>fr", fzflua.resume, { desc = "[f]ind [r]esume from last search" })
	end,
}
