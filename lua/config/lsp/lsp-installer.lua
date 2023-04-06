require("mason").setup()
require("mason-lspconfig").setup()
local lspconfig = require("lspconfig")
local opts = {
	on_attach = require("config.lsp.handlers").on_attach,
	capabilities = require("config.lsp.handlers").capabilities,
}

-- Register a handler that will be called for all installed servers.
-- Alternatively, you may also register handlers on specific server instances instead (see example below).
require("mason-lspconfig").setup_handlers({
	function(server_name)
		require("lspconfig")[server_name].setup(opts)
	end,

	["clangd"] = function()
		opts.capabilities.offsetEncoding = "utf-8"
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
	end,
	["jsonls"] = function()
		local jsonls_opts = require("config.lsp.settings.jsonls")
		opts = vim.tbl_deep_extend("force", jsonls_opts, opts)
		lspconfig.jsonls.setup(opts)
	end,
	["lua_ls"] = function()
		local sumneko_opts = require("config.lsp.settings.sumneko_lua")
		opts = vim.tbl_deep_extend("force", sumneko_opts, opts)
		lspconfig.lua_ls.setup(opts)
	end,
	["tsserver"] = function()
		local ts_opts = require("config.lsp.settings.tsserver")
		opts = vim.tbl_deep_extend("force", ts_opts, opts)
		lspconfig.tsserver.setup(opts)
	end,
	["pyright"] = function()
		local pyright_opts = require("config.lsp.settings.pyright")
		opts = vim.tbl_deep_extend("force", pyright_opts, opts)
		lspconfig.pyright.setup(opts)
	end,
	["rust_analyzer"] = function()
		require("rust-tools").setup(require("config.rust_tools"))
	end,
})
