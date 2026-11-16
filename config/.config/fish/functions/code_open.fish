# Open a project from ~/Code/github.com in a terminal tab
# Equivalent of nushell's `code open` / `code op`
function code_open --description "Open a code project by name or interactively via fzf"
    if test (count $argv) -eq 0
        for dir in ~/Code/github.com/*/*
            if test -d "$dir"
                string replace "$HOME/Code/github.com/" "" "$dir"
            end
        end | fzf -m \
            --bind 'ctrl-c:clear-query' \
            --bind 'enter:become(code op {+} --focus)' \
            --height=100% --header-border rounded \
            --header "select code repo(s)" \
            --header-label="open" --header-label-pos=3 \
            --prompt "" --padding=0
        return
    end

    command code open $argv
end
