local plugins = {
    {
        "neovim/nvim-lspconfig",
        config = function()
            require "plugins.configs.lspconfig"
            require "custom.configs.lspconfig"
        end,
    },
    {
        "williamboman/mason.nvim",
        opts = {
            ensure_installed = {
                "clangd",
                "jdtls"
            }
        }
    },
    {
        "Xe/lolcode.vim",
        ft = "lolcode"
    },
    {
        "Zeioth/compiler.nvim",
        cmd = {"CompilerOpen", "CompilerToggleResults", "CompilerRedo"},
        dependencies = { "stevearc/overseer.nvim", "nvim-telescope/telescope.nvim" },
        opts = {},
    },
    {
        "stevearc/overseer.nvim",
        commit = "6271cab7ccc4ca840faa93f54440ffae3a3918bd",
        cmd = { "CompilerOpen", "CompilerToggleResults", "CompilerRedo" },
        opts = {
            task_list = {
                direction = "bottom",
                min_height = 25,
                max_height = 25,
                default_detail=1
            },
        },
    },
    {
        "tribela/transparent.nvim",
        event = 'VimEnter',
        config = true,
    }
}
return plugins
