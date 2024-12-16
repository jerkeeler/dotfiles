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
vim.opt.encoding = "UTF-8"
vim.opt.ruler = true
vim.opt.title = true
vim.opt.hidden = true
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
vim.opt.list = true

-- Ensure at least 8 lines offset from bottom of window
vim.opt.scrolloff = 8
-- vim.opt.t_Co = 256

-- Incrementally search from current line, ignore casing on search
vim.opt.incsearch = true
vim.opt.ignorecase = true
-- vim.opt.hlserach = true
--
-- Set `commentstring` for a specific filetype
vim.api.nvim_create_autocmd("FileType", {
	pattern = "sql", -- Replace with your desired filetype
	callback = function()
		vim.bo.commentstring = "-- %s"
	end,
})
