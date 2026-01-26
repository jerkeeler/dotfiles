return {
	"neovim/nvim-lspconfig",
	lazy = false,
	priority = 100,
	dependencies = {
		"hrsh7th/cmp-nvim-lsp",
		{ "folke/neodev.nvim", opts = {} },
		"mason-org/mason-lspconfig.nvim",
	},
	config = function()
		local capabilities = require("cmp_nvim_lsp").default_capabilities()

		-- Format on save when LSP supports it
		vim.api.nvim_create_autocmd("LspAttach", {
			callback = function(args)
				local client = vim.lsp.get_client_by_id(args.data.client_id)
				if client and client.server_capabilities.documentFormattingProvider then
					vim.api.nvim_create_autocmd("BufWritePre", {
						group = vim.api.nvim_create_augroup("Format", { clear = true }),
						buffer = args.buf,
						callback = function()
							vim.lsp.buf.format()
						end,
					})
				end
			end,
		})

		-- Default config for all servers
		vim.lsp.config("*", {
			capabilities = capabilities,
		})

		-- basedpyright with indexing optimizations
		vim.lsp.config("basedpyright", {
			capabilities = capabilities,
			flags = {
				debounce_text_changes = 150,
			},
			settings = {
				basedpyright = {
					analysis = {
						typeCheckingMode = "basic",
						autoSearchPaths = true,
						useLibraryCodeForTypes = true,
						diagnosticMode = "openFilesOnly",
					},
				},
			},
		})

		-- Suppress basedpyright's slow enumeration warning for large projects
		local orig_notify = vim.notify
		vim.notify = function(msg, level, opts)
			if msg and msg:match("Enumeration of workspace source files is taking longer") then
				return
			end
			return orig_notify(msg, level, opts)
		end

		-- LSP progress indicator
		vim.api.nvim_create_autocmd("LspProgress", {
			callback = function(ev)
				local client = vim.lsp.get_client_by_id(ev.data.client_id)
				local value = ev.data.params.value
				if client and value.kind == "end" then
					vim.notify(string.format("[%s] Ready", client.name), vim.log.levels.INFO)
				end
			end,
		})
	end,
}
