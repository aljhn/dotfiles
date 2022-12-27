local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "--single-branch",
    "https://github.com/folke/lazy.nvim.git",
    lazypath,
  })
end
vim.opt.runtimepath:prepend(lazypath)

vim.g.mapleader = " "

vim.opt.nu = true
vim.opt.relativenumber = true

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.smartindent = true

vim.opt.wrap = false
vim.opt.scrolloff = 8

vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.termguicolors = true

vim.opt.updatetime = 50

vim.opt.signcolumn = "yes"

local plugins = {
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        config = function()
			require("nvim-treesitter.configs").setup {
                ensure_installed = {"c", "cpp", "lua", "python", "javascript"},
				highlight = {
					enable = true,
                    additional_vim_regex_highlighting = false
				}
			}
		end
	},
    "nvim-tree/nvim-web-devicons",
    {
        "nvim-telescope/telescope.nvim",
        tag = "0.1.0",
        dependencies = {
            "nvim-lua/plenary.nvim"
        },
        config = function()
            local builtin = require("telescope.builtin")
            vim.keymap.set("n", "<leader>ff", builtin.find_files, {})
            vim.keymap.set("n", "<leader>fg", builtin.live_grep, {})
            vim.keymap.set("n", "<leader>fb", builtin.buffers, {})
            vim.keymap.set("n", "<leader>fh", builtin.help_tags, {})
        end
    },
    {
       "VonHeikemen/lsp-zero.nvim",
        dependencies = {
            -- LSP Support
           "neovim/nvim-lspconfig",
           "williamboman/mason.nvim",
           "williamboman/mason-lspconfig.nvim",
           -- Autocompletion
           "hrsh7th/nvim-cmp",
           "hrsh7th/cmp-buffer",
           "hrsh7th/cmp-path",
           "saadparwaiz1/cmp_luasnip",
           "hrsh7th/cmp-nvim-lsp",
           "hrsh7th/cmp-nvim-lua",
           -- Snippets
           "L3MON4D3/LuaSnip",
           "rafamadriz/friendly-snippets"
        },
        config = function()
            local lsp = require("lsp-zero")
            lsp.preset("recommended")
            lsp.nvim_workspace()
            lsp.setup()
        end
    },
    {
        "nvim-lualine/lualine.nvim",
        config = function()
            require("lualine").setup ()
        end
    },
	{
		"navarasu/onedark.nvim",
		lazy = true,
		config = function()
			require("onedark").setup {
				style = "dark",
				transparent = true
			}
			--require("onedark").load()
		end
	}
}
local opts = {}
require("lazy").setup(plugins, opts)


vim.cmd[[colorscheme onedark]]
