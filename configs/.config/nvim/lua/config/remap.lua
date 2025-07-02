local function map(mode, lhs, rhs)
	vim.keymap.set(mode, lhs, rhs, { silent = true })
end

-- Smart way to move between windows
map("n", "<C-j>", "<C-W>j")
map("n", "<C-k>", "<C-W>k")
map("n", "<C-h>", "<C-W>h")
map("n", "<C-l>", "<C-W>l")

-- Smart way to resize windows
map("n", "<C-Right>", "<C-w><")
map("n", "<C-Left>", "<C-w>>")
map("n", "<C-Up>", "<C-w>+")
map("n", "<C-Down>", "<C-w>-")

-- New windows
map("n", "<leader>so", "<CMD>vsplit<CR>")
map("n", "<leader>sp", "<CMD>split<CR>")

-- Hop to the basic file browser easily, "fd" for file directory
-- map("n", "<Leader>fd", "<cmd>Ex<cr>")

-- Change buffern easily
map("n", "<Leader>l", "<cmd>bnext<cr>")
map("n", "<Leader>h", "<cmd>bprevious<cr>")

-- Change tabs easily
map("n", "<Leader>tn", "<cmd>tabn<cr>")
map("n", "<Leader>tp", "<cmd>tabp<cr>")

-- Quick scribble buffer
map("n", "<Leader>q", "<cmd>e ~/buffer<cr>")

-- Toggle paste mode on/off
map("n", "<Leader>pp", "<cmd>setlocal paste!<cr>")

-- Fast saving
map("n", "<Leader>w", "<cmd>w!<cr>")

-- Fast closing
map("n", "<Leader>x", "<cmd>close<cr>")

-- Mapping ctrl-d and ctrl-d so cursor is in the middle
map("n", "<C-u>", "<C-u>zz")
map("n", "<C-d>", "<C-d>zz")
map("n", "n", "nzz")
map("n", "N", "Nzz")

-- Make a leader + p paste and not overwrite the buffer! Super useful
map("x", "<leader>p", '"_dP')

-- Toggle spelling
map("n", "<leader>ss", "<cmd>set invspell<cr>")

-- """"""""""""""""""""""""""""""
-- " => Visual mode related
-- """"""""""""""""""""""""""""""
-- Visual mode pressing * or # searches for the current selection
-- Super useful! From an idea by Michael Naumann
map("v", "*", "<C-u>call VisualSelection('', '')<CR>/<C-R>=@/<CR><CR>")
map("v", "#", "<C-u>call VisualSelection('', '')<CR>/<C-R>=@/<CR><CR>")
-- Disable highlight when <leader><cr> is pressed
map("", "<Leader><cr>", "<cmd>noh<cr>")

-- """"""""""""""""""""""""""""""
-- " Telescope remaps
-- """"""""""""""""""""""""""""""
-- Function to close the current buffer while handling alternate buffers
local function buf_close()
	local current_buf = vim.fn.bufnr("%")
	local alternate_buf = vim.fn.bufnr("#")

	-- Try to switch to alternate buffer if it exists
	if vim.fn.buflisted(alternate_buf) == 1 then
		vim.cmd("buffer #")
	else
		vim.cmd("bnext")
	end

	-- If we're still on the same buffer, create a new one
	if vim.fn.bufnr("%") == current_buf then
		vim.cmd("new")
	end

	-- Delete the original buffer if it's still listed
	if vim.fn.buflisted(current_buf) == 1 then
		vim.cmd("bdelete! " .. current_buf)
	end
end
-- Create a user command to call the function
vim.api.nvim_create_user_command("Bclose", buf_close, {})
map("n", "<Leader>bd", "<cmd>bdelete<cr>")

-- """"""""""""""""""""""""""""""
-- DEPRECATED, using fzf-lua instead for performance
-- " Telescope remaps
-- """"""""""""""""""""""""""""""
-- map("n", "<leader>f", "<cmd>Telescope find_files<cr>", { desc = "Fuzzy find files in cwd" })
-- map("n", "<leader>b", "<cmd>Telescope buffers<cr>", { desc = "Fuzzy find files in buffers" })
-- map("n", "<leader>fi", function()
-- 	require("telescope.builtin").find_files({ no_ignore = true, hidden = true })
-- end, { desc = "Find files (including ignored)" })
-- map("n", "<leader>fg", "<cmd>Telescope live_grep<cr>")
-- map("n", "<leader>fb", "<cmd>Telescope file_browser<cr>")

-- """"""""""""""""""""""""""""""
-- " FzfLua remaps
-- """"""""""""""""""""""""""""""
map("n", "<leader>ff", "<cmd>FzfLua files<cr>")
map("n", "<leader>fb", "<cmd>FzfLua buffers<cr>")
map("n", "<leader>fg", "<cmd>FzfLua live_grep<cr>")
map("n", "<leader>fd", "<cmd>lua require('fzf-lua').lsp_document_symbols()<cr>")
-- map("n", "<leader>fw", "<cmd>lua require('fzf-lua').lsp_workspace_symbols()<cr>")
-- map("n", "<leader>fg", "<cmd>FzfLua git_files<cr>")

-- """"""""""""""""""""""""""""""
-- " Copilot
-- """"""""""""""""""""""""""""""
-- Change autocomplete key to <C-a>
vim.api.nvim_set_keymap("i", "<C-a>", 'copilot#Accept("<CR>")', { expr = true, silent = true })
vim.g.copilot_no_tab_map = true
map("n", "<C-c>", "<cmd>CopilotChatToggle<cr>")

-- """"""""""""""""""""""""""""""
-- " (DEPRECATED) Neotree remaps
-- """"""""""""""""""""""""""""""
-- map("n", "<leader>n", "<cmd>Neotree<cr>")
-- map("n", "<leader>nc", "<cmd>Neotree position=current<cr>")
-- map("n", "<leader>ng", "<cmd>Neotree float git_status<cr>")

-- """"""""""""""""""""""""""""""
-- " Nvim-tree remaps
-- """"""""""""""""""""""""""""""
map("n", "<leader>n", "<cmd>NvimTreeToggle<cr>")
-- map("n", "<leader>nc", "<cmd>Neotree position=current<cr>")
-- map("n", "<leader>ng", "<cmd>Neotree float git_status<cr>")

-- """"""""""""""""""""""""""""""
-- " Undotree remaps
-- """"""""""""""""""""""""""""""
map("n", "<leader>ut", "<cmd>UndotreeToggle<cr>")

-- Basic LSP keybindings for definitions
map("n", "gd", vim.lsp.buf.definition, { desc = "Go to definition" })
map("n", "gr", vim.lsp.buf.references, { desc = "Go to references" })
map("n", "gi", vim.lsp.buf.implementation, { desc = "Go to implementation" })
map("n", "gt", vim.lsp.buf.type_definition, { desc = "Go to type definition" })
map("n", "se", "<cmd>lua vim.diagnostic.open_float()<cr>")
map("n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<cr>")

-- """"""""""""""""""""""""""""""
-- " Obsidian remaps
-- """"""""""""""""""""""""""""""
map("n", "<leader>nn", "<cmd>ObsidianNew<cr>")

-- """"""""""""""""""""""""""""""
-- " Macros for common code that is typed
-- """"""""""""""""""""""""""""""
map("n", "<leader>yy", "i(year, month, day) = (year(current_date), month(current_date), day(current_date)) <esc>")

local function get_visual_selection()
	vim.cmd('noau normal! "vy') -- Yank visual selection into the "v register
	return vim.fn.getreg("v") -- Return the content of the "v register
end

-- Function to run a constant shell command on the visual selection
local function open_github_pr()
	-- Function to get the visual selection

	-- Get the current selection and remove newlines
	local selection = get_visual_selection():gsub("%s+", "")
	local open = "open https://github.com/Affirm/all-the-things/pull/" .. selection

	vim.fn.jobstart(open, { detach = true })
end
map("v", "<leader>gh", open_github_pr)

-- Function to get the current date and format it
local function get_formatted_date()
	local days = { "Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat" }
	local date = os.date("*t") -- Get the current date table
	local formatted_date = string.format("[[%04d-%02d-%02d %s]]", date.year, date.month, date.day, days[date.wday])
	-- Insert the formatted date after the cursor position
	local line, col = unpack(vim.api.nvim_win_get_cursor(0))
	local current_line = vim.api.nvim_get_current_line()
	local new_line = current_line:sub(1, col + 1) .. formatted_date .. current_line:sub(col + 2)
	vim.api.nvim_set_current_line(new_line)
	vim.api.nvim_win_set_cursor(0, { line, #new_line })
end

-- Map the function to <leader> + t
map("n", "<leader>tt", get_formatted_date, { noremap = true, silent = true })
