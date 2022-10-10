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

-- TODO: MAYBE PORT THIS TO LUA WHEN YOU LEARN HOW TO
-- vim.cmd([[
-- 	augroup packer_user_config
-- 		autocmd!
-- 		autocmd BufWritePost init.lua source <afile> | PackerCompile
-- 	augroup end
-- ]])

local packer_bootstrap = ensure_packer()

require('packer').startup(function(use)
    use { 'wbthomason/packer.nvim' }
    use { 'williamboman/mason.nvim' }
    use { "folke/lua-dev.nvim" }
    use { 'neovim/nvim-lspconfig' }
    use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }


    use { 'hrsh7th/cmp-nvim-lsp' }
    use { 'hrsh7th/cmp-buffer' }
    use { 'hrsh7th/cmp-path' }
    use { 'hrsh7th/cmp-cmdline' }
    use { 'hrsh7th/nvim-cmp' }

    use { 'L3MON4D3/LuaSnip' }
    use { 'saadparwaiz1/cmp_luasnip' }

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
    use { 'akinsho/flutter-tools.nvim', requires = 'nvim-lua/plenary.nvim' }

    use {
        'nvim-lualine/lualine.nvim',
        requires = { 'kyazdani42/nvim-web-devicons', opt = true }
    }
    use { 'nvim-telescope/telescope-ui-select.nvim' }

    use {
        "ahmedkhalf/project.nvim",
        config = function()
            require("project_nvim").setup {
            }
        end
    }
    use {
        'tanvirtin/vgit.nvim',
        requires = {
            'nvim-lua/plenary.nvim'
        }
    }
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

    if packer_bootstrap then
        require('packer').sync()
    end
end)

require('mason').setup()

require('lua-dev').setup({})

require('onedark').setup {
    style = 'dark',
    transparent = true
}

require("indent_blankline").setup {
    show_current_context = true,
    show_current_context_start = true,
}

require('onedark').load()
require('neoscroll').setup()

require("which-key").setup {}
require('bufferline').setup {}
require('lualine').setup({})
require("harpoon").setup()

require("telescope").setup({
    extensions = {
        ["ui-select"] = {
            require("telescope.themes").get_dropdown {
            }
        }
    }
})
require("telescope").load_extension("ui-select")

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

require('vgit').setup({
    keymaps = {
        -- ['n <C-k>'] = function() require('vgit').hunk_up() end,
        -- ['n <C-j>'] = function() require('vgit').hunk_down() end,
        -- ['n <leader>gs'] = function() require('vgit').buffer_hunk_stage() end,
        -- ['n <leader>gr'] = function() require('vgit').buffer_hunk_reset() end,
        ['n <leader>gp'] = function() require('vgit').buffer_hunk_preview() end,
        -- ['n <leader>gb'] = function() require('vgit').buffer_blame_preview() end,
        ['n <leader>gf'] = function() require('vgit').buffer_diff_preview() end,
        -- ['n <leader>gh'] = function() require('vgit').buffer_history_preview() end,
        -- ['n <leader>gu'] = function() require('vgit').buffer_reset() end,
        -- ['n <leader>gg'] = function() require('vgit').buffer_gutter_blame_preview() end,
        -- ['n <leader>glu'] = function() require('vgit').buffer_hunks_preview() end,
        -- ['n <leader>gls'] = function() require('vgit').project_hunks_staged_preview() end,
        ['n <leader>gd'] = function() require('vgit').project_diff_preview() end,
        -- ['n <leader>gq'] = function() require('vgit').project_hunks_qf() end,
        -- ['n <leader>gx'] = function() require('vgit').toggle_diff_preference() end,
    },
    settings = {
        live_blame = {
            enabled = false;
        }
    }
})

local builtin = require('telescope.builtin')
vim.keymap.set('n', 'ff', builtin.find_files, {})
vim.keymap.set('n', 'fg', builtin.git_files, {})
vim.keymap.set('n', 'ft', builtin.live_grep, {})
vim.keymap.set('n', 'fb', builtin.buffers, {})
vim.keymap.set('n', 'fh', builtin.help_tags, {})
vim.keymap.set('n', 'fr', builtin.oldfiles, {})

local opts = { noremap = true }
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)
vim.keymap.set('n', '<C-s>', ':w<cr>')
vim.keymap.set('n', '<space>rr', function() require('harpoon.tmux').sendCommand('run', 'r') end, opts)
vim.keymap.set('n', '<space>rR', function() require('harpoon.tmux').sendCommand('run', 'R') end, opts)

local harpoon_ui = require('harpoon.ui')
vim.keymap.set('n', 'mt', require('harpoon.mark').toggle_file);
vim.keymap.set('n', 'ml', require('harpoon.ui').toggle_quick_menu);
vim.keymap.set('n', 'ma', function() harpoon_ui.nav_file(1) end)
vim.keymap.set('n', 'mo', function() harpoon_ui.nav_file(2) end)
vim.keymap.set('n', 'me', function() harpoon_ui.nav_file(3) end)
vim.keymap.set('n', 'mu', function() harpoon_ui.nav_file(4) end)

local on_attach = function(_, bufnr)
    -- Enable completion triggered by <c-x><c-o>
    -- vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

    local bufopts = { noremap = true, silent = true, buffer = bufnr }
    vim.keymap.set('n', 'gs', require('telescope.builtin').lsp_dynamic_workspace_symbols, bufopts)
    vim.keymap.set('n', 'gd', require('telescope.builtin').lsp_definitions, bufopts)
    -- vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
    vim.keymap.set('n', 'gi', require('telescope.builtin').lsp_implementations, bufopts)
    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
    vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, bufopts)
    vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
    vim.keymap.set('n', '<space>wl', function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, bufopts)
    vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, bufopts)
    vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
    vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
    vim.keymap.set('n', 'gr', require('telescope.builtin').lsp_references, bufopts)
    vim.keymap.set('n', '<space>f', function() vim.lsp.buf.format { async = true } end, bufopts)
end

local cmp = require 'cmp'

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
        ['<S-Tab>'] = function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            else
                fallback()
            end
        end,
        ['<Tab>'] = function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            else
                fallback()
            end
        end,
        ['<C-b>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete({}),
        ['<C-e>'] = cmp.mapping.abort(),
        ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    }),
    sources = cmp.config.sources({
        { name = 'nvim_lsp' },
        { name = 'luasnip' }, -- For luasnip users.
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
local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())

require('flutter-tools').setup({
    lsp = {
        on_attach = on_attach,
        capabilities = capabilities
    }
})

require 'lspconfig'.gopls.setup {
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
