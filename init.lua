local function ensure_packer()
    local fn = vim.fn
    local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
    if fn.empty(fn.glob(install_path)) > 0 then
        fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path })
        vim.cmd [[packadd packer.nvim]]
        return true
    end
    return false
end

local packer_bootstrap = ensure_packer()

vim.g.loaded = 1
vim.g.loaded_netrwPlugin = 1

require('packer').startup(function(use)
    use { 'wbthomason/packer.nvim' }
    use { 'williamboman/mason.nvim' }
    use { "williamboman/mason-lspconfig.nvim" }

    use { "folke/neodev.nvim" }
    use { 'neovim/nvim-lspconfig' }

    use { 'Issafalcon/lsp-overloads.nvim' }
    use {
        "ray-x/lsp_signature.nvim",
    }

    use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }


    use { 'hrsh7th/cmp-nvim-lsp' }
    use { 'hrsh7th/cmp-buffer' }
    use { 'hrsh7th/cmp-path' }
    use { 'hrsh7th/cmp-cmdline' }
    use { 'hrsh7th/nvim-cmp' }

    use { 'L3MON4D3/LuaSnip' }
    use { 'saadparwaiz1/cmp_luasnip' }

    use { "rafamadriz/friendly-snippets" }

    use { "windwp/nvim-autopairs",
        config = function() require("nvim-autopairs").setup {} end
    }
    use "lukas-reineke/indent-blankline.nvim"

    use 'navarasu/onedark.nvim'
    use 'karb94/neoscroll.nvim'
    use 'kyazdani42/nvim-web-devicons'
    use {
        'nvim-telescope/telescope.nvim', tag = '0.1.0',
        requires = { { 'nvim-lua/plenary.nvim' } }
    }
    use {
        'ThePrimeagen/harpoon',
        requires = { { 'nvim-lua/plenary.nvim' } }
    }
    use { 'akinsho/bufferline.nvim', tag = "v2.*", requires = 'kyazdani42/nvim-web-devicons' }
    use { "akinsho/toggleterm.nvim", tag = '*', config = function()
        require("toggleterm").setup()
    end }
    use 'mfussenegger/nvim-dap'
    use { "rcarriga/nvim-dap-ui", requires = { "mfussenegger/nvim-dap" } }
    use { 'akinsho/flutter-tools.nvim', requires = 'nvim-lua/plenary.nvim' }
    use { 'adelarsq/neofsharp.vim' }

    use {
        'nvim-lualine/lualine.nvim',
        requires = { 'kyazdani42/nvim-web-devicons', opt = true }
    }
    use { 'nvim-telescope/telescope-ui-select.nvim' }

    use {
        "ahmedkhalf/project.nvim",
        config = function()
            require("project_nvim").setup {
                sync_root_with_cwd = true,
                respect_buf_cwd = true,
                update_focused_file = {
                    enable = true,
                    update_root = true
                },
            }
        end
    }
    use {
        'tanvirtin/vgit.nvim',
        requires = {
            'nvim-lua/plenary.nvim'
        }
    }
    use {
        'nvim-tree/nvim-tree.lua',
        requires = {
            'nvim-tree/nvim-web-devicons', -- optional, for file icons
        },
    }

    use { 'kdheepak/lazygit.nvim' }
    use { "folke/which-key.nvim" }

    use {
        'numToStr/Comment.nvim',
        config = function()
            require('Comment').setup()
        end
    }

    use {
        'lewis6991/gitsigns.nvim',
        config = function()
            require('gitsigns').setup()
        end
    }
    use { 'romainl/vim-cool' }

    use 'kristijanhusak/vim-carbon-now-sh'

    if packer_bootstrap then
        require('packer').sync()
    end
end)

require('mason').setup()
require("mason-lspconfig").setup()

require('neodev').setup({})

require('onedark').setup {
    style = 'dark',
    transparent = true
}
require('dap.ext.vscode').load_launchjs()
require("dapui").setup()

require "lsp_signature".setup({})

-- require("indent_blankline").setup {
--     show_current_context = true,
--     show_current_context_start = true,
-- }

require('onedark').load()
require('neoscroll').setup()

require("which-key").setup {}
require('bufferline').setup {}
require('lualine').setup({})
require("harpoon").setup()
require("luasnip").setup {
    update_events = 'TextChanged,TextChangedI'
}

require("telescope").setup({
    extensions = {
        ["ui-select"] = {
            require("telescope.themes").get_dropdown {}
        }
    },
    pickers = {
        default = {
            theme = "dropdown",
        }
    }
})
require("telescope").load_extension("ui-select")
require('telescope').load_extension('projects')
require("nvim-tree").setup({
    view = {
        float = {
            enable = true,
            open_win_config = {
                width = 60,
                height = 80,
            }
        }
    }
})

require("nvim-treesitter.configs").setup {
    indent = {
        enable = true
    },
    highlight = {
        enable = true
    },
    incremental_selection = {
        enable = true
    }
}

vim.g.mapleader = ' '
vim.o.updatetime = 300
vim.o.incsearch = false
vim.wo.signcolumn = 'yes'
vim.opt.termguicolors = true
vim.opt.scrolloff = 999
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.autoindent = true
vim.opt.expandtab = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.ignorecase = true
vim.opt.cursorline = true

require('vgit').setup({
    keymaps = {
        ['n <leader>gp'] = function() require('vgit').buffer_hunk_preview() end,
        ['n <leader>gf'] = function() require('vgit').buffer_diff_preview() end,
        ['n <leader>gd'] = function() require('vgit').project_diff_preview() end,
        -- ['n <C-k>'] = function() require('vgit').hunk_up() end,
        -- ['n <C-j>'] = function() require('vgit').hunk_down() end,
        -- ['n <leader>gs'] = function() require('vgit').buffer_hunk_stage() end,
        -- ['n <leader>gr'] = function() require('git').buffer_hunk_reset() end,
        -- ['n <leader>gb'] = function() require('vgit').buffer_blame_preview() end,
        -- ['n <leader>gh'] = function() require('vgit').buffer_history_preview() end,
        -- ['n <leader>gu'] = function() require('vgit').buffer_reset() end,
        -- ['n <leader>gg'] = function() require('vgit').buffer_gutter_blame_preview() end,
        -- ['n <leader>glu'] = function() require('vgit').buffer_hunks_preview() end,
        -- ['n <leader>gls'] = function() require('vgit').project_hunks_staged_preview() end,
        -- ['n <leader>gq'] = function() require('vgit').project_hunks_qf() end,
        -- ['n <leader>gx'] = function() require('vgit').toggle_diff_preference() end,
    },
    settings = {
        live_blame = {
            enabled = true;
        }
    }
})

local builtin = require('telescope.builtin')
vim.keymap.set('n', '<space>f', builtin.find_files, {})
vim.keymap.set('n', 'fb', builtin.buffers, {})
vim.keymap.set('n', 'fg', builtin.git_files, {})
vim.keymap.set('n', 'ft', builtin.live_grep, {})
vim.keymap.set('n', 'fh', builtin.help_tags, {})
vim.keymap.set('n', 'fr', builtin.oldfiles, {})
vim.keymap.set('n', 'fe', function() builtin.diagnostics({ severity = vim.diagnostic.severity.ERROR }) end, {})

local dap = require('dap')
local dapui = require('dapui')
local opts = { noremap = true }
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
vim.keymap.set('n', '<C-s>', ':w<cr>')
vim.keymap.set('t', '<Esc>', '<C-\\><C-n>')
vim.keymap.set('n', '<space>rr', function() require('flutter-tools.commands').reload(true) end, opts)
vim.keymap.set('n', '<space>rR', function() require('flutter-tools.commands').restart(true) end, opts)
vim.keymap.set('n', '<space>gg', ":LazyGit<cr>", opts)
vim.keymap.set('n', '<space>e', ":NvimTreeToggle<cr>", opts)
vim.keymap.set('n', '<C-t>', ":ToggleTerm<cr>")
vim.keymap.set('t', '<C-t>', "<C-\\><C-n>:ToggleTerm<cr>")
vim.keymap.set('n', '<F5>', dap.continue, opts)
vim.keymap.set('n', '<F10>', dap.step_over, opts)
vim.keymap.set('n', '<F11>', dap.step_into, opts)
vim.keymap.set('n', '<F12>', dap.step_out, opts)
vim.keymap.set('n', '<space>b', dap.toggle_breakpoint, opts)
vim.keymap.set('n', '<space>dt', dapui.toggle, opts)

-- vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)

local harpoon_ui = require('harpoon.ui')
vim.keymap.set('n', 'mt', require('harpoon.mark').toggle_file);
vim.keymap.set('n', 'ml', require('harpoon.ui').toggle_quick_menu);
vim.keymap.set('n', 'ma', function() harpoon_ui.nav_file(1) end)
vim.keymap.set('n', 'mo', function() harpoon_ui.nav_file(2) end)
vim.keymap.set('n', 'me', function() harpoon_ui.nav_file(3) end)
vim.keymap.set('n', 'mu', function() harpoon_ui.nav_file(4) end)


local augroup_format = vim.api.nvim_create_augroup("Format", { clear = true })
local auggroup_onedit = vim.api.nvim_create_augroup("OnEdit", { clear = true })
local on_attach = function(client, bufnr)
    -- Enable completion triggered by <c-x><c-o>
    -- vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

    if client.server_capabilities.signatureHelpProvider then
        require('lsp-overloads').setup(client, {})
    end

    vim.api.nvim_clear_autocmds({ group = augroup_format, buffer = bufnr })
    vim.api.nvim_create_autocmd("BufWritePre", {
        group = augroup_format,
        buffer = bufnr,
        callback = function()
            vim.lsp.buf.format({ async = false, bufnr = bufnr })
        end,
    })
    vim.api.nvim_clear_autocmds({ group = auggroup_onedit, buffer = bufnr })
    vim.api.nvim_create_autocmd("InsertLeave", {
        group = auggroup_onedit,
        buffer = bufnr,
        callback = function()
            vim.lsp.codelens.refresh()
        end,
    })
    local bufopts = { noremap = true, silent = true, buffer = bufnr }
    vim.keymap.set('n', 'gs', require('telescope.builtin').lsp_dynamic_workspace_symbols, bufopts)
    vim.keymap.set('n', 'gd', require('telescope.builtin').lsp_definitions, bufopts)
    vim.keymap.set('n', 'gi', require('telescope.builtin').lsp_implementations, bufopts)
    vim.keymap.set('n', 'gr', require('telescope.builtin').lsp_references, bufopts)
    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
    vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
    vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
    -- vim.keymap.set('n', '<space>f', function() vim.lsp.buf.format { async = true } end, bufopts)
    -- vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, bufopts)
    -- vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
    -- vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, bufopts)
    -- vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
    -- vim.keymap.set('n', '<space>wl', function()
    --     print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    -- end, bufopts)
end

require("luasnip.loaders.from_lua").load({ paths = "./snippets" })
require("luasnip.loaders.from_vscode").lazy_load()


local cmp = require("cmp")
local luasnip = require("luasnip")
local has_words_before = function()
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

cmp.setup({
    snippet = {
        expand = function(args)
            require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
        end,
    },
    window = {
        -- completion = cmp.config.window.bordered(),
        -- documentation = cmp.config.window.bordered(),
    },
    mapping = cmp.mapping.preset.insert({
        ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
                luasnip.expand_or_jump()
            elseif has_words_before() then
                cmp.complete()
            else
                fallback()
            end
        end, { "i", "s" }),

        ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
                luasnip.jump(-1)
            else
                fallback()
            end
        end, { "i", "s" }),
        ['<C-b>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete({}),
        ['<C-e>'] = cmp.mapping.abort(),
        ['<CR>'] = cmp.mapping.confirm({ select = false }),
    }),
    sources = cmp.config.sources({
        { name = 'nvim_lsp' },
        { name = 'luasnip' },
    }, {
        { name = 'buffer' },
    })
})

cmp.setup.filetype('gitcommit', {
    sources = cmp.config.sources({
        { name = 'cmp_git' }, -- You can specify the `cmp_git` source if you were installed it.
    }, {
        { name = 'buffer' },
    })
})

cmp.setup.cmdline({ '/', '?' }, {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
        { name = 'buffer' }
    }
})

cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
        { name = 'path' }
    }, {
        { name = 'cmdline' }
    })
})

-- Set up lspconfig.
local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())

require('flutter-tools').setup({
    lsp = {
        on_attach = on_attach,
        capabilities = capabilities
    },

    debugger = {
        enabled = true,
    }
})

require 'lspconfig'.gopls.setup {
    on_attach = on_attach,
    capabilities = capabilities
}

require 'lspconfig'.omnisharp.setup {
    on_attach = on_attach,
    capabilities = capabilities
}
require 'lspconfig'.dockerls.setup {
    on_attach = on_attach,
    capabilities = capabilities
}
-- require 'lspconfig'.tflint.setup {
--     on_attach = on_attach,
--     capabilities = capabilities
-- }
require 'lspconfig'.terraformls.setup {
    on_attach = on_attach,
    capabilities = capabilities
}

require 'lspconfig'.fsautocomplete.setup {
    on_attach = on_attach,
    capabilities = capabilities
}

require 'lspconfig'.sumneko_lua.setup {
    on_attach = on_attach,
    capabilities = capabilities,
    settings = {
        Lua = {
            runtime = {
                version = 'LuaJIT',
            },
            diagnostics = {
                globals = { 'vim' },
            },
            workspace = {
                library = vim.api.nvim_get_runtime_file("", true),
            },
            telemetry = {
                enable = false,
            },
        },
    },
}
