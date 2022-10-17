-- TODO: move these to their respective Lua files somehow (append to config)
vim.g['codi#interpreters'] = {
    php = {
        bin = 'psysh',
        prompt = '^(λ|...) ',
    },
    ts = {
        bin = 'tsun',
        prompt = '^(>|...) ',
    },
}
