local M = {}

function M.setup()
	-- local dap = require("dap")
	-- dap.adapters.chrome = {
	-- 	type = "executable",
	-- 	command = "node",
	-- 	args = { os.getenv("HOME") .. "/path/to/vscode-chrome-debug/out/src/chromeDebug.js" }, -- TODO adjust
	-- }
	local di = require("dap-install")

	di.config("chrome", {})
end

return M
