-- Custom fast tmux navigation (no plugin dependency)
return {
	dir = "~/.config/nvim/lua/plugins", -- dummy dir, no actual plugin
	name = "tmux-nav",
	virtual = true,
	config = function()
		local function is_vim_edge(direction)
			local win = vim.api.nvim_get_current_win()
			local pos = vim.api.nvim_win_get_position(win)
			local height = vim.api.nvim_win_get_height(win)
			local width = vim.api.nvim_win_get_width(win)

			if direction == "h" then
				return pos[2] == 0
			elseif direction == "l" then
				local total_width = vim.o.columns
				return pos[2] + width >= total_width - 1
			elseif direction == "k" then
				return pos[1] == 0
			elseif direction == "j" then
				local total_height = vim.o.lines - vim.o.cmdheight - 1
				return pos[1] + height >= total_height
			end
			return false
		end

		local tmux_directions = { h = "L", j = "D", k = "U", l = "R" }

		local function navigate(direction)
			if is_vim_edge(direction) then
				-- Use jobstart for async, non-blocking tmux command
				vim.fn.jobstart({ "tmux", "selectp", "-" .. tmux_directions[direction] }, { detach = true })
			else
				vim.cmd("wincmd " .. direction)
			end
		end

		vim.keymap.set("n", "<C-h>", function() navigate("h") end, { silent = true })
		vim.keymap.set("n", "<C-j>", function() navigate("j") end, { silent = true })
		vim.keymap.set("n", "<C-k>", function() navigate("k") end, { silent = true })
		vim.keymap.set("n", "<C-l>", function() navigate("l") end, { silent = true })
	end,
}
