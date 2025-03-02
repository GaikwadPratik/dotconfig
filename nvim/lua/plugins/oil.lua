return {
	"stevearc/oil.nvim",
	config =function()
		require("oil").setup({
			columns = {
				"icon",
				"permissions",
				"size",
				"mtime",
			},
			-- Set to true to watch the filesystem for changes and reload oil
			watch_for_changes = false,
		});
	end,
	---@module "oil"
	---@type oil.SetupOpts,
	-- Optional dependencies
	dependencies = {
		{
			"echasnovski/mini.icons",
			opts = {}
		},
		{
			"nvim-tree/nvim-web-devicons"
		}
	},
	-- dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if you prefer nvim-web-devicons
	-- Lazy loading is not recommended because it is very tricky to make it work correctly in all situations.
	lazy = false,
}
