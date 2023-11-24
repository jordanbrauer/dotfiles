# Generate a `.gitignore` file from a list of technology options
export def gi [] {
    let options = (["macos" "windows" "linux" "go" "node" "php" "elixir"] | str join "\n")
    let ignore = ($options | gum choose --no-limit | str trim | lines | str join ',')

    http get $"https://www.toptal.com/developers/gitignore/api/($ignore)"
}

# Open an interactive REPL editor for
#
# • javascript (node)
# • lua
export def scratch [language?: string] {
    let options = [javascript lua php graphql]
    let settings = "let g:startify_disable_at_vimenter = 1 | set bt=nofile ls=0 noru nonu nornu | hi ColorColumn guibg=NONE ctermbg=NONE | hi VertSplit guibg=NONE ctermbg=NONE | hi NonText ctermfg=0 | Codi"

    if $language != null {
        nvim -c ([$settings $language] | str join " ")
    } else {
        nvim -c ([$settings ($options | str join "\n" | gum choose --limit 1 | str trim)] | str join " ")
    }
}

# Print the top 10 (by default) commands from the history file
export def freq [commands: int = 10] {
    history | get command | each {|e| $e | split row -r '\s+' | first} | to text | awk '{CMD[$1]++;count++;}END { for (a in CMD)print CMD[a] " " CMD[a]/count*100 "% " a;}' | grep -v ./ | column -c3 -s " " -t | ^sort -nr | nl | head -n $commands | lines | str trim | split column -r '\s+' | rename place invocations percentage command | reject place
}

# Begin a new typing test
export def tt [] {
    ^tt -theme citylights -showwpm -quotes en -json | from json
}

# Find answers to shit on the internet using cURL and https://cheat.sh/
export def howto [
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
    let selection = ($options | str join "\n" | gum filter --placeholder "Choose a tool ..." | str trim)
    let path = ($query | str trim | str join "+")

    curl $"https://cht.sh/($selection)/($path)"
}
