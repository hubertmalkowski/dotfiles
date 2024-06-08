local kind_icons = {
    Text = "",
    Method = "󰆧",
    Function = "󰊕",
    Constructor = "",
    Field = "󰇽",
    Variable = "󰂡",
    Class = "󰠱",
    Interface = "",
    Module = "",
    Property = "󰜢",
    Unit = "",
    Value = "󰎠",
    Enum = "",
    Keyword = "󰌋",
    Snippet = "",
    Color = "󰏘",
    File = "󰈙",
    Reference = "",
    Folder = "󰉋",
    EnumMember = "",
    Constant = "󰏿",
    Struct = "",
    Event = "",
    Operator = "󰆕",
    TypeParameter = "󰅲",
}


return {
    {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v3.x',
        priority = 1000,
        config = function()
            local lsp_zero = require('lsp-zero')
            lsp_zero.extend_lspconfig()
            lsp_zero.on_attach(function(client, bufnr)
                lsp_zero.default_keymaps({ buffer = bufnr })
                vim.keymap.set("n", "ld", function() vim.lsp.buf.definition() end, opts)
                vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
                vim.keymap.set("n", "<leader>lf", function() vim.diagnostic.open_float() end, opts)
                vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, opts)
                vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, opts)
                vim.keymap.set("n", "<leader>la", function() vim.lsp.buf.code_action() end, opts)
                vim.keymap.set("n", "<leader>lr", function()
                    -- vim.lsp.buf.references()
                    require("telescope.builtin").lsp_references()
                end, opts)
                vim.keymap.set("n", "<leader>ln", function() vim.lsp.buf.rename() end, opts)
                vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
                -- lsp_zero.buffer_autoformat()
            end)

            -- No need to set `hybridMode` to `true` as it's the default value
        end
    },
    { 'neovim/nvim-lspconfig' },
    { 'hrsh7th/cmp-nvim-lsp' },
    {
        'hrsh7th/nvim-cmp',
        config = function()
            local cmp = require("cmp")
            local cmp_action = require("lsp-zero").cmp_action()
            cmp.setup({
                mapping = cmp.mapping.preset.insert({
                    -- `Enter` key to confirm completion
                    ['<Tab>'] = cmp.mapping.confirm({ select = true }),
                    ['<Cr>'] = cmp.mapping.confirm({ select = true }),

                    -- Ctrl+Space to trigger completion menu
                    ['<C-Space>'] = cmp.mapping.complete(),

                    -- Navigate between snippet placeholder
                    ['<C-f>'] = cmp_action.luasnip_jump_forward(),
                    ['<C-b>'] = cmp_action.luasnip_jump_backward(),

                    -- Scroll up and down in the completion documentation
                    ['<C-u>'] = cmp.mapping.scroll_docs(-4),
                    ['<C-d>'] = cmp.mapping.scroll_docs(4),
                }),
                formatting = {
                    format = function(entry, vim_item)
                        vim_item.kind = string.format('%s %s', kind_icons[vim_item.kind], vim_item.kind)
                        vim_item.menu = ({
                            buffer = "[Buffer]",
                            luasnip = "[LuaSnip]",
                            nvim_lua = "[Lua]",
                            latex_symbols = "[LaTeX]",
                        })[entry.source.name]
                        return vim_item
                    end
                }
            })
        end
    },
    { 'L3MON4D3/LuaSnip' },

    {
        'williamboman/mason.nvim',
        config = function()
            require('mason').setup({})
        end
    },
    {
        'williamboman/mason-lspconfig.nvim',
        config = function()
            require('mason-lspconfig').setup({
                ensure_installed = {},
                handlers = {
                    function(server_name)
                        local mason_registry = require('mason-registry')
                        local vue_language_server_path = mason_registry.get_package('vue-language-server')
                            :get_install_path() .. '/node_modules/@vue/language-server'

                        local lspconfig = require('lspconfig')
                        if server_name == "tsserver" then
                            lspconfig.tsserver.setup {
                                init_options = {
                                    plugins = {
                                        {
                                            name = '@vue/typescript-plugin',
                                            location = vue_language_server_path,
                                            languages = { 'vue' },
                                        },
                                    },
                                },
                                filetypes = { 'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue' },
                            }
                        else
                            lspconfig[server_name].setup({})
                        end
                    end,
                },
            })
        end
    },
    {
        "folke/trouble.nvim",
        branch = "dev",
        keys = {
            {
                "<leader>i",
                "<cmd>Trouble diagnostics toggle<cr>",
                desc = "Diagnostics (Trouble)",
            },
        },
        opts = {
            win = {
                type = "split",
                position = "right"
            }
        }
    }
}
