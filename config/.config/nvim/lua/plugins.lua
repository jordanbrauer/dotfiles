vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
    -- Core
	use 'wbthomason/packer.nvim' -- Packer can manage itself
    use 'nvim-lua/plenary.nvim'  -- depended on by: telescope, harpoon

    -- UI & Themes
	use 'tjdevries/colorbuddy.vim'
	use 'nvim-lualine/lualine.nvim'
	use 'jordanbrauer/citylights.nvim'
    use 'norcalli/nvim-colorizer.lua'

    -- File Management
    use 'nvim-telescope/telescope.nvim'
    use 'nvim-telescope/telescope-ui-select.nvim'
	use 'tpope/vim-vinegar'
	use 'ThePrimeagen/harpoon'

    -- Formatting
	use 'tpope/vim-surround'
	use 'tpope/vim-commentary'
	use 'jiangmiao/auto-pairs'

    -- Git Integrations
    use 'tpope/vim-fugitive'
    use 'mhinz/vim-signify' -- requires at least Vim 8.0.902
    use 'f-person/git-blame.nvim'

    -- Language Server (IDE)
    use 'neovim/nvim-lspconfig'
    use 'hrsh7th/cmp-nvim-lsp'
    use 'hrsh7th/cmp-buffer'
    use 'hrsh7th/cmp-path'
    use 'hrsh7th/cmp-cmdline'
    use 'hrsh7th/nvim-cmp'
    use 'hrsh7th/vim-vsnip'
    use 'hrsh7th/vim-vsnip-integ'
    use 'hrsh7th/cmp-vsnip'
    use 'nvim-treesitter/nvim-treesitter'
    use 'nvim-treesitter/playground'

    use 'ray-x/go.nvim'
    use 'ray-x/guihua.lua'
    use 'elixir-editors/vim-elixir'
end)
