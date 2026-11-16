# List notes interactively
function zk_ls --description "List zk notes interactively, optionally filtered by type"
    if test (count $argv) -eq 0
        command zk list -i -f full -q --sort created
    else
        command zk list $argv[1] -i -f full -q --sort created
    end
end

# Tab completions for note filters
complete -c zk_ls -f -a "fleeting refs permd articles papers books videos interviews decks meetings"
