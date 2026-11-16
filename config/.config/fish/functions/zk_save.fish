# Index, commit, and push notes
function zk_save --description "Index zk notes, commit all changes, and push to remote"
    command zk index
    git -C ~/.local/share/zk add .
    git -C ~/.local/share/zk commit -m "saving contents"
    git -C ~/.local/share/zk push
end
