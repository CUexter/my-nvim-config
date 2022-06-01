local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
require("null-ls").setup({
	sources = {
		-- code action
		require("null-ls").builtins.code_actions.shellcheck,
		require("null-ls").builtins.code_actions.eslint_d.with({
			cwd = function()
				return vim.loop.cwd()
			end,
		}),
		-- require("null-ls").builtins.code_actions.refactoring,
		-- formatting
		require("null-ls").builtins.formatting.stylua,
		require("null-ls").builtins.formatting.prettier,
		require("null-ls").builtins.formatting.shfmt,
		require("null-ls").builtins.formatting.stylelint,
		require("null-ls").builtins.formatting.eslint_d.with({
			cwd = function()
				return vim.loop.cwd()
			end,
		}),

		-- diagnostics
		require("null-ls").builtins.diagnostics.eslint_d.with({
			cwd = function()
				return vim.loop.cwd()
			end,
		}),
		require("null-ls").builtins.diagnostics.actionlint,
		-- completion
		-- require("null-ls").builtins.completion.spell,
	},
	on_attach = function(client, bufnr)
		if client.supports_method("textDocument/formatting") then
			vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
			vim.api.nvim_create_autocmd("BufWritePre", {
				group = augroup,
				buffer = bufnr,
				callback = function()
					-- on 0.8, you should use vim.lsp.buf.format({ bufnr = bufnr }) instead
					vim.lsp.buf.formatting_sync()
				end,
			})
		end
	end,
	-- debug = true,
})
