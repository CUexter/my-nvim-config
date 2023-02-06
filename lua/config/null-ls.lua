local lsp_formatting = function(bufnr)
	vim.lsp.buf.format({
		filter = function(client)
			-- apply whatever logic you want (in this example, we'll only use null-ls)
			return client.name == "null-ls"
		end,
		bufnr = bufnr,
	})
end
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
		require("null-ls").builtins.formatting.markdownlint.with({
			extra_filetypes = { "pandoc" },
		}),
		require("null-ls").builtins.formatting.stylelint,
		require("null-ls").builtins.formatting.black,
		require("null-ls").builtins.formatting.isort,
		require("null-ls").builtins.formatting.clang_format,
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
		--[[ require("null-ls").builtins.diagnostics.markdownlint.with({ ]]
		--[[ 	extra_filetypes = { "pandoc" }, ]]
		--[[ }), ]]
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
					lsp_formatting(bufnr)
				end,
			})
		end
	end,
	-- debug = true,
})
