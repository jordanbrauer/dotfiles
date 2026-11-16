# Generate a .gitignore from technology selections
function gi --description "Generate a .gitignore via toptal API with gum chooser"
    set -l options macos windows linux go node php elixir
    set -l ignore (printf '%s\n' $options | gum choose --no-limit | string trim | string join ',')

    curl -sL "https://www.toptal.com/developers/gitignore/api/$ignore"
end
