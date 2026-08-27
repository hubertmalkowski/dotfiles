return {

  {
    'folke/lazydev.nvim',
    ft = 'lua',
    opts = {
      library = {
        { path = 'luvit-meta/library', words = { 'vim%.uv' } },
      },
    },
  },
  { 'Bilal2453/luvit-meta', lazy = true },
  -- {
  --   'neovim/nvim-lspconfig',
  --   dependencies = {
  --     { 'williamboman/mason.nvim', config = true }, -- NOTE: Must be loaded before dependants
  --     'williamboman/mason-lspconfig.nvim',
  --     'TamaMcGlinn/nvim-lspconfig-ada',
  --     'WhoIsSethDaniel/mason-tool-installer.nvim',
  --     { 'j-hui/fidget.nvim', opts = {} },
  --
  --     -- 'hrsh7th/cmp-nvim-lsp',
  --   },
  --   config = function()
  --     vim.api.nvim_create_autocmd('LspAttach', {
  --       group = vim.api.nvim_create_augroup('kickstart-lsp-attach', { clear = true }),
  --       callback = function(event)
  --         local map = function(keys, func, desc)
  --           vim.keymap.set('n', keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
  --         end
  --
  --         -- map('gd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')
  --         --
  --         -- map('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
  --         --
  --         -- map('gI', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')
  --         --
  --         -- map('<leader>D', require('telescope.builtin').lsp_type_definitions, 'Type [D]efinition')
  --         --
  --         -- map('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
  --         --
  --         -- map('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')
  --         --
  --
  --         -- Rename the variable under your cursor.
  --         --  Most Language Servers support renaming across files, etc.
  --
  --         -- Execute a code action, usually your cursor needs to be on top of an error
  --         -- or a suggestion from your LSP for this to activate.
  --         map('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction', { 'n', 'x' })
  --
  --         vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, {
  --           border = 'rounded',
  --         })
  --         vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(vim.lsp.handlers.signatureHelp, {
  --           border = 'rounded',
  --         })
  --         vim.diagnostic.config { float = { border = 'single' } }
  --
  --         map('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
  --
  --         local client = vim.lsp.get_client_by_id(event.data.client_id)
  --         if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight) then
  --           local highlight_augroup = vim.api.nvim_create_augroup('kickstart-lsp-highlight', { clear = false })
  --           vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
  --             buffer = event.buf,
  --             group = highlight_augroup,
  --             callback = vim.lsp.buf.document_highlight,
  --           })
  --
  --           vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
  --             buffer = event.buf,
  --             group = highlight_augroup,
  --             callback = vim.lsp.buf.clear_references,
  --           })
  --
  --           vim.api.nvim_create_autocmd('LspDetach', {
  --             group = vim.api.nvim_create_augroup('kickstart-lsp-detach', { clear = true }),
  --             callback = function(event2)
  --               vim.lsp.buf.clear_references()
  --               vim.api.nvim_clear_autocmds { group = 'kickstart-lsp-highlight', buffer = event2.buf }
  --             end,
  --           })
  --         end
  --
  --         if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint) then
  --           map('<leader>th', function()
  --             vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = event.buf })
  --           end, '[T]oggle Inlay [H]ints')
  --         end
  --       end,
  --     })
  --
  --     local capabilities = vim.lsp.protocol.make_client_capabilities()
  --     capabilities = vim.tbl_deep_extend('force', capabilities, require('blink.cmp').get_lsp_capabilities({}, false))
  --     -- capabilities = vim.tbl_deep_extend('force', capabilities, require('cmp_nvim_lsp').default_capabilities())
  --
  --     capabilities.textDocument.foldingRange = {
  --       dynamicRegistration = false,
  --       lineFoldingOnly = true,
  --     }
  --
  --     local tailwind_filetypes = require('lspconfig.configs')['tailwindcss']
  --
  --     require('mason').setup()
  --
  --     local mason_registry = require 'mason-registry'
  --     local servers = {
  --       tailwindcss = {
  --         filetypes = { 'html', 'elixir', 'eelixir', 'heex', 'vue', 'ts', 'tsx', 'js', 'jsx', 'css', 'astro', 'eruby', 'svelte' },
  --         init_options = {
  --           userLanguages = {
  --             elixir = 'html-eex',
  --             eelixir = 'html-eex',
  --             heex = 'html-eex',
  --           },
  --         },
  --         settings = {
  --           tailwindCSS = {
  --             classAttributes = { 'class', 'className', 'class:list', 'classList', 'ngClass' },
  --             experimental = {
  --               classRegex = {
  --                 'class[:]\\s*"([^"]*)"',
  --                 { '~H"([^"]*)"', 1 },
  --               },
  --             },
  --           },
  --         },
  --       },
  --       -- lexical = {},
  --       -- nextls = {},
  --       --
  --       zls = {
  --         settings = {
  --           zls = {
  --             enable_build_on_save = false,
  --             enable_inlay_hints = true,
  --             inlay_hints_show_builtin = true,
  --             inlay_hints_exclude_single_argument = true,
  --             inlay_hints_hide_redundant_param_names = false,
  --             inlay_hints_hide_redundant_param_names_last_token = false,
  --           },
  --         },
  --       },
  --       lua_ls = {
  --         settings = {
  --           Lua = {
  --             completion = {
  --               callSnippet = 'Replace',
  --             },
  --           },
  --         },
  --       },
  --     }
  --
  --     -- Ensure the servers and tools above are installed
  --     --  To check the current status of installed tools and/or manually install
  --     --  other tools, you can run
  --     --    :Mason
  --     --
  --     --  You can press `g?` for help in this menu.
  --
  --     -- You can add other tools here that you want Mason to install
  --     -- for you, so that they are available from within Neovim.
  --     local ensure_installed = vim.tbl_keys(servers or {})
  --     vim.list_extend(ensure_installed, {
  --       'stylua', -- Used to format Lua code
  --     })
  --     local lspconfig = require 'lspconfig'
  --     lspconfig.gleam.setup {}
  --     lspconfig.als.setup {}
  --     lspconfig.roc_ls.setup {}
  --     lspconfig.ocamllsp.setup {
  --       codelens = {
  --         enable = true,
  --       },
  --       inlayHints = {
  --         enable = true,
  --       },
  --     }
  --     require('mason-tool-installer').setup { ensure_installed = ensure_installed }
  --
  --     require('mason-lspconfig').setup {
  --       handlers = {
  --         function(server_name)
  --           if server_name == 'clangd' then
  --             vim.keymap.set('n', '<leader>ch', '<cmd>ClangdSwitchSourceHeader<CR>', {
  --               desc = '[C] toggle [H]eader',
  --             })
  --           end
  --
  --           local server = servers[server_name] or {}
  --           -- This handles overriding only values explicitly passed
  --           -- by the server configuration above. Useful when disabling
  --           -- certain features of an LSP (for example, turning off formatting for tsserver)
  --           server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})
  --           lspconfig[server_name].setup(server)
  --         end,
  --       },
  --     }
  --   end,
  -- },

  {
    -- Main LSP Configuration
    'neovim/nvim-lspconfig',
    dependencies = {
      -- Automatically install LSPs and related tools to stdpath for Neovim
      -- Mason must be loaded before its dependents so we need to set it up here.
      -- NOTE: `opts = {}` is the same as calling `require('mason').setup({})`
      { 'mason-org/mason.nvim', opts = {} },
      'mason-org/mason-lspconfig.nvim',
      'WhoIsSethDaniel/mason-tool-installer.nvim',

      -- Useful status updates for LSP.
      { 'j-hui/fidget.nvim', opts = {} },

      -- Allows extra capabilities provided by blink.cmp
      'saghen/blink.cmp',
    },
    config = function()
      -- Brief aside: **What is LSP?**
      --
      -- LSP is an initialism you've probably heard, but might not understand what it is.
      --
      -- LSP stands for Language Server Protocol. It's a protocol that helps editors
      -- and language tooling communicate in a standardized fashion.
      --
      -- In general, you have a "server" which is some tool built to understand a particular
      -- language (such as `gopls`, `lua_ls`, `rust_analyzer`, etc.). These Language Servers
      -- (sometimes called LSP servers, but that's kind of like ATM Machine) are standalone
      -- processes that communicate with some "client" - in this case, Neovim!
      --
      -- LSP provides Neovim with features like:
      --  - Go to definition
      --  - Find references
      --  - Autocompletion
      --  - Symbol Search
      --  - and more!
      --
      -- Thus, Language Servers are external tools that must be installed separately from
      -- Neovim. This is where `mason` and related plugins come into play.
      --
      -- If you're wondering about lsp vs treesitter, you can check out the wonderfully
      -- and elegantly composed help section, `:help lsp-vs-treesitter`

      --  This function gets run when an LSP attaches to a particular buffer.
      --    That is to say, every time a new file is opened that is associated with
      --    an lsp (for example, opening `main.rs` is associated with `rust_analyzer`) this
      --    function will be executed to configure the current buffer
      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('kickstart-lsp-attach', { clear = true }),
        callback = function(event)
          -- NOTE: Remember that Lua is a real programming language, and as such it is possible
          -- to define small helper and utility functions so you don't have to repeat yourself.
          --
          -- In this case, we create a function that lets us more easily define mappings specific
          -- for LSP related items. It sets the mode, buffer and description for us each time.
          local map = function(keys, func, desc, mode)
            mode = mode or 'n'
            vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
          end

          -- Rename the variable under your cursor.
          --  Most Language Servers support renaming across files, etc.

          map('<leader>cr', vim.lsp.buf.rename, '[C]ode [R]ename')

          -- Execute a code action, usually your cursor needs to be on top of an error
          -- or a suggestion from your LSP for this to activate.

          map('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction', { 'n', 'x' })

          vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, {
            border = 'rounded',
          })
          vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(vim.lsp.handlers.signatureHelp, {
            border = 'rounded',
          })
          vim.diagnostic.config { float = { border = 'single' } }

          -- Find references for the word under your cursor.
          -- map('grr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')

          -- Jump to the implementation of the word under your cursor.
          --  Useful when your language has ways of declaring types without an actual implementation.
          -- map('gri', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')

          -- Jump to the definition of the word under your cursor.
          --  This is where a variable was first declared, or where a function is defined, etc.
          --  To jump back, press <C-t>.
          -- map('grd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')
          --
          -- -- WARN: This is not Goto Definition, this is Goto Declaration.
          -- --  For example, in C this would take you to the header.
          -- map('grD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
          --
          -- -- Fuzzy find all the symbols in your current document.
          -- --  Symbols are things like variables, functions, types, etc.
          -- map('gO', require('telescope.builtin').lsp_document_symbols, 'Open Document Symbols')
          --
          -- -- Fuzzy find all the symbols in your current workspace.
          -- --  Similar to document symbols, except searches over your entire project.
          -- map('gW', require('telescope.builtin').lsp_dynamic_workspace_symbols, 'Open Workspace Symbols')
          --
          -- -- Jump to the type of the word under your cursor.
          -- --  Useful when you're not sure what type a variable is and you want to see
          -- --  the definition of its *type*, not where it was *defined*.
          -- map('grt', require('telescope.builtin').lsp_type_definitions, '[G]oto [T]ype Definition')

          -- This function resolves a difference between neovim nightly (version 0.11) and stable (version 0.10)
          ---@param client vim.lsp.Client
          ---@param method vim.lsp.protocol.Method
          ---@param bufnr? integer some lsp support methods only in specific files
          ---@return boolean
          local function client_supports_method(client, method, bufnr)
            if vim.fn.has 'nvim-0.11' == 1 then
              return client:supports_method(method, bufnr)
            else
              return client.supports_method(method, { bufnr = bufnr })
            end
          end

          -- The following two autocommands are used to highlight references of the
          -- word under your cursor when your cursor rests there for a little while.
          --    See `:help CursorHold` for information about when this is executed
          --
          -- When you move your cursor, the highlights will be cleared (the second autocommand).
          local client = vim.lsp.get_client_by_id(event.data.client_id)
          if client and client_supports_method(client, vim.lsp.protocol.Methods.textDocument_documentHighlight, event.buf) then
            local highlight_augroup = vim.api.nvim_create_augroup('kickstart-lsp-highlight', { clear = false })
            vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
              buffer = event.buf,
              group = highlight_augroup,
              callback = vim.lsp.buf.document_highlight,
            })

            vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
              buffer = event.buf,
              group = highlight_augroup,
              callback = vim.lsp.buf.clear_references,
            })

            vim.api.nvim_create_autocmd('LspDetach', {
              group = vim.api.nvim_create_augroup('kickstart-lsp-detach', { clear = true }),
              callback = function(event2)
                vim.lsp.buf.clear_references()
                vim.api.nvim_clear_autocmds { group = 'kickstart-lsp-highlight', buffer = event2.buf }
              end,
            })
          end

          -- The following code creates a keymap to toggle inlay hints in your
          -- code, if the language server you are using supports them
          --
          -- This may be unwanted, since they displace some of your code
          if client and client_supports_method(client, vim.lsp.protocol.Methods.textDocument_inlayHint, event.buf) then
            map('<leader>th', function()
              vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = event.buf })
            end, '[T]oggle Inlay [H]ints')
          end
        end,
      })

      -- Diagnostic Config
      -- See :help vim.diagnostic.Opts
      vim.diagnostic.config {
        severity_sort = true,
        float = { border = 'rounded', source = 'if_many' },
        underline = { severity = vim.diagnostic.severity.ERROR },
        signs = vim.g.have_nerd_font and {
          text = {
            [vim.diagnostic.severity.ERROR] = '󰅚 ',
            [vim.diagnostic.severity.WARN] = '󰀪 ',
            [vim.diagnostic.severity.INFO] = '󰋽 ',
            [vim.diagnostic.severity.HINT] = '󰌶 ',
          },
        } or {},
        virtual_text = {
          source = 'if_many',
          spacing = 2,
          format = function(diagnostic)
            local diagnostic_message = {
              [vim.diagnostic.severity.ERROR] = diagnostic.message,
              [vim.diagnostic.severity.WARN] = diagnostic.message,
              [vim.diagnostic.severity.INFO] = diagnostic.message,
              [vim.diagnostic.severity.HINT] = diagnostic.message,
            }
            return diagnostic_message[diagnostic.severity]
          end,
        },
      }

      -- LSP servers and clients are able to communicate to each other what features they support.
      --  By default, Neovim doesn't support everything that is in the LSP specification.
      --  When you add blink.cmp, luasnip, etc. Neovim now has *more* capabilities.
      --  So, we create new capabilities with blink.cmp, and then broadcast that to the servers.
      local capabilities = require('blink.cmp').get_lsp_capabilities()

      -- Enable the following language servers
      --  Feel free to add/remove any LSPs that you want here. They will automatically be installed.
      --
      --  Add any additional override configuration in the following tables. Available keys are:
      --  - cmd (table): Override the default command used to start the server
      --  - filetypes (table): Override the default list of associated filetypes for the server
      --  - capabilities (table): Override fields in capabilities. Can be used to disable certain LSP features.
      --  - settings (table): Override the default settings passed when initializing the server.
      --        For example, to see the options for `lua_ls`, you could go to: https://luals.github.io/wiki/settings/
      local servers = {

        -- ocamllsp = {},

        tailwindcss = {
          filetypes = { 'html', 'elixir', 'eelixir', 'heex', 'vue', 'ts', 'tsx', 'js', 'jsx', 'css', 'astro', 'eruby', 'svelte' },
          init_options = {
            userLanguages = {
              elixir = 'html-eex',
              eelixir = 'html-eex',
              heex = 'html-eex',
            },
          },
          settings = {
            tailwindCSS = {
              classAttributes = { 'class', 'className', 'class:list', 'classList', 'ngClass' },
              experimental = {
                classRegex = {
                  'class[:]\\s*"([^"]*)"',
                  { '~H"([^"]*)"', 1 },
                },
              },
            },
          },
        },
        -- clangd = {},
        -- gopls = {},
        -- pyright = {},
        -- rust_analyzer = {},
        -- ... etc. See `:help lspconfig-all` for a list of all the pre-configured LSPs
        --
        -- Some languages (like typescript) have entire language plugins that can be useful:
        --    https://github.com/pmizio/typescript-tools.nvim
        --
        -- But for many setups, the LSP (`ts_ls`) will work just fine
        -- ts_ls = {},
        --
        -- vue_ls = {
        --   filetypes = { 'vue' },
        -- },

        lua_ls = {
          -- cmd = { ... },
          -- filetypes = { ... },
          -- capabilities = {},
          settings = {
            Lua = {
              completion = {
                callSnippet = 'Replace',
              },
              -- You can toggle below to ignore Lua_LS's noisy `missing-fields` warnings
              -- diagnostics = { disable = { 'missing-fields' } },
            },
          },
        },
      }
      -- vim.lsp.config.vue_ls = {
      -- }
      --
      -- -- Enable both
      -- vim.lsp.enable 'vue_ls'

      -- require('lspconfig')['vue_ls'].setup {
      --
      --   cmd = { 'vue-language-server', '--stdio' },
      --   filetypes = { 'vue' },
      --   root_markers = { 'package.json' },
      -- }

      -- Ensure the servers and tools above are installed
      --
      -- To check the current status of installed tools and/or manually install
      -- other tools, you can run
      --    :Mason
      --
      -- You can press `g?` for help in this menu.
      --
      -- `mason` had to be setup earlier: to configure its options see the
      -- `dependencies` table for `nvim-lspconfig` above.
      --
      -- You can add other tools here that you want Mason to install
      -- for you, so that they are available from within Neovim.
      local ensure_installed = vim.tbl_keys(servers or {})
      vim.list_extend(ensure_installed, {
        'stylua', -- Used to format Lua code
      })
      require('mason-tool-installer').setup { ensure_installed = ensure_installed }
      vim.api.nvim_create_autocmd('FileType', {
        pattern = 'roc',
        callback = function(args)
          local root = vim.fs.root(args.buf, { 'main.roc', 'app.roc' })

          -- Retrieve capabilities from blink.cmp
          -- local capabilities = require('blink.cmp').get_lsp_capabilities()

          vim.lsp.start {
            name = 'roc_lsp',
            cmd = { '/usr/bin/roc', 'experimental-lsp', '--debug-transport' },
            root_dir = root,
            capabilities = capabilities,
          }
        end,
      })

      vim.api.nvim_create_autocmd('FileType', {
        pattern = { 'ocaml', 'dune' },
        callback = function(args)
          local root = vim.fs.root(args.buf, { 'dune' })

          -- Retrieve capabilities from blink.cmp
          -- local capabilities = require('blink.cmp').get_lsp_capabilities()

          vim.lsp.start {
            name = 'ocamllsp',
            cmd = { 'ocamllsp' },
            root_dir = root,
            capabilities = capabilities,
          }
        end,
      })

      vim.api.nvim_create_autocmd('FileType', {
        pattern = { 'haskell', 'lhaskell' },
        callback = function(args)
          local root = vim.fs.root(args.buf, { 'hie.yaml', 'stack.yaml', 'cabal.project', '*.cabal', 'package.yaml' })

          vim.lsp.start {
            name = 'hls',
            cmd = { 'haskell-language-server-wrapper', '--lsp' },
            root_dir = root,
            capabilities = capabilities,
            settings = {
              haskell = {
                formattingProvider = 'fourmolu',
              },
            },
          }
        end,
      })

      require('mason-lspconfig').setup {
        ensure_installed = {}, -- explicitly set to an empty table (Kickstart populates installs via mason-tool-installer)
        automatic_installation = false,
        handlers = {
          function(server_name)
            local server = servers[server_name] or {}
            -- This handles overriding only values explicitly passed
            -- by the server configuration above. Useful when disabling
            -- certain features of an LSP (for example, turning off formatting for ts_ls)
            server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})
            require('lspconfig')[server_name].setup(server)
          end,
        },
      }
    end,
  },

  {
    'pmizio/typescript-tools.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'neovim/nvim-lspconfig',
      { 'williamboman/mason.nvim', config = true }, -- NOTE: Must be loaded before dependants
    },
    opts = {
      filetypes = {
        'javascript',
        'javascriptreact',
        'javascript.jsx',
        'typescript',
        'typescriptreact',
        'typescript.tsx',
        'vue',
        'json',
        'jsonc',
      },
      handlers = {
        ['textDocument/publishDiagnostics'] = function(_, result, ctx, config)
          if result.diagnostics == nil then
            return
          end

          -- ignore some tsserver diagnostics
          local idx = 1
          while idx <= #result.diagnostics do
            local entry = result.diagnostics[idx]

            local formatter = require('format-ts-errors')[entry.code]
            entry.message = formatter and formatter(entry.message) or entry.message

            -- codes: https://github.com/microsoft/TypeScript/blob/main/src/compiler/diagnosticMessages.json
            if entry.code == 80001 then
              -- { message = "File is a CommonJS module; it may be converted to an ES module.", }
              table.remove(result.diagnostics, idx)
            else
              idx = idx + 1
            end
          end

          vim.lsp.diagnostic.on_publish_diagnostics(_, result, ctx, config)
        end,
      },
      settings = {
        separate_diagnostic_server = true,
        expose_as_code_action = 'all',
        tsserver_max_memory = 'auto',
        tsserver_plugins = {
          '@vue/typescript-plugin',
        },
      },
    },
  },
  {
    'tarides/ocaml.nvim',
    config = function()
      require('ocaml').setup()
    end,
  },
}
