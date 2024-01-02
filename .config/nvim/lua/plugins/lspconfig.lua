return {{
    "williamboman/mason.nvim",
    config = function()
        require("mason").setup()
    end
},
{
    "williamboman/mason-lspconfig.nvim",
    config = function()
        require("mason-lspconfig").setup({
            ensure_installed = { "pyright", "clangd" }
        })
    end
},
{
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
        diagnostics = {
            update_in_insert = false
        }
    },
    config = function()
        local lspconfig = require("lspconfig")
        local keymap = vim.keymap
        local opts = { noremap = true, silent = true }

        local on_attach = function(client, bufnr)
            opts.buffer = bufnr

            opts.desc = "Go to declaration"
            keymap.set("n", "gD", vim.lsp.buf.declaration, opts)

            opts.desc = "Show LSP definitions"
            keymap.set("n", "gd", vim.lsp.buf.implementation, opts)

            opts.desc = "buf hover"
            keymap.set("n", "gi", vim.lsp.buf.hover, opts)

            opts.desc = "Show LSP type definitions"
            keymap.set("n", "gt", "<cmd>Telescope lsp_type_definitions<CR>", opts)

            opts.desc = "See available code actions"
            keymap.set({ "n", "v" }, "<space>ca", vim.lsp.buf.code_action, opts)

            opts.desc = "Smart rename"
            keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)

            opts.desc = "Show buffer diagnostics"
            keymap.set("n", "<space>D", "<cmd>Telescope diagnostics bufnr=0<CR>", opts)

            opts.desc = "Show line diagnostics"
            keymap.set("n", "<space>d", vim.diagnostic.open_float, opts)

            opts.desc = "Go to previous diagnostic"
            keymap.set("n", "gk", vim.diagnostic.goto_prev, opts)

            opts.desc = "Go to next diagnostic"
            keymap.set("n", "gj", vim.diagnostic.goto_next, opts)

            opts.desc = "Show documentation for what is under cursor"
            keymap.set("n", "K", vim.lsp.buf.signature_help, opts)

            -- add peek definitions...

        end

        local border = {
                {"┌", "FloatBorder"},
                {"─", "FloatBorder"},
                {"┐", "FloatBorder"},
                {"│", "FloatBorder"},
                {"┘", "FloatBorder"},
                {"─", "FloatBorder"},
                {"└", "FloatBorder"},
                {"│", "FloatBorder"},
            }

        local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
        function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
            opts = opts or {}
            opts.border = opts.border or border
            return orig_util_open_floating_preview(contents, syntax, opts, ...)
        end

        local signs = { Error = "E ", Warn = "W ", Hint = "H ", Info = "I " }
        for typ, icon in pairs(signs) do
            local hl = "DiagnosticSign" .. typ
            vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
        end

        lspconfig.pyright.setup({
            on_attach = on_attach,
            -- capabilities = {},
            settings = {},
            filetypes = {"python"},
        })
        lspconfig.clangd.setup({
            on_attach = on_attach,
            settings = {}
        })
    end
}
}
