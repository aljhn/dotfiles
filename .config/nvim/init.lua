-- Globals
vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.g.have_nerd_font = true


-- Options
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

vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.cursorline = true

vim.opt.list = true
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }

vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.termguicolors = true

vim.opt.updatetime = 250
vim.opt.timeoutlen = 300

vim.opt.signcolumn = "yes"

vim.opt.clipboard = "unnamedplus"

vim.opt.mouse = "a"

vim.opt.swapfile = false

vim.opt.winborder = "rounded"


-- Keymaps
vim.keymap.set({ "n", "v" }, "<Space>", "<Nop>", { silent = true })

vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "<C-d>", "<C-d>zz")

vim.keymap.set("n", "<leader>F", vim.lsp.buf.format, { desc = "[F]ormat File" })

vim.keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "[G]oto [D]efinition" })
vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { desc = "[G]oto [D]eclaration" })

vim.keymap.set("n", "<leader>vpu", vim.pack.update, { desc = "[V]im [P]ack [U]pdate" })

vim.keymap.set("n", "<leader>ff", "<cmd>FzfLua files<CR>")
vim.keymap.set("n", "<leader>fg", "<cmd>FzfLua live_grep<CR>")


-- Plugins
vim.pack.add({
    { src = "https://github.com/rebelot/kanagawa.nvim" },
    { src = "https://github.com/neovim/nvim-lspconfig" },
    { src = "https://github.com/folke/which-key.nvim" },
    { src = "https://github.com/nvim-treesitter/nvim-treesitter", version = "master" },
    { src = "https://github.com/nvim-tree/nvim-web-devicons" },
    { src = "https://github.com/ibhagwan/fzf-lua" },
    { src = "https://github.com/lewis6991/gitsigns.nvim" },
    { src = "https://github.com/nvim-lualine/lualine.nvim" },
    { src = "https://github.com/saghen/blink.indent" },
    { src = "https://github.com/windwp/nvim-autopairs" },
    { src = "https://github.com/windwp/nvim-ts-autotag" },
})

require("nvim-autopairs").setup({})
require("nvim-ts-autotag").setup({})

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

---@diagnostic disable-next-line: missing-fields
require("nvim-treesitter.configs").setup({
    ensure_installed = {
        "lua",
        "bash",
        "gitignore",
        "markdown",
        "toml",
        "yaml",
        "json",
        "dockerfile",
        "python",
        "c",
        "cpp",
        "cmake",
        "html",
        "css",
        "javascript",
        "typescript",
        "svelte",
        "haskell",
        "rust",
    },
    sync_install = false,
    auto_install = false,
    highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
    },
    indent = {
        enable = true,
    },
})

require("fzf-lua").setup({})

require("kanagawa").setup({
    transparent = true,
})

require("lualine").setup({
    options = {
        component_separators = "|",
        section_separators = "",
        theme = "auto",
    },
})

vim.api.nvim_create_autocmd("PackChanged", {
    desc = "Handle nvim-treesitter updates",
    group = vim.api.nvim_create_augroup("nvim-treesitter-pack-changed-update-handler", { clear = true }),
    callback = function(event)
        if event.data.kind == "update" and event.data.spec.name == "nvim-treesitter" then
            vim.notify("nvim-treesitter updated, running TSUpdate...", vim.log.levels.INFO)
            ---@diagnostic disable-next-line: param-type-mismatch
            local ok = pcall(vim.cmd, "TSUpdate")
            if ok then
                vim.notify("TSUpdate completed successfully!", vim.log.levels.INFO)
            else
                vim.notify("TSUpdate command not available yet, skipping", vim.log.levels.WARN)
            end
        end
    end,
})


-- LSP
vim.lsp.config("lua_ls", {
    settings = {
        Lua = {
            runtime = {
                version = "LuaJIT",
            },
            diagnostics = {
                globals = { "vim" },
            },
            hint = {
                enable = true,
            },
            workspace = {
                library = vim.api.nvim_get_runtime_file("", true),
                checkThirdParty = false,
            },
            telemetry = {
                enable = false,
            },
            format = {
                enable = true,
                defaultConfig = {
                    quote_style = "double",
                    table_separator_style = "comma",
                    trailing_table_separator = "smart",
                },
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
})


vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(event)
        local client = vim.lsp.get_client_by_id(event.data.client_id)
        if client ~= nil and client:supports_method("textDocument/completion") then
            vim.opt.completeopt = { "menu", "menuone", "noinsert", "fuzzy", "popup" }
            vim.lsp.completion.enable(true, client.id, event.buf, { autotrigger = true })
        end
    end,
})

vim.diagnostic.config({ virtual_text = true })


-- Colorscheme
vim.cmd.colorscheme("kanagawa")
