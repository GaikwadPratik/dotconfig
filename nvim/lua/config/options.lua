-- Set the leader key to the space bar
vim.g.mapleader = " "

-- Make sure vim knows the background is dark
vim.opt.background = "dark"

-- Set the highlight colors for the listchars
vim.cmd("hi NonText ctermfg=237")
vim.cmd("hi SpecialKey ctermfg=237")

-- Detect all Dockerfiles with extensions
vim.filetype.add({
    pattern = {["Dockerfile*"] = "dockerfile"},
})

-- Set the representation for whitespace
vim.opt.listchars = "tab:» ,extends:›,precedes:‹,nbsp:·,trail:·,eol:¬"
vim.opt.list = true

-- keep signcolumn on by default
vim.opt.signcolumn = "yes"

-- Line numbers
vim.opt.number = true
vim.opt.relativenumber = true

-- Enable mouse in all modes
vim.opt.mouse = "a"

vim.opt.ruler = true
vim.opt.cursorline = true

-- Store undo between session
vim.opt.undofile = true

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


