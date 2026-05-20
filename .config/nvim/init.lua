-- Globals
vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.g.have_nerd_font = true


-- Options
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.cursorline = true
vim.opt.wrap = false
vim.opt.scrolloff = 8
vim.opt.sidescrolloff = 8

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.breakindent = true
vim.opt.autoindent = true
vim.opt.smartindent = true

vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.list = true
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }

vim.opt.signcolumn = "yes"
vim.opt.showmatch = true
vim.opt.showmode = false
vim.opt.cmdheight = 1

vim.opt.mouse = "a"
vim.opt.clipboard = "unnamedplus"
vim.opt.termguicolors = true
vim.opt.errorbells = false
vim.opt.backspace = "indent,eol,start"
vim.opt.encoding = "utf-8"

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.writebackup = false
vim.opt.updatetime = 300
vim.opt.timeoutlen = 500
vim.opt.ttimeoutlen = 0
vim.opt.autoread = true
vim.opt.autowrite = false

vim.opt.completeopt = "menu,menuone,noselect,popup"
vim.opt.autocomplete = true

-- vim.api.nvim_create_autocmd("TextYankPost", {
--     callback = function()
--         vim.highlight.on_yank()
--     end,
-- })


-- Keymaps
vim.keymap.set({ "n", "v" }, "<Space>", "<Nop>", { silent = true })

vim.keymap.set("n", "n", "nzz")
vim.keymap.set("n", "N", "Nzz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "G", "Gzz")

vim.keymap.set("v", "<", "<gv", { desc = "Indent left and reselect" })
vim.keymap.set("v", ">", ">gv", { desc = "Indent right and reselect" })

vim.keymap.set("n", "<leader>F", vim.lsp.buf.format, { desc = "[F]ormat File" })

vim.keymap.set("n", "<leader>vpu", vim.pack.update, { desc = "[V]im [P]ack [U]pdate" })

vim.keymap.set("n", "<leader>ff", "<cmd>FzfLua files<CR>")
vim.keymap.set("n", "<leader>fg", "<cmd>FzfLua live_grep<CR>")


-- Plugins
require("vim._core.ui2").enable({})

vim.pack.add({
    { src = "https://github.com/rebelot/kanagawa.nvim" },
    { src = "https://github.com/neovim/nvim-lspconfig" },
    { src = "https://github.com/folke/which-key.nvim" },
    { src = "https://github.com/nvim-treesitter/nvim-treesitter" },
    { src = "https://github.com/nvim-tree/nvim-web-devicons" },
    { src = "https://github.com/ibhagwan/fzf-lua" },
    { src = "https://github.com/lewis6991/gitsigns.nvim" },
    { src = "https://github.com/nvim-lualine/lualine.nvim" },
    { src = "https://github.com/saghen/blink.indent" },
    { src = "https://github.com/windwp/nvim-autopairs" },
    { src = "https://github.com/windwp/nvim-ts-autotag" },
})

require("kanagawa").setup({
    transparent = true,
})
vim.cmd.colorscheme("kanagawa")

require("fzf-lua").setup({})

require("lualine").setup({
    options = {
        component_separators = "|",
        section_separators = "",
        theme = "auto",
    },
})

require("blink.indent").setup({
    static = {
        enabled = true,
        char = "┊",
        highlights = { "BlinkIndent" },
    },
    scope = {
        enabled = true,
        char = "┊",
        highlights = {
            "BlinkIndentOrange",
            "BlinkIndentViolet",
            "BlinkIndentBlue",
            "BlinkIndentRed",
            "BlinkIndentCyan",
            "BlinkIndentYellow",
            "BlinkIndentGreen",
        },
    },
    underline = {
        enabled = false,
    },
})

local ts_parsers = {
    "lua",
    "bash",
    "fish",
    "gitignore",
    "markdown",
    "toml",
    "yaml",
    "json",
    "xml",
    "dockerfile",
    "python",
    "c",
    "cpp",
    "cmake",
    "make",
    "html",
    "css",
    "javascript",
    "typescript",
    "svelte",
    "haskell",
    "rust",
    "sql",
}

require("nvim-treesitter.install").install(ts_parsers)

vim.api.nvim_create_autocmd("PackChanged", {
    callback = function(ev)
        local name, kind = ev.data.spec.name, ev.data.kind
        if name == "nvim-treesitter" and kind == "update" then
            if not ev.data.active then
                vim.cmd.packadd("nvim-treesitter")
            end
            vim.cmd("TSUpdate")
        end
    end,
})

vim.api.nvim_create_autocmd("FileType", {
    callback = function(args)
        local filetype = args.match
        local lang = vim.treesitter.language.get_lang(filetype)
        if lang and vim.treesitter.language.add(lang) then
            vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
            vim.treesitter.start()
        end
    end,
})

require("nvim-autopairs").setup({})
require("nvim-ts-autotag").setup({})


-- LSP
vim.lsp.config("lua_ls", {
    settings = {
        Lua = {
            workspace = {
                library = vim.api.nvim_get_runtime_file("", true),
            },
        },
    },
})

vim.lsp.enable({
    "lua_ls",
    "ruff",
    "ty",
    "html",
    "cssls",
    "ts_ls",
    "svelte",
    "tailwindcss",
    "clangd",
})

vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("lsp_completion", { clear = true }),
    callback = function(args)
        local client_id = args.data.client_id
        if client_id then
            local client = vim.lsp.get_client_by_id(client_id)
            if client and client:supports_method("textDocument/completion") then
                vim.lsp.completion.enable(true, client_id, args.buf, {
                    autotrigger = true,
                })
            end
        end
    end,
})

vim.diagnostic.config({
    virtual_text = true,
    signs = {
        text = {
            [vim.diagnostic.severity.ERROR] = " ",
            [vim.diagnostic.severity.WARN] = " ",
            [vim.diagnostic.severity.HINT] = "󰠠 ",
            [vim.diagnostic.severity.INFO] = " ",
        },
    },
})
