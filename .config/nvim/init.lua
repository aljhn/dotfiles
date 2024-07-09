local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(lazypath) then
    local lazyrepo = "https://github.com/folke/lazy.nvim.git"
    local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
end
vim.opt.rtp:prepend(lazypath)

vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.g.have_nerd_font = true

vim.keymap.set({ "n", "v" }, "<Space>", "<Nop>", { silent = true })

vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.breakindent = true
vim.opt.autoindent = true
vim.opt.smartindent = true
vim.opt.backspace = "indent,eol,start"

vim.opt.wrap = false
vim.opt.scrolloff = 8

vim.opt.cursorline = true

vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.termguicolors = true

vim.opt.updatetime = 250
vim.opt.timeoutlen = 300

vim.opt.signcolumn = "yes"

vim.opt.clipboard = "unnamedplus"

vim.opt.mouse = "a"

require("lazy").setup({
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        config = function () 
            require("nvim-treesitter.configs").setup({
                ensure_installed = { "lua", "python", "c", "cpp", "haskell" },
                sync_install = false,
                highlight = {
                    enable = true,
                    additional_vim_regex_highlighting = false,
                },
                indent = {
                    enable = true
                },
            })
        end
    },
    {
        "numToStr/Comment.nvim",
        opts = {}
    },
    {
        "lewis6991/gitsigns.nvim",
        opts = {}
    },
    {
        "lukas-reineke/indent-blankline.nvim",
        main = "ibl",
        opts = {
            indent = {
                char = "┊",
            }
        }
    },
    {
        "nvim-lualine/lualine.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        opts = {
            options = {
                component_separators = "|",
                section_separators = "",
            }
        }
    },
    {
		"rebelot/kanagawa.nvim",
		lazy = false,
		priority = 1000,
        opts = { transparent = true }
    }
})

vim.cmd([[colorscheme kanagawa]])
