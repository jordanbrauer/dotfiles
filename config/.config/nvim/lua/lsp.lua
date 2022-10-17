local config = require('lspconfig')
local completion = require('cmp_nvim_lsp')
local lsp = {}

local servers = {
    -- 'intelephense',
    -- 'gopls',
    'tsserver',
    'graphql',
    'terraformls',
    'eslint',
    -- 'elixirls',
}

-- Use an on_attach function to only map the following keys 
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
    -- local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end
    local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
    local opts = { noremap = true, silent = true }

    -- See `:help vim.lsp.*` for documentation on any of the below functions

    -- Workspaces (wtf is this? seemingly never works)
    -- buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>',                       opts)
    -- buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>',                    opts)
    -- buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)

    -- Navigation
    buf_set_keymap('n', '<space>D',  '<Cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
    buf_set_keymap('n', 'gD',        '<Cmd>lua vim.lsp.buf.declaration()<CR>',     opts)
    buf_set_keymap('n', 'gd',        '<Cmd>lua vim.lsp.buf.definition()<CR>',      opts)
    buf_set_keymap('n', 'gi',        '<Cmd>lua vim.lsp.buf.implementation()<CR>',  opts)

    -- Introspecation
    buf_set_keymap('n', 'K',         '<Cmd>lua vim.lsp.buf.hover()<CR>',           opts)
    buf_set_keymap('n', '<C-k>',     '<Cmd>lua vim.lsp.buf.signature_help()<CR>',  opts)
    buf_set_keymap('n', 'gr',        '<Cmd>Telescope lsp_references<CR>',          opts)
    buf_set_keymap('n', '<space>gs', '<Cmd>lua vim.lsp.buf.document_symbol()<CR>', opts)

    -- Code Tools
    buf_set_keymap('n', '<space>rn', '<Cmd>lua vim.lsp.buf.rename()<CR>',                 opts)
    buf_set_keymap("n", "<space>f",  "<Cmd>lua vim.lsp.buf.format({ async = true })<CR>", opts)
    buf_set_keymap('n', '<space>ca', '<Cmd>lua vim.lsp.buf.code_action()<CR>',            opts)

    -- Diagnostics
    buf_set_keymap('n', '<space>e',  '<Cmd>lua vim.diagnostic.open_float()<CR>', opts)
    buf_set_keymap('n', '[d',        '<Cmd>lua vim.diagnostic.goto_prev()<CR>',  opts)
    buf_set_keymap('n', ']d',        '<Cmd>lua vim.diagnostic.goto_next()<CR>',  opts)
    buf_set_keymap('n', '<space>q',  '<Cmd>lua vim.diagnostic.setloclist()<CR>', opts)
end

function lsp.setup(server, overrides)
    local defaults = {
        on_attach = on_attach,
        capabilities = completion.default_capabilities(),
    }

    config[server].setup(vim.tbl_extend("force", defaults, overrides or {}))
end

return lsp
