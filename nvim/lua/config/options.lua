-- Set the leader key to the space bar
-- Make sure vim knows the background is dark
vim.opt.background = "dark"

-- Detect all Dockerfiles with extensions
vim.filetype.add({
	pattern = { ["Dockerfile*"] = "dockerfile" },
})

-- Set the representation for whitespace
vim.opt.listchars = "tab:» ,extends:›,precedes:‹,nbsp:·,trail:·,eol:¬"
vim.opt.list = true

-- keep signcolumn on by default
vim.opt.signcolumn = "yes"

-- Line numbers
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.statuscolumn = "%s %l %r"

-- Enable mouse in all modes
vim.opt.mouse = "a"

vim.opt.ruler = true
vim.opt.cursorline = true

-- Store undo between session
vim.opt.undofile = true

-- Minimal number of screen lines to keep above and below the cursor
vim.opt.scrolloff = 10

--Sync clipboard between OS and neovim
--Schedule the setting after `UiEnter` because it can increase startup-time
--Remove this option if you want your OS clipboard to remain independent
-- see :help `clipboard`
vim.schedule(function()
	vim.opt.clipboard = "unnamedplus"
end)

-- Don't show mode since mini-status line is installed
vim.opt.showmode = false

-- Use short tabs-to-spaces by default
vim.opt.expandtab = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4

vim.opt.smarttab = true
vim.opt.smartindent = true
vim.opt.autoindent = true
vim.opt.breakindent = true

-- Proper search
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hlsearch = true

-- Turn off incremental search
vim.opt.incsearch = false

-- Proper split behavior
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Show a column at 80 characters as a guide for long lines
vim.opt.colorcolumn = "80"

-- except in Rust where the rule is 100 characters and Go where there is no
-- rule but golines defaults to 100 characters
vim.api.nvim_create_autocmd("Filetype", { pattern = { "rust", "go" }, command = "set colorcolumn=100" })

-- Key remaps for moving between splits
vim.keymap.set("n", "<C-h>", "<C-w>h", { noremap = true })
vim.keymap.set("n", "<C-j>", "<C-w>j", { noremap = true })
vim.keymap.set("n", "<C-k>", "<C-w>k", { noremap = true })
vim.keymap.set("n", "<C-l>", "<C-w>l", { noremap = true })

-- Leader mappings for opening new splits
vim.keymap.set("n", "<leader>s", "<C-w>s", { noremap = true })
vim.keymap.set("n", "<leader>v", "<C-w>v", { noremap = true })

-- Dismiss Noice messages
vim.keymap.set("n", "<leader>nd", "<cmd>NoiceDismiss<CR>", { desc = "Dismiss Noice notification messages" })

-- 24-bit color for nvim-notify
vim.opt.termguicolors = true
