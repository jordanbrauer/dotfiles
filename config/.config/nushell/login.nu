pfetch

alias awsx = _awsx
alias edit = ^($env.EDITOR)
alias cp = cp -iv
alias mv = mv -iv
alias less = less -FSRXc
alias todo = todo.sh

# Generate a `.gitignore` file from a list of technology options
def gi [] {
    let options = (["macos" "windows" "linux" "go" "node" "php" "elixir"] | str collect "\n")
    let ignore = ($options | gum choose --no-limit | str trim | lines | str collect ',')

    fetch $"https://www.toptal.com/developers/gitignore/api/($ignore)"
}

# Open an interactive REPL editor for
#
# • javascript (node)
# • lua
def scratch [language?: string] {
    let options = ["javascript", "lua"]
    let settings = "let g:startify_disable_at_vimenter = 1 | set bt=nofile ls=0 noru nonu nornu | hi ColorColumn guibg=NONE ctermbg=NONE | hi VertSplit guibg=NONE ctermbg=NONE | hi NonText ctermfg=0 | Codi"

    if $language != null {
        nvim -c ([$settings $language] | str collect " ")
    } else {
        nvim -c ([$settings ($options | str collect "\n" | gum choose --limit 1 | str trim)] | str collect " ")
    }
}

# Begin a new typing test
def tt [] {
    ^tt -theme citylights -showwpm -quotes en -json | from json
}

# Make use of the Pritunl VPN through the gotunl CLI utility.
def vpn [] {
    echo 'hi'
}

# List all VPN connections
def "vpn ls" [] {
    print ([(ansi yellow) 'your vpn connections' (ansi reset)] | str collect)

    let connections = (gotunl -o tsv -l | from tsv | str trim)

    let headings = ($connections | columns | str trim | str downcase)

    [$headings $connections]
}

def "vpn dc" [] {
    gotunl -d all
}

def reload [] {
    source ~/.dotfiles/config/.config/nushell/config.nu
}

# Find answers to shit on the internet using cURL and https://cheat.sh/
def howto [
    ...query: string # Ask a question and then be asked for a tech or tool
] {
    let options = [
        "bash"
        "elixir"
        "golang"
        "javascript"
        "lua"
        "mongo"
        "mysql"
        "nodejs"
        "nu"
        "php"
        "postgresql"
        "redis"
        "sqlite3"
        "terraform"
        "typescript"
    ]
    let selection = ($options | str collect "\n" | gum filter --placeholder "Choose a tool ..." | str trim)
    let path = ($query | str trim | str collect "+")

    curl $"https://cht.sh/($selection)/($path)"
}
