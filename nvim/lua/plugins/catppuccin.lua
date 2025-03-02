return {
	"catppuccin/nvim", 
	name = "catppuccin", 
	priority = 1000,
	config=function()
		require("catppuccin").setup({
			flavour = "mocha", -- latte, frappe, macchiato, mocha
			background = { -- :h background
				dark = "mocha",
			},
			transparent_background = true,
		});
		vim.cmd("colorscheme catppuccin-mocha");
	end
}
