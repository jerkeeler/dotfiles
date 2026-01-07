return {
	"nvim-tree/nvim-tree.lua",
	version = "*",
	lazy = false,
	dependencies = {
		"nvim-tree/nvim-web-devicons",
	},
	config = function()
		local whitelist = require("config.whitelist")

		-- Custom filter function for nvim-tree
		-- Returns true for items that should be HIDDEN
		local function custom_filter(absolute_path)
			-- Check if whitelist bypass is enabled
			if vim.g.nvim_tree_bypass_whitelist then
				return false
			end

			local wl = whitelist.get_whitelist()
			local root = whitelist.get_project_root()

			-- If no whitelist is set, don't filter anything
			if not wl or #wl == 0 then
				return false
			end

			-- Always show the project root itself
			if absolute_path == root then
				return false
			end

			-- Handle case where path doesn't start with root
			if not absolute_path:find(root, 1, true) then
				return false
			end

			-- Get the relative path from root
			local rel_path = absolute_path:sub(#root + 2) -- +2 to skip the trailing /

			-- If empty rel_path, show it
			if not rel_path or rel_path == "" then
				return false
			end

			-- Check if this is a top-level item (no / in relative path)
			if not rel_path:find("/") then
				-- Check if it's a file (not a directory) - always show top-level files
				local stat = vim.loop.fs_stat(absolute_path)
				if stat and stat.type == "file" then
					return false -- Show top-level files
				end

				-- It's a directory - check if it's whitelisted
				for _, folder in ipairs(wl) do
					if rel_path == folder then
						return false -- It's a whitelisted folder, show it
					end
				end
				-- Not in whitelist, hide it
				return true
			end

			-- For nested items, check if they're within a whitelisted folder
			return not whitelist.is_whitelisted(absolute_path, wl, root)
		end

		require("nvim-tree").setup({
			filters = {
				custom = custom_filter,
			},
			sync_root_with_cwd = true,
			respect_buf_cwd = true,
			update_focused_file = {
				enable = true,
				update_root = false,
			},
		})

		-- Command to toggle whitelist bypass
		vim.api.nvim_create_user_command("NvimTreeToggleWhitelist", function()
			vim.g.nvim_tree_bypass_whitelist = not vim.g.nvim_tree_bypass_whitelist
			local status = vim.g.nvim_tree_bypass_whitelist and "disabled" or "enabled"
			vim.notify("Whitelist filter " .. status, vim.log.levels.INFO)
			-- Refresh the tree
			require("nvim-tree.api").tree.reload()
		end, {})
	end,
}
