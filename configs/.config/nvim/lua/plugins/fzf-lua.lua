return {
	"ibhagwan/fzf-lua",
	config = function()
		local whitelist = require("config.whitelist")

		-- Function to get fzf-lua files options based on current whitelist
		local function get_files_opts()
			local wl = whitelist.get_whitelist()
			local root = whitelist.get_project_root()

			if not wl or #wl == 0 then
				return {} -- No whitelist, use defaults
			end

			local paths = whitelist.get_fd_paths(wl, root)

			return {
				cwd = root,
				cmd = "fd --type f --hidden --follow --exclude .git . " .. table.concat(paths, " "),
			}
		end

		-- Function to get fzf-lua grep options based on current whitelist
		local function get_grep_opts()
			local wl = whitelist.get_whitelist()
			local root = whitelist.get_project_root()

			if not wl or #wl == 0 then
				return {
					rg_opts = "--column --line-number --no-heading --color=always --smart-case --hidden --glob '!.git/' -e",
				}
			end

			local globs = whitelist.get_rg_globs(wl)

			return {
				cwd = root,
				rg_opts = "--column --line-number --no-heading --color=always --smart-case " .. globs .. " -e",
			}
		end

		-- Store these functions globally for use in keymaps
		_G.fzf_files_opts = get_files_opts
		_G.fzf_grep_opts = get_grep_opts

		-- Keybind to force-close stuck fzf-lua windows
		vim.keymap.set("n", "<leader>fq", function()
			require("fzf-lua").hide()
			-- Also close any lingering fzf terminal buffers
			for _, win in ipairs(vim.api.nvim_list_wins()) do
				local buf = vim.api.nvim_win_get_buf(win)
				local bufname = vim.api.nvim_buf_get_name(buf)
				if bufname:match("fzf://") or bufname:match("term://.*fzf") then
					vim.api.nvim_win_close(win, true)
				end
			end
		end, { desc = "Close fzf-lua windows" })

		require("fzf-lua").setup({
			winopts = {
				height = 0.85,
				width = 0.80,
				preview = {
					layout = "flex",
				},
			},
			keymap = {
				builtin = {
					["<C-/>"] = "toggle-preview",
					["<C-p>"] = "toggle-preview-cw",
					["<C-f>"] = "focus-preview",
				},
			},
			grep = {
				rg_glob = true,
			},
		})
	end,
}
