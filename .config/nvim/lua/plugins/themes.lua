return {
    {
        enable = true,
        "savq/melange-nvim",
        lazy = false,
        config = function()
            -- vim.cmd.colorscheme "melange"
            -- vim.cmd.colorscheme "melange"
            -- vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
        end
    },
    {
        'projekt0n/github-nvim-theme',
        config = function()
                require('github-theme').setup({})
            -- vim.cmd.colorscheme "github_light"
            -- vim.cmd.colorscheme "melange"
            --[[ vim.api.nvim_set_hl(0, "Normal", { bg = "none" }) ]]
        end
    },
    {
        "rebelot/kanagawa.nvim",
        config = function()
            require("kanagawa").setup({
                transparent = false, -- do not set background color
                keywordStyle = { italic = false, bold = true },
                colors = {
                    theme = {
                        all = {
                            ui = {
                                bg_gutter = "none",
                                float = {
                                    bg = "white"
                                }
                            }
                        },
                        lotus = {
                            ui = {
                                bg_p1 = "white",
                                bg_m1 = "white",
                                fg_dim = "gray",
                                bg_dim = "white",
                            }
                        }
                    }
                },
                overrides = function(colors)
                    local theme = colors.theme
                    return {
                        NormalFloat = { bg = "none" },
                        FloatBorder = { bg = "gray" },
                        FloatTitle = { bg = "none" },

                        TelescopeTitle = { fg = theme.ui.special, bold = true },
                        TelescopePromptNormal = { bg = theme.ui.bg_p1 },
                        TelescopePromptBorder = { fg = theme.ui.bg_p1, bg = theme.ui.bg_p1 },
                        TelescopeResultsNormal = { fg = theme.ui.fg_dim, bg = theme.ui.bg_m1 },
                        TelescopeResultsBorder = { fg = theme.ui.bg_m1, bg = theme.ui.bg_m1 },
                        TelescopePreviewNormal = { bg = theme.ui.bg_dim },
                        TelescopePreviewBorder = { bg = theme.ui.bg_dim, fg = theme.ui.bg_dim },
                    }
                end,
            })
            vim.cmd.colorscheme "kanagawa-dragon"
        end
    },
    {
        "rose-pine/neovim",
        name = "rose-pine",
        priority = 1000,
        config = function()
            -- vim.cmd.colorscheme "rose-pine"
            -- vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
        end

    },
    { "Mofiqul/adwaita.nvim", }
}
