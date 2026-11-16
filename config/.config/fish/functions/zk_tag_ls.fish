# List all tags
function zk_tag_ls --description "List all zk tags as JSON"
    command zk tag list -q -f json | jq
end
