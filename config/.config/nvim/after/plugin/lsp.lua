local nvim_lsp = require('lspconfig')
local capabilities = require('cmp_nvim_lsp').default_capabilities()
local servers = {
    'intelephense',
    'gopls',
    'tsserver',
    'graphql',
    'terraformls',
    'eslint',
    'elixirls',
}

-- Use an on_attach function to only map the following keys 
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
    local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
    local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end
    local opts = { noremap=true, silent=true }

    -- See `:help vim.lsp.*` for documentation on any of the below functions
    -- buf_set_keymap('n', '<C-k>',     '<cmd>lua vim.lsp.buf.signature_help()<CR>',                             opts)
    -- buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>',                       opts)
    -- buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>',                    opts)
    -- buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)

    buf_set_keymap('n', 'gD',        '<Cmd>lua vim.lsp.buf.declaration()<CR>',                                opts)
    buf_set_keymap('n', 'gd',        '<Cmd>lua vim.lsp.buf.definition()<CR>',                                 opts)
    buf_set_keymap('n', '<space>D',  '<cmd>lua vim.lsp.buf.type_definition()<CR>',                            opts)
    buf_set_keymap('n', 'gi',        '<cmd>lua vim.lsp.buf.implementation()<CR>',                             opts)
    buf_set_keymap('n', 'gr',        '<cmd>Telescope lsp_references<CR>',                                     opts)

    buf_set_keymap('n', 'K',         '<Cmd>lua vim.lsp.buf.hover()<CR>',                                      opts)
    buf_set_keymap('n', '<space>gs', '<cmd>lua vim.lsp.buf.document_symbol()<CR>',                            opts)

    buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>',                                     opts)
    buf_set_keymap("n", "<space>f",  "<cmd>lua vim.lsp.buf.format({ async = true })<CR>",                                 opts)
    buf_set_keymap('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>',                                opts)
    buf_set_keymap('n', '<space>e',  '<cmd>lua vim.diagnostic.open_float()<CR>',               opts)
    buf_set_keymap('n', '[d',        '<cmd>lua vim.diagnostic.goto_prev()<CR>',                           opts)
    buf_set_keymap('n', ']d',        '<cmd>lua vim.diagnostic.goto_next()<CR>',                           opts)
    buf_set_keymap('n', '<space>q',  '<cmd>lua vim.diagnostic.setloclist()<CR>',                         opts)
end

for _, lsp in ipairs(servers) do
    if lsp ~= "elixirls" then
        nvim_lsp[lsp].setup { on_attach = on_attach, capabilities = capabilities }
    else -- special handling for the Elixir language server
        nvim_lsp[lsp].setup {
            on_attach = on_attach,
            capabilities = capabilities,
            cmd = { "/Users/jorb/.elixirls/language_server.sh" }
        }
    end
end
