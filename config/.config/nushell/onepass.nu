# # 1Password CLI wrapper
# export def onepass [] {
#     help onepass
# }

# Check if you are currently authenticated with 1password
export def "authed" [] {
    # if false == (env | any name == OP_SESSION) {
    #    false
    # } else {
    #    do -i { op list vaults --session $env.OP_SESSION | save /dev/null }
    #    $env.LAST_EXIT_CODE == 0
    # }
}

# Log into a 1password session for the given account
export def-env "login" [account: string = 'neofinancial' --return] {
    let-env OP_SESSION = (if (onepass authed) {
        $env.OP_SESSION
    } else {
        let options = ['neofinancial']
        let chosen = (if $account != null {
            $account
        } else {
            ($options | str collect "\n" | gum filter --placeholder "Choose account..." | str trim)
        })

        op signin $chosen --raw | str trim
    })

    if $return {
        $env.OP_SESSION
    }
}

# Copy an items password to the clipboard
export def-env "word" [record: string] {
    onepass login
    op get item $"($record)" --session $env.OP_SESSION --fields password | pbcopy
    print ([(ansi green) '  ' (ansi reset) ' Copied your "' $record '" password to the clipboard'] | str collect)
}

# Copy an items MFA token to the clipboard
export def-env "mfa" [record: string] {
    onepass login
    op get totp $"($record)" --session $env.OP_SESSION | pbcopy
    print ([(ansi green) '  ' (ansi reset) ' Copied your "' $record '" MFA to the clipboard'] | str collect)
}

# Look at at a given items details
export def-env "view" [record: string] {
    onepass login
    op get item $"($record)" --session $env.OP_SESSION | from json
}
