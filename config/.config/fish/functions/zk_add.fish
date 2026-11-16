# Add a new note
function zk_add --description "Add a new zk note by type"
    set -l types fleet ref perm article paper book video interview deck meeting
    set -l nb $argv[1]

    if test -z "$nb"
        set nb fleet
    end

    command zk $nb
    gum log -s -l info "created new note" type $nb
end

# Tab completions for note types
complete -c zk_add -f -a "fleet ref perm article paper book video interview deck meeting"
