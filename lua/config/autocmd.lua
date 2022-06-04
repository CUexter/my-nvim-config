vim.cmd([[
  augroup _general_settings
    autocmd!
    autocmd FileType qf,help,man,lspinfo nnoremap <silent> <buffer> q :close<CR> 
    autocmd TextYankPost * silent!lua require('vim.highlight').on_yank({higroup = 'Search', timeout = 200}) 
    autocmd BufWinEnter * :set formatoptions-=cro
    autocmd FileType qf set nobuflisted
  augroup end
  augroup _git
    autocmd!
    autocmd FileType gitcommit setlocal wrap
    autocmd FileType gitcommit setlocal spell
  augroup end
  augroup _markdown
    autocmd!
    autocmd FileType markdown,pandoc setlocal wrap
    autocmd FileType markdown,pandoc setlocal spell
    autocmd FileType markdown,pandoc lua whichkeyMarkdown()
  augroup end
  augroup _auto_resize
    autocmd!
    autocmd VimResized * tabdo wincmd = 
  augroup end
  augroup _alpha
    autocmd!
    autocmd User AlphaReady set showtabline=0 | autocmd BufUnload <buffer> set showtabline=2
  augroup end
  augroup lspsaga_filetypes
    autocmd!
    autocmd FileType LspsagaHover,LspsagaCodeAction,LspsagaRename,LspsagaSignatureHelp,LspsagaFinder,LspsagaDiagnostic nnoremap <buffer><nowait><silent> <Esc> <cmd>close!<cr>
  augroup END
]])

local opts = {
	mode = "n", -- NORMAL mode
	prefix = "<leader>",
	buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
	silent = true, -- use `silent` when creating keymaps
	noremap = true, -- use `noremap` when creating keymaps
	nowait = true, -- use `nowait` when creating keymaps
}
_G.whichkeyMarkdown = function()
	local wk = require("which-key")
	local buf = vim.api.nvim_get_current_buf()
	wk.register({
		m = {
			name = "Markdown",
			p = { "<cmd>MarkdownPreviewToggle<cr>", "Toggle Preview", buffer = buf },
		},
	}, opts)
end
