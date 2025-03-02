return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	config = function ()
		local configs = require("nvim-treesitter.configs")

		configs.setup({
			ensure_installed = { "go", "lua", "vim", "vimdoc", "rust", "jq",
				"json", "javascript", "bash", "cmake", "gomod", "gosum",
				"gotmpl", "gowork", "dockerfile", "git_config", "gitignore",
				"make",  "nginx", "passwd", "proto", "python", "regex",
				"ssh_config", "terraform", "tmux", "yaml"
			},
			auto_install = true,
			sync_install = false,
			highlight = { enable = true },
			indent = { enable = true },
			incremental_selection = {
				enable = true,
				keymaps = {
					init_selection = "<Enter>",
					node_incremental = "<Enter>",
					scope_incremental = false,
					node_decremental = "<Backspace>",
				},
			},
			textobjects = {
				select = {
					enable = true,
					lookahead = true,
				},
			},
		})
	end
}
