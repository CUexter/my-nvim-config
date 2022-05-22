local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
	PACKER_BOOTSTRAP = fn.system({
		"git",
		"clone",
		"--depth",
		"1",
		"https://github.com/wbthomason/packer.nvim",
		install_path,
	})
	print("Installing packer close and reopen Neovim...")
	vim.cmd([[packadd packer.nvim]])
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]])

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
	return
end

-- Have packer use a popup window
packer.init({
	display = {
		open_fn = function()
			return require("packer.util").float({ border = "rounded" })
		end,
	},
})

-- Install your plugins here
return packer.startup(function(use)
	-- My plugins here
	use("wbthomason/packer.nvim") -- Have packer manage itself
	use("nvim-lua/popup.nvim") -- An implementation of the Popup API from vim in Neovim
	use("nvim-lua/plenary.nvim") -- Useful lua functions used ny lots of plugins

	-- Colorschemes
	-- use "rebelot/kanagawa.nvim"
	-- use({
	--   "catppuccin/nvim",
	--   as = "catppuccin"
	-- })
	-- use "tiagovla/tokyodark.nvim"
	use("marko-cerovac/material.nvim")

	-- use "rowantran/vim-bspwm-navigator" -- Window control

	use({
		"norcalli/nvim-colorizer.lua",
		config = function()
			require("colorizer").setup()
		end,
	})

	-- use "hrsh7th/nvim-cmp" -- The completion plugin
	-- use "hrsh7th/cmp-buffer" -- buffer completions
	-- use "hrsh7th/cmp-path" -- path completions
	-- use "hrsh7th/cmp-cmdline" -- cmdline completions
	-- use "saadparwaiz1/cmp_luasnip" -- snippet completions
	--
	-- use "L3MON4D3/LuaSnip" --snippet engine
	-- use "rafamadriz/friendly-snippets" -- a bunch of snippets to use

	-- Commenter
	use({
		"numToStr/Comment.nvim",
		config = function()
			require("Comment").setup()
		end,
	})

	use({ "ms-jpq/coq_nvim", branch = "coq" })
	use({ "ms-jpq/coq.artifacts", branch = "artifacts" })
	use({ "ms-jpq/coq.thirdparty", branch = "3p" })

	use("neovim/nvim-lspconfig") --enable LSP
	use("williamboman/nvim-lsp-installer") -- simple to use language server installer
	use("jose-elias-alvarez/null-ls.nvim")

	-- Telescope
	use("nvim-telescope/telescope.nvim")
	use("nvim-telescope/telescope-media-files.nvim")

	-- Treesitter
	use({
		"nvim-treesitter/nvim-treesitter",
		run = ":TSUpdate",
	})
	use("p00f/nvim-ts-rainbow")
	-- use "nvim-treesitter/playground"

	-- which key
	use("folke/which-key.nvim")
	use("windwp/nvim-autopairs")

	-- bufferline
	use({ "akinsho/bufferline.nvim", tag = "v2.*", requires = "kyazdani42/nvim-web-devicons" })

	use({ "nvim-telescope/telescope-file-browser.nvim" })

	-- use {"ms-jpq/chadtree", branch = "chad", run = "python3 -m chadtree deps"}

	use("moll/vim-bbye")
	use("lukas-reineke/indent-blankline.nvim")
	use("goolord/alpha-nvim")
	use("nvim-lualine/lualine.nvim")

	use("kyazdani42/nvim-tree.lua")

	use({
		"lewis6991/gitsigns.nvim",
		-- tag = 'release' -- To use the latest release
	})

	use({
		"folke/trouble.nvim",
		requires = "kyazdani42/nvim-web-devicons",
		config = function()
			require("trouble").setup({
				-- your configuration comes here
				-- or leave it empty to use the default settings
				-- refer to the configuration section below
			})
		end,
	})

	use({ "TimUntersberger/neogit", requires = "nvim-lua/plenary.nvim" })
	use("akinsho/toggleterm.nvim")

	use("JoosepAlviste/nvim-ts-context-commentstring")

	use({
		"phaazon/hop.nvim",
		branch = "v1", -- optional but strongly recommended
		config = function()
			-- you can configure Hop the way you like here; see :h hop-config
			require("hop").setup()
		end,
	})

	use({
		"echasnovski/mini.nvim",
		config = function()
			require("mini.surround").setup()
		end,
	})

	use({ "ahmedkhalf/project.nvim" })

	use({
		"lewis6991/impatient.nvim",
		config = function()
			require("impatient").enable_profile()
		end,
	})

	use("windwp/nvim-ts-autotag")

	-- Automatically set up your configuration after cloning packer.nvim
	-- Put this at the end after all plugins
	if PACKER_BOOTSTRAP then
		require("packer").sync()
	end
end)