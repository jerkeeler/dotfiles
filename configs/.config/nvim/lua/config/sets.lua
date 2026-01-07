vim.g.mapleader = " "
vim.g.maplocalleader = "\\"
-- vim.opt.notermguicolors = true
vim.opt.number = true
vim.opt.bg = "dark"
vim.opt.relativenumber = true
vim.opt.clipboard = "unnamedplus"
vim.opt.autoindent = true
vim.opt.cursorline = true
vim.opt.expandtab = true
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
-- Prevent tabstops from being 4 in markdown files
-- vim.g.markdown_recommended_style = 0
vim.opt.encoding = "UTF-8"
vim.opt.ruler = true
vim.opt.title = true
vim.opt.hidden = true
vim.opt.timeoutlen = 300 -- Time to wait for mapped sequence (ms)
vim.opt.ttimeoutlen = 50
vim.opt.wildmenu = true
vim.opt.showcmd = true
vim.opt.showmatch = true
vim.opt.inccommand = "split"
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.wrap = false
vim.opt.colorcolumn = "120"
vim.opt.listchars = {
	-- eol = "↲",
	tab = "▸ ",
	trail = "·",
	extends = "❯",
	precedes = "❮",
	--space = "␣",
	nbsp = "⦸",
}
vim.opt.showbreak = "↪ " -- Prefix for wrapped lines
vim.opt.linebreak = true

vim.opt.list = true

-- Ensure at least 8 lines offset from bottom of window
vim.opt.scrolloff = 8
-- vim.opt.t_Co = 256

-- Incrementally search from current line, ignore casing on search
vim.opt.incsearch = true
vim.opt.ignorecase = true
-- vim.opt.hlserach = true

-- Set conceal level for the Obsidian plugin, not sure what this does
vim.opt.conceallevel = 2

-- Enable project-local config (.nvim.lua files)
-- Neovim will prompt before executing untrusted files
vim.opt.exrc = true

vim.g.copilot_filetypes = {markdown = false}
