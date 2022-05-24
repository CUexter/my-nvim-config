-- Find more schemas here: https://www.schemastore.org/json/
local schemas = require("schemastore").json.schemas()

local opts = {
	settings = {
		json = {
			schemas = schemas,
			validate = { enable = true },
		},
	},
	setup = {
		commands = {
			Format = {
				function()
					vim.lsp.buf.range_formatting({}, { 0, 0 }, { vim.fn.line("$"), 0 })
				end,
			},
		},
	},
}

return opts
