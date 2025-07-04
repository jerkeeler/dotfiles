return {
	"williamboman/mason.nvim",
	dependencies = {
		"williamboman/mason-lspconfig.nvim",
		"WhoIsSethDaniel/mason-tool-installer.nvim",
	},
	config = function()
		require("mason").setup()

		require("mason-lspconfig").setup({
			automatic_enable = true,
			ensure_installed = {
				"cssls",
				-- "eslint",
				"html",
				"jsonls",
				"ts_ls",
				"pyright",
				"tailwindcss",
				"astro",
				"svelte",
				"ruby_lsp",
				"rust_analyzer",
				"gopls",
			},
		})

		require("mason-tool-installer").setup({
			ensure_installed = {
				"stylua",
				"prettier",
				"isort", -- python formatter
				"black", -- python formatter
				"rubocop",
				-- "pylint",
				-- "eslint_d",
			},
		})
	end,
}
