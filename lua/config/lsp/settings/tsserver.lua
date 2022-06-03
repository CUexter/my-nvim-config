local status_ok, ts_utils = pcall(require, "nvim-lsp-ts-utils")
if not status_ok then
	return
end

local M = {
	init_options = ts_utils.init_options,
	on_attach = function(client, bufnr)
		ts_utils.setup({
			debug = false,
			disable_commands = false,
			enable_import_on_completion = false,

			-- import all
			import_all_timeout = 5000, -- ms
			-- lower numbers = higher priority
			import_all_priorities = {
				same_file = 1, -- add to existing import statement
				local_files = 2, -- git files or files with relative path markers
				buffer_content = 3, -- loaded buffer content
				buffers = 4, -- loaded buffer names
			},
			import_all_scan_buffers = 100,
			import_all_select_source = false,
			-- if false will avoid organizing imports
			always_organize_imports = true,

			-- filter diagnostics
			filter_out_diagnostics_by_severity = {},
			filter_out_diagnostics_by_code = {},

			-- inlay hints
			auto_inlay_hints = true,
			inlay_hints_highlight = "Comment",
			inlay_hints_priority = 200, -- priority of the hint extmarks
			inlay_hints_throttle = 150, -- throttle the inlay hint request
			inlay_hints_format = { -- format options for individual hint kind
				Type = {},
				Parameter = {},
				Enum = {},
				-- Example format customization for `Type` kind:
				-- Type = {
				--     highlight = "Comment",
				--     text = function(text)
				--         return "->" .. text:sub(2)
				--     end,
				-- },
			},

			-- update imports on file move
			update_imports_on_move = true,
			require_confirmation_on_move = true,
			watch_dir = nil,
		})

		-- required to fix code action ranges and filter diagnostics
		ts_utils.setup_client(client)

		-- no default maps, so you may want to define some here
		local ok, which_key = pcall(require, "which-key")
		if not ok then
			return
		end

		-- local opts = { silent = true }
		-- vim.api.nvim_buf_set_keymap(bufnr, "n", "gs", ":TSLspOrganize<CR>", opts)
		-- vim.api.nvim_buf_set_keymap(bufnr, "n", "gr", ":TSLspRenameFile<CR>", opts)
		-- vim.api.nvim_buf_set_keymap(bufnr, "n", "gi", ":TSLspImportAll<CR>", opts)

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
				name = "Typescript",
				r = { "<cmd>TSLspRenameFile<cr>", "Rename" },
				i = { "<cmd>TSLspImportAll<cr>", "Import all" },
				I = { "<cmd>TSLspImportCurrent<cr>", "Import" },
				o = { "<cmd>TSLspOrganize<cr>", "Organize imports" },
			},
		}
		which_key.register(n_mappings, whichkey_nopts)

		require("config.lsp.handlers").on_attach(client, bufnr)
	end,
}

return M
