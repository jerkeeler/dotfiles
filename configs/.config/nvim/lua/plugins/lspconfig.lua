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

		-- Default config for all servers
		vim.lsp.config("*", {
			capabilities = capabilities,
		})

		-- basedpyright with indexing optimizations
		vim.lsp.config("basedpyright", {
			capabilities = capabilities,
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
