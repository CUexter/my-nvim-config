local status_ok, alpha = pcall(require, "alpha")
if not status_ok then
	return
end

local dashboard = require("alpha.themes.dashboard")
dashboard.section.header.val = {
	"                             ███████████               ",
	"                          ███████████████████               ",
	"                         ███████████████████                ",
	"                         ██████████████████████░            ",
	"           ██░           █████████████████████████░░        ",
	"            ░██░        ███████████████████████████░       ",
	"               ░██░    █████████████████████████████████░   ",
	"                 ████████████████████████████████████████░  ",
	"                    ███████████████████████████████████░    ",
	"   █████     ███  ░█████████████████████████░░░             ",
	"    █████     █    ███░░██████████████████████░             ",
	"    █  ████░  █    ███   ░████████████████████████░         ",
	"    █   █████ █    ███████░  ██████████████████████░        ",
	"    █        ██    ███░         ████████████████████        ",
	"   ███       ██  ░░████████░     ░███████████████████       ",
	"                                   ██████████████████       ",
	"                     █████████░   ░███████████████████      ",
	"                       ███   ████  ░██░  ████████████░      ",
	"                       ███   ░███    ██░  ████████████      ",
	"                       ███░████░     ░██░  ██████████░      ",
	"                       ███ ███░       ░██░ ██ ░███████  ",
	"                       ███   ████      ░███    ██████░  ",
	"                       ███    ████░     ░█      ░████░  ",
	"                                                  ███   ",
	"                                                   ░█░  ",
}
dashboard.section.buttons.val = {
	dashboard.button("f", "  Find file", ":Telescope find_files <CR>"),
	dashboard.button("e", "  New file", ":ene <BAR> startinsert <CR>"),
	dashboard.button("p", "  Find project", ":Telescope projects <CR>"),
	dashboard.button("r", "  Recently used files", "<cmd>Telescope oldfiles<cr>"),
	dashboard.button("t", "  Find text", ":Telescope live_grep <CR>"),
	dashboard.button("i", "  Configuration", ":e ~/.config/nvim/init.lua <CR>"),
	dashboard.button("q", "  Quit Neovim", ":qa<CR>"),
}

vim.cmd("highlight NERV guifg=#DA261A")
dashboard.section.footer.opts.hl = "Type"
dashboard.section.header.opts.hl = "NERV"
dashboard.section.buttons.opts.hl = "Keyword"

local function footer()
	return "God's in his heaven, All's right with the world."
end

dashboard.section.footer.val = footer()

dashboard.opts.opts.noautocmd = true
-- vim.cmd([[autocmd User AlphaReady echo 'ready']])
alpha.setup(dashboard.opts)
