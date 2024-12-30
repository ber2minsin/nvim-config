return {

    -- {
    --     "nvim-lua/plenary.nvim",
    --     name = "plenary"
    -- },
    {
        "kiyoon/python-import.nvim",
        build = "pipx install . --force",
        -- build = "uv tool install . --force --reinstall",
        keys = {
            {
                "<M-CR>",
                function()
                    require("python_import.api").add_import_current_word_and_notify()
                end,
                mode = { "i", "n" },
                silent = true,
                desc = "Add python import",
                ft = "python",
            },
            {
                "<M-CR>",
                function()
                    require("python_import.api").add_import_current_selection_and_notify()
                end,
                mode = "x",
                silent = true,
                desc = "Add python import",
                ft = "python",
            },
            {
                "<space>i",
                function()
                    require("python_import.api").add_import_current_word_and_move_cursor()
                end,
                mode = "n",
                silent = true,
                desc = "Add python import and move cursor",
                ft = "python",
            },
            {
                "<space>i",
                function()
                    require("python_import.api").add_import_current_selection_and_move_cursor()
                end,
                mode = "x",
                silent = true,
                desc = "Add python import and move cursor",
                ft = "python",
            },
            {
                "<space>tr",
                function()
                    require("python_import.api").add_rich_traceback()
                end,
                silent = true,
                desc = "Add rich traceback",
                ft = "python",
            },
        },
        opts = {
            -- Example 1:
            -- Default behaviour for `tqdm` is `from tqdm.auto import tqdm`.
            -- If you want to change it to `import tqdm`, you can set `import = {"tqdm"}` and `import_from = {tqdm = nil}` here.
            -- If you want to change it to `from tqdm import tqdm`, you can set `import_from = {tqdm = "tqdm"}` here.

            -- Example 2:
            -- Default behaviour for `logger` is `import logging`, ``, `logger = logging.getLogger(__name__)`.
            -- If you want to change it to `import my_custom_logger`, ``, `logger = my_custom_logger.get_logger()`,
            -- you can set `statement_after_imports = {logger = {"import my_custom_logger", "", "logger = my_custom_logger.get_logger()"}}` here.
            extend_lookup_table = {
                ---@type string[]
                import = {
                    -- "tqdm",
                },

                ---@type table<string, string>
                import_as = {
                    -- These are the default values. Here for demonstration.
                    -- np = "numpy",
                    -- pd = "pandas",
                },

                ---@type table<string, string>
                import_from = {
                    -- tqdm = nil,
                    -- tqdm = "tqdm",
                },

                ---@type table<string, string[]>
                statement_after_imports = {
                    -- logger = { "import my_custom_logger", "", "logger = my_custom_logger.get_logger()" },
                },
            },

            ---Return nil to indicate no match is found and continue with the default lookup
            ---Return a table to stop the lookup and use the returned table as the result
            ---Return an empty table to stop the lookup. This is useful when you want to add to wherever you need to.
            ---@type fun(winnr: integer, word: string, ts_node: TSNode?): string[]?
            custom_function = function(winnr, word, ts_node)
                -- if vim.endswith(word, "_DIR") then
                --   return { "from my_module import " .. word }
                -- end
            end,
        },
    },
    "rcarriga/nvim-notify", -- optional
    {
        "ThePrimeagen/refactoring.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-treesitter/nvim-treesitter",
        },
        lazy = false,
        config = function()
            require("refactoring").setup()
        end,
    },
    { "nvim-neotest/nvim-nio" },
    { 'neovim/nvim-lspconfig' },
    { 'simrat39/rust-tools.nvim' },
    -- { "github/copilot.vim"},
    {
        "zbirenbaum/copilot.lua",
        cmd = "Copilot",
        event = "InsertEnter",
        config = function()
            require("copilot").setup({
                panel = {
                    enabled = true,
                    auto_refresh = false,
                    keymap = {
                        jump_prev = "[[",
                        jump_next = "]]",
                        accept = "<CR>",
                        refresh = "gr",
                        open = "<M-CR>"
                    },
                    layout = {
                        position = "bottom", -- | top | left | right | horizontal | vertical
                        ratio = 0.4
                    },
                },
                suggestion = {
                    enabled = true,
                    auto_trigger = true,
                    hide_during_completion = true,
                    debounce = 75,
                },
                filetypes = {
                    ["."] = true,
                },
                copilot_node_command = 'node', -- Node.js version must be > 18.x
                server_opts_overrides = {},
            })
        end,
    },
    -- {
    --     "epwalsh/obsidian.nvim",
    --     version = "*", -- recommended, use latest release instead of latest commit
    --     lazy = true,
    --     ft = "markdown",
    --     -- Replace the above line with this if you only want to load obsidian.nvim for markdown files in your vault:
    --     -- event = {
    --     --   -- If you want to use the home shortcut '~' here you need to call 'vim.fn.expand'.
    --     --   -- E.g. "BufReadPre " .. vim.fn.expand "~" .. "/my-vault/**.md"
    --     --   "BufReadPre path/to/my-vault/**.md",
    --     --   "BufNewFile path/to/my-vault/**.md",
    --     -- },
    --     dependencies = {
    --         -- Required.
    --         "nvim-lua/plenary.nvim",
    --
    --         -- see below for full list of optional dependencies 👇
    --     },
    --     opts = {
    --         workspaces = {
    --             {
    --                 name = "personal",
    --                 path = "~/vaults/personal",
    --             },
    --             {
    --                 name = "work",
    --                 path = "~/vaults/work",
    --             },
    --         },
    --
    --         -- see below for full list of options 👇
    --     }
    -- },
    { 'numToStr/Comment.nvim' },
    {
        'mrcjkb/rustaceanvim',
        version = '^4',
        lazy = false,
    },
    { "simrat39/rust-tools.nvim" },
    {
        'saecki/crates.nvim',
        tag = 'stable',
        config = function()
            require('crates').setup()
        end,
    }
}
