# Present a slide deck note
function zk_present --description "Interactively select and present a zk slide deck"
    set -l deck_json (command zk list decks -i -f json -q -P)
    set -l title (echo $deck_json | jq -r '.[0].title')
    set -l path (echo $deck_json | jq -r '.[0].absPath')

    kitty @ set-tab-title "$title"
    slides $path
end
