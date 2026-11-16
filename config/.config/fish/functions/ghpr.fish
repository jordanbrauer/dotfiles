# Interactive PR creation with conventional commit title
# Equivalent of nushell's `gh pr create` override
function ghpr --description "Create a PR with interactive conventional commit title"
    argparse d/draft -- $argv
    or return

    set -l tag (printf '%s\n' feat fix docs style refactor perf test build ci revert chore infra | gum filter | string trim)
    set -l subject (gum input --prompt "> " --placeholder '(optional) the affected component' --header scope | string trim)
    set -l summary (gum input --prompt "> " --placeholder 'a brief summary of the change' --header summary | string trim)

    set -l title
    if test -z "$subject"
        set title "$tag: $summary"
    else
        set title "$tag($subject): $summary"
    end

    if set -q _flag_draft
        command gh pr create -a @me -t "$title" -d
    else
        command gh pr create -a @me -t "$title"
    end
end
