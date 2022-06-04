local snip_status_ok, luasnip = pcall(require, "luasnip")
if not snip_status_ok then
	return
end

local snippets_folder = vim.fn.stdpath("config") .. "/lua/config/snip/snippets"

require("luasnip/loaders/from_vscode").lazy_load()
require("luasnip.loaders.from_snipmate").lazy_load()
require("luasnip.loaders.from_lua").lazy_load({ path = snippets_folder })

vim.cmd([[command! LuaSnipEdit :lua require("luasnip.loaders.from_lua").edit_snippet_files()]])
