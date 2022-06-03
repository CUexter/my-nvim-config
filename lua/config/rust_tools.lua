local extension = vim.fn.stdpath("data") .. "/dapinstall/codelldb/extension/"
local codelldb_path = extension .. "adaptor/codelldb"
local liblldb_path = extension .. "lldb/lib/liblldb.so"

local opts = {
	server = {
		on_attach = function(client, bufnr)
			-- no default maps, so you may want to define some here
			local ok, which_key = pcall(require, "which-key")
			if not ok then
				return
			end

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
					name = "Rust",
					a = { "<cmd>RustHoverActions<cr>", "Actions" },
					c = { "<cmd>RustOpenCargo<cr>", "Open Cargo" },
					d = { "<cmd>RustDebuggables<cr>", "Debug" },
					D = { "<cmd>RustOpenExternalDocs<cr>", "Docs" },
					e = { "<cmd>RustExpandMarco<cr>", "Expand Macro" },
					-- g = { "<cmd>RustViewCrateGraph<cr>", "Crate Graph" },
					r = { "<cmd>RustRunnables<cr>", "Run" },
					p = { "<cmd>RustParentModule<cr>", "Go to Parent Module" },
					R = { "<cmd>RustReloadWorkspace<cr>", "Reload Workspace" },
					j = { "<cmd>RustJoinLines<cr>", "Join Lines" },
					J = { "<cmd>RustMoveItemDown<cr>", "Move Item Down" },
					K = { "<cmd>RustMoveItemUp<cr>", "Move Item Up" },
					-- s = { "<cmd>RustSSR<cr>", "Structural Search Replace" },
					h = { "<cmd>RustToggleInlayHints<cr>", "Toggle Inlay Hints" },
				},
			}

			which_key.register(n_mappings, whichkey_nopts)

			local v_opts = {
				mode = "v", -- NORMAL mode
				prefix = "<leader>",
				buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
				silent = true, -- use `silent` when creating keymaps
				noremap = true, -- use `noremap` when creating keymaps
				nowait = true, -- use `nowait` when creating keymaps
			}

			local v_mappings = {
				m = {
					name = "Rust",
					a = { "<cmd>RustHoverRange<cr>", "Actions" },
				},
			}
			which_key.register(v_mappings, v_opts)

			require("config.lsp.handlers").on_attach(client, bufnr)
		end,
		capabilities = require("config.lsp.handlers").capabilities,
	},
	dap = {
		adapter = require("rust-tools.dap").get_codelldb_adapter(codelldb_path, liblldb_path),
	},
}
return opts
