vim.g.firenvim_config = {
	globalSettings = { alt = "all" },
	localSettings = {
		[".*"] = {
			cmdline = "neovim",
			content = "text",
			priority = 0,
			selector = "textarea",
			takeover = "always",
		},
	},
}

if vim.g.started_by_firenvim then
	vim.opt.guifont = { "JetbrainsMono Nerd Font Mono", "h12" }
	vim.opt.showtabline = 0
	vim.opt.showmode = false
	vim.opt.laststatus = 0
	vim.opt.showcmd = false
	vim.opt.ruler = false
	vim.opt.cmdheight = 0
end
