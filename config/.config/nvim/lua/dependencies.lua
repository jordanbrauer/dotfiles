vim.cmd [[packadd packer.nvim]]

local packer = require('packer')
local dependencies = function(use)
    -- Core (Dependencies)
    use 'wbthomason/packer.nvim'   -- Packer can manage itself
    use 'nvim-lua/plenary.nvim'    -- depended on by: telescope, harpoon
    use 'tjdevries/colorbuddy.vim' -- depended on by: citylights
    use 'ray-x/guihua.lua'         -- depended on by: go.nvim

    -- UI & Themes
    use 'jordanbrauer/citylights.nvim'
    use 'nvim-lualine/lualine.nvim'
    use 'norcalli/nvim-colorizer.lua'

    -- File Management
    use 'nvim-telescope/telescope.nvim'
    use 'nvim-telescope/telescope-ui-select.nvim'
    use 'tpope/vim-vinegar'
    use 'ThePrimeagen/harpoon'

    -- Formatting
    use 'tpope/vim-surround'
    use 'tpope/vim-commentary'
    -- use 'jiangmiao/auto-pairs'
    use 'editorconfig/editorconfig-vim'

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
    use { 'nvim-treesitter/nvim-treesitter', run = 'vim.cmd [[ TSUpdate ]]' }
    use 'nvim-treesitter/playground'

    use 'ray-x/go.nvim'
    use 'elixir-editors/vim-elixir'
    -- php
    -- javascript/typescript/jsx
    -- markdown
    -- earthly
    -- terraform

    -- Misc.
    use 'metakirby5/codi.vim'
end

-- Auto Command Groups
vim.api.nvim_create_augroup('editor_behaviour', { clear = true })
vim.api.nvim_create_augroup('packer_user_config', { clear = true })

-- Re-Compile Packer when plugins file is written
vim.api.nvim_create_autocmd({ 'BufWritePost' }, {
    pattern = { 'dependencies.lua' },
    group = 'packer_user_config',
    callback = function()
        local file = vim.cmd [[ silent! echo expand("%") ]]

        vim.api.nvim_command('source ' .. file .. ' | PackerCompile')
    end,
})

return packer.startup(dependencies)
