return require('packer').startup(function(use)
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

    use { 'hrsh7th/cmp-vsnip' }
    use { 'hrsh7th/vim-vsnip' }

    use { "windwp/nvim-autopairs",
        config = function() require("nvim-autopairs").setup {} end
    }
    use 'navarasu/onedark.nvim'
    use 'karb94/neoscroll.nvim'
    use 'kyazdani42/nvim-web-devicons'
    use {
        'nvim-telescope/telescope.nvim', tag = '0.1.0',
        requires = { { 'nvim-lua/plenary.nvim' } }
    }
    use { 'akinsho/bufferline.nvim', tag = "v2.*", requires = 'kyazdani42/nvim-web-devicons' }
end)
