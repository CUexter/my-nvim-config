local status_ok, lsp_installer = pcall(require, "nvim-lsp-installer")
if not status_ok then
	print("nvim-lsp-installer not working")
	return
end

-- Register a handler that will be called for all installed servers.
-- Alternatively, you may also register handlers on specific server instances instead (see example below).
lsp_installer.on_server_ready(function(server)
	local opts = {
		on_attach = require("config.lsp.handlers").on_attach,
		capabilities = require("config.lsp.handlers").capabilities,
	}

	if server.name == "jsonls" then
		local jsonls_opts = require("config.lsp.settings.jsonls")
		opts = vim.tbl_deep_extend("force", jsonls_opts, opts)
	end

	if server.name == "sumneko_lua" then
		local sumneko_opts = require("config.lsp.settings.sumneko_lua")
		opts = vim.tbl_deep_extend("force", sumneko_opts, opts)
	end

	if server.name == "pyright" then
		local pyright_opts = require("config.lsp.settings.pyright")
		opts = vim.tbl_deep_extend("force", pyright_opts, opts)
	end

	if server.name == "tsserver" then
		local ts_opts = require("config.lsp.settings.tsserver")
		opts = vim.tbl_deep_extend("keep", ts_opts, opts)
	end

	if server.name == "rust_analyzer" then
		require("rust-tools").setup(require("config.rust_tools"))
		return
	end

	if server.name == "clangd" then
		require("clangd_extensions").setup({
			server = {
				on_attach = function(client, bufnr)
					local which_key = require("which-key")

					local whichkey_nopts = {
						mode = "n", -- NORMAL mode
						prefix = "<leader>",
						buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
						silent = true, -- use `silent` when creating keymaps
						noremap = true, -- use `noremap` when creating keymaps
						nowait = true, -- use `nowait` when creating keymaps
					}

					local n_mappings = {
						m = {
							name = "Clangd",
							h = { "<cmd>ClangdToggleInlayHints<cr>", "Toggle Inlay Hints" },
							t = { "<cmd>ClangdTypeHierarchy<cr>", "Type Hierarchy" },
							s = { "<cmd>ClangdSymbolInfo<cr>", "Symbol Info" },
							m = { "<cmd>ClangdMemoryUsage<cr>", "Memory Usage" },
						},
					}

					which_key.register(n_mappings, whichkey_nopts)

					local v_opts = {
						mode = "v", -- Visual mode
						prefix = "<leader>",
						buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
						silent = true, -- use `silent` when creating keymaps
						noremap = true, -- use `noremap` when creating keymaps
						nowait = true, -- use `nowait` when creating keymaps
					}

					local v_mappings = {
						m = {
							name = "Clangd",
							a = { "<cmd>ClangdAST<cr>", "AST" },
						},
					}
					which_key.register(v_mappings, v_opts)
					opts.on_attach(client, bufnr)
				end,
				capabilities = opts.capabilities,
			},
		})
		return
	end

	-- This setup() function is exactly the same as lspconfig's setup function.
	-- Refer to https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
	server:setup(opts)
end)
