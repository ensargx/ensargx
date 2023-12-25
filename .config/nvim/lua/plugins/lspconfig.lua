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
    config = function()
        local lspconfig = require("lspconfig")
        lspconfig.pyright.setup({
            -- on_attach = {},
            -- capabilities = {},
            settings = {},
            filetypes = {"python"},
        })
        lspconfig.clangd.setup {}
    end
}
}
