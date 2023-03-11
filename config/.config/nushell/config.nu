# Nushell Config File
#
# for more information on themes see
# https://www.nushell.sh/book/coloring_and_theming.html

alias cp = cp -iv
alias edit = ^($env.EDITOR)
alias less = less -FSRXc
alias mv = mv -iv
alias nvm = fnm
alias todo = todo.sh
alias cat = bat
alias vim = nvim
alias top = btm

let CityLights = {
    Black: black
    White: white
    Grey: "#41505e"
    Steel: "#718ca1"
    Red: "#e27e8d"
    Green: "#54af83"
    Blue: '#68a1f0'
    Yellow: '#ebda65'
    Orange: "#ebbf83"
    Sage: "#008b94"
    Aqua: "#9effff"
    Teal: "#70e1e8"
    Azure: "#5ec4ff"
    Success: "#54af83"
    Error: red
    Column: "#242b33"
    Menu: "#14232d"
    Select: "#363C43"
}

let light_theme = {}

let dark_theme = {
    # color for nushell primitives
    leading_trailing_space_bg: { attr: n } # no fg, no bg, attr none effectively turns this off
    separator: $CityLights.Select
    header: $CityLights.Grey
    empty: $CityLights.Yellow
    bool: $CityLights.Red
    int: $CityLights.Red
    filesize: $CityLights.Red
    duration: $CityLights.Green
    date: $CityLights.Red
    range: $CityLights.Red
    float: $CityLights.Red
    string: $CityLights.Blue
    nothing: $CityLights.White
    binary: $CityLights.White
    cellpath: $CityLights.White
    row_index: $CityLights.Grey
    record: $CityLights.Steel
    list: $CityLights.Steel
    block: $CityLights.Steel
    hints: $CityLights.Grey

    # shapes are used to change the cli syntax highlighting
    shape_garbage: { fg: "#FFFFFF" bg: "#FF0000" attr: b}
    shape_binary: $CityLights.Red
    shape_bool: $CityLights.Red
    shape_int: $CityLights.Red
    shape_float: $CityLights.Red
    shape_range: yellow_bold
    shape_internalcall: $CityLights.Azure
    shape_external: $CityLights.Teal
    shape_externalarg: $CityLights.Green
    shape_literal: $CityLights.Blue
    shape_operator: $CityLights.Azure
    shape_signature: $CityLights.Azure
    shape_string: $CityLights.Blue
    shape_string_interpolation: $CityLights.Steel
    shape_datetime: $CityLights.Red
    shape_list: cyan_bold
    shape_table: blue_bold
    shape_record: cyan_bold
    shape_block: blue_bold
    shape_filepath: $CityLights.Blue
    shape_globpattern: cyan_bold
    shape_variable: $CityLights.Orange
    shape_flag: blue_bold
    shape_custom: green
    shape_nothing: light_cyan
}

# The default config record. This is where much of your global configuration is setup.
let-env config = {
  edit_mode: vi # emacs, vi
  color_config: $dark_theme   # if you want a light theme, replace `$dark_theme` to `$light_theme`
  use_ansi_coloring: true
  use_grid_icons: true
  footer_mode: "25" # always, never, number_of_rows, auto
  float_precision: 2
  buffer_editor: "nvim" # command that will be used to edit the current line buffer with ctrl+o, if unset fallback to $env.EDITOR and $env.VISUAL
  shell_integration: true # enables terminal markers and a workaround to arrow keys stop working issue
  # A strategy of managing table view in case of limited space.
  show_banner: false # true or false to enable or disable the banner

  table: {
    mode: rounded # basic, compact, compact_double, light, thin, with_love, rounded, reinforced, heavy, none, other
    index_mode: always
    trim: {
      methodology: truncating, # truncating
      # A strategy which will be used by 'wrapping' methodology
      wrapping_try_keep_words: true,
      # A suffix which will be used with 'truncating' methodology
      truncating_suffix: "..."
    }
  }

  history: {
    max_size: 10000 # Session has to be reloaded for this to take effect
    sync_on_enter: true # Enable to share the history between multiple sessions, else you have to close the session to persist history to file
    file_format: "plaintext" # "sqlite" or "plaintext"
  }

  completions: {
    quick: false  # set this to false to prevent auto-selecting completions when only one remains
    partial: false  # set this to false to prevent partial filling of the prompt
    algorithm: "prefix"  # prefix, fuzzy
    case_sensitive: false # set to true to enable case-sensitive completions
    external: {
      enable: true # set to false to prevent nushell looking into $env.PATH to find more suggestions, `false` recommended for WSL users as this look up my be very slow
      max_results: 100 # setting it lower can improve completion performance at the cost of omitting some options
      completer: null
    }
  }

  filesize: {
    metric: false
    format: "auto" # b, kb, kib, mb, mib, gb, gib, tb, tib, pb, pib, eb, eib, zb, zib, auto
  }

  ls: {
    use_ls_colors: true
  }

  rm: {
    always_trash: false
  }

  cd: {
    abbreviations: false # set to true to allow you to do things like cd s/o/f and nushell expand it to cd some/other/folder
  }

  hooks: {
    pre_prompt: [{
        print "\n" # blank line between output & prompt
    }]
    pre_execution: [{
        print "" # blank line between output & prompt
    }]
    env_change: {
      PWD: [{|before, after|
        $nothing  # replace with source code to run if the PWD environment is different since the last repl input
      }]
    }
  }

  menus: [
      # Configuration for default nushell menus
      # Note the lack of souce parameter
      {
        name: completion_menu
        only_buffer_difference: false
        marker: ([(ansi -e { fg: $CityLights.Orange }) "λ | " (ansi reset)] | str collect)
        type: {
            layout: columnar
            columns: 4
            col_width: 20   # Optional value. If missing all the screen width is used to calculate column width
            col_padding: 2
        }
        style: {
            text: green
            selected_text: green_reverse
            description_text: yellow
        }
      }
      {
        name: history_menu
        only_buffer_difference: true
        marker: ([(ansi -e { fg: $CityLights.Yellow }) "λ ? " (ansi reset)] | str collect)
        type: {
            layout: list
            page_size: 10
        }
        style: {
            text: green
            selected_text: green_reverse
            description_text: yellow
        }
      }
      {
        name: help_menu
        only_buffer_difference: true
        marker: ([(ansi -e { fg: $CityLights.Yellow }) "λ ? " (ansi reset)] | str collect)
        type: {
            layout: description
            columns: 4
            col_width: 20   # Optional value. If missing all the screen width is used to calculate column width
            col_padding: 2
            selection_rows: 4
            description_rows: 10
        }
        style: {
            text: green
            selected_text: green_reverse
            description_text: yellow
        }
      }
      # Example of extra menus created using a nushell source
      # Use the source field to create a list of records that populates
      # the menu
      {
        name: commands_menu
        only_buffer_difference: false
        marker: "λ # "
        type: {
            layout: columnar
            columns: 4
            col_width: 20
            col_padding: 2
        }
        style: {
            text: green
            selected_text: green_reverse
            description_text: yellow
        }
        source: { |buffer, position|
            $nu.scope.commands
            | where command =~ $buffer
            | each { |it| {value: $it.command description: $it.usage} }
        }
      }
      {
        name: vars_menu
        only_buffer_difference: true
        marker: "λ # "
        type: {
            layout: list
            page_size: 10
        }
        style: {
            text: green
            selected_text: green_reverse
            description_text: yellow
        }
        source: { |buffer, position|
            $nu.scope.vars
            | where name =~ $buffer
            | sort-by name
            | each { |it| {value: $it.name description: $it.type} }
        }
      }
      {
        name: commands_with_description
        only_buffer_difference: true
        marker: "λ # "
        type: {
            layout: description
            columns: 4
            col_width: 20
            col_padding: 2
            selection_rows: 4
            description_rows: 10
        }
        style: {
            text: green
            selected_text: green_reverse
            description_text: yellow
        }
        source: { |buffer, position|
            $nu.scope.commands
            | where command =~ $buffer
            | each { |it| {value: $it.command description: $it.usage} }
        }
      }
  ]

  keybindings: [
    {
      name: completion_menu
      modifier: none
      keycode: tab
      mode: emacs # Options: emacs vi_normal vi_insert
      event: {
        until: [
          { send: menu name: completion_menu }
          { send: menunext }
        ]
      }
    }
    {
      name: completion_previous
      modifier: shift
      keycode: backtab
      mode: [emacs, vi_normal, vi_insert] # Note: You can add the same keybinding to all modes by using a list
      event: { send: menuprevious }
    }
    {
      name: history_menu
      modifier: control
      keycode: char_r
      mode: emacs
      event: { send: menu name: history_menu }
    }
    {
      name: next_page
      modifier: control
      keycode: char_x
      mode: emacs
      event: { send: menupagenext }
    }
    {
      name: undo_or_previous_page
      modifier: control
      keycode: char_z
      mode: emacs
      event: {
        until: [
          { send: menupageprevious }
          { edit: undo }
        ]
       }
    }
    {
      name: yank
      modifier: control
      keycode: char_y
      mode: emacs
      event: {
        until: [
          {edit: pastecutbufferafter}
        ]
      }
    }
    {
      name: unix-line-discard
      modifier: control
      keycode: char_u
      mode: [emacs, vi_normal, vi_insert]
      event: {
        until: [
          {edit: cutfromlinestart}
        ]
      }
    }
    {
      name: kill-line
      modifier: control
      keycode: char_k
      mode: [emacs, vi_normal, vi_insert]
      event: {
        until: [
          {edit: cuttolineend}
        ]
      }
    }
    # Keybindings used to trigger the user defined menus
    {
      name: commands_menu
      modifier: control
      keycode: char_t
      mode: [emacs, vi_normal, vi_insert]
      event: { send: menu name: commands_menu }
    }
    {
      name: vars_menu
      modifier: alt
      keycode: char_o
      mode: [emacs, vi_normal, vi_insert]
      event: { send: menu name: vars_menu }
    }
    {
      name: commands_with_description
      modifier: control
      keycode: char_s
      mode: [emacs, vi_normal, vi_insert]
      event: { send: menu name: commands_with_description }
    }
  ]
}

module completions {
  # Custom completions for external commands (those outside of Nushell)
  # Each completions has two parts: the form of the external command, including its flags and parameters
  # and a helper command that knows how to complete values for those flags and parameters
  #
  # This is a simplified version of completions for git branches and git remotes
  def "nu-complete git branches" [] {
    ^git branch | lines | each { |line| $line | str replace '[\*\+] ' '' | str trim }
  }

  def "nu-complete git remotes" [] {
    ^git remote | lines | each { |line| $line | str trim }
  }

  # Download objects and refs from another repository
  export extern "git fetch" [
    repository?: string@"nu-complete git remotes" # name of the repository to fetch
    branch?: string@"nu-complete git branches" # name of the branch to fetch
    --all                                         # Fetch all remotes
    --append(-a)                                  # Append ref names and object names to .git/FETCH_HEAD
    --atomic                                      # Use an atomic transaction to update local refs.
    --depth: int                                  # Limit fetching to n commits from the tip
    --deepen: int                                 # Limit fetching to n commits from the current shallow boundary
    --shallow-since: string                       # Deepen or shorten the history by date
    --shallow-exclude: string                     # Deepen or shorten the history by branch/tag
    --unshallow                                   # Fetch all available history
    --update-shallow                              # Update .git/shallow to accept new refs
    --negotiation-tip: string                     # Specify which commit/glob to report while fetching
    --negotiate-only                              # Do not fetch, only print common ancestors
    --dry-run                                     # Show what would be done
    --write-fetch-head                            # Write fetched refs in FETCH_HEAD (default)
    --no-write-fetch-head                         # Do not write FETCH_HEAD
    --force(-f)                                   # Always update the local branch
    --keep(-k)                                    # Keep dowloaded pack
    --multiple                                    # Allow several arguments to be specified
    --auto-maintenance                            # Run 'git maintenance run --auto' at the end (default)
    --no-auto-maintenance                         # Don't run 'git maintenance' at the end
    --auto-gc                                     # Run 'git maintenance run --auto' at the end (default)
    --no-auto-gc                                  # Don't run 'git maintenance' at the end
    --write-commit-graph                          # Write a commit-graph after fetching
    --no-write-commit-graph                       # Don't write a commit-graph after fetching
    --prefetch                                    # Place all refs into the refs/prefetch/ namespace
    --prune(-p)                                   # Remove obsolete remote-tracking references
    --prune-tags(-P)                              # Remove any local tags that do not exist on the remote
    --no-tags(-n)                                 # Disable automatic tag following
    --refmap: string                              # Use this refspec to map the refs to remote-tracking branches
    --tags(-t)                                    # Fetch all tags
    --recurse-submodules: string                  # Fetch new commits of populated submodules (yes/on-demand/no)
    --jobs(-j): int                               # Number of parallel children
    --no-recurse-submodules                       # Disable recursive fetching of submodules
    --set-upstream                                # Add upstream (tracking) reference
    --submodule-prefix: string                    # Prepend to paths printed in informative messages
    --upload-pack: string                         # Non-default path for remote command
    --quiet(-q)                                   # Silence internally used git commands
    --verbose(-v)                                 # Be verbose
    --progress                                    # Report progress on stderr
    --server-option(-o): string                   # Pass options for the server to handle
    --show-forced-updates                         # Check if a branch is force-updated
    --no-show-forced-updates                      # Don't check if a branch is force-updated
    -4                                            # Use IPv4 addresses, ignore IPv6 addresses
    -6                                            # Use IPv6 addresses, ignore IPv4 addresses
    --help                                        # Display this help message
  ]

  # Check out git branches and files
  export extern "git checkout" [
    ...targets: string@"nu-complete git branches"   # name of the branch or files to checkout
    --conflict: string                              # conflict style (merge or diff3)
    --detach(-d)                                    # detach HEAD at named commit
    --force(-f)                                     # force checkout (throw away local modifications)
    --guess                                         # second guess 'git checkout <no-such-branch>' (default)
    --ignore-other-worktrees                        # do not check if another worktree is holding the given ref
    --ignore-skip-worktree-bits                     # do not limit pathspecs to sparse entries only
    --merge(-m)                                     # perform a 3-way merge with the new branch
    --orphan: string                                # new unparented branch
    --ours(-2)                                      # checkout our version for unmerged files
    --overlay                                       # use overlay mode (default)
    --overwrite-ignore                              # update ignored files (default)
    --patch(-p)                                     # select hunks interactively
    --pathspec-from-file: string                    # read pathspec from file
    --progress                                      # force progress reporting
    --quiet(-q)                                     # suppress progress reporting
    --recurse-submodules: string                    # control recursive updating of submodules
    --theirs(-3)                                    # checkout their version for unmerged files
    --track(-t)                                     # set upstream info for new branch
    -b: string                                      # create and checkout a new branch
    -B: string                                      # create/reset and checkout a branch
    -l                                              # create reflog for new branch
    --help                                          # Display this help message
  ]

  # Push changes
  export extern "git push" [
    remote?: string@"nu-complete git remotes",      # the name of the remote
    ...refs: string@"nu-complete git branches"      # the branch / refspec
    --all                                           # push all refs
    --atomic                                        # request atomic transaction on remote side
    --delete(-d)                                    # delete refs
    --dry-run(-n)                                   # dry run
    --exec: string                                  # receive pack program
    --follow-tags                                   # push missing but relevant tags
    --force-with-lease: string                      # require old value of ref to be at this value
    --force(-f)                                     # force updates
    --ipv4(-4)                                      # use IPv4 addresses only
    --ipv6(-6)                                      # use IPv6 addresses only
    --mirror                                        # mirror all refs
    --no-verify                                     # bypass pre-push hook
    --porcelain                                     # machine-readable output
    --progress                                      # force progress reporting
    --prune                                         # prune locally removed refs
    --push-option(-o): string                       # option to transmit
    --quiet(-q)                                     # be more quiet
    --receive-pack: string                          # receive pack program
    --recurse-submodules: string                    # control recursive pushing of submodules
    --repo: string                                  # repository
    --set-upstream(-u)                              # set upstream for git pull/status
    --signed: string                                # GPG sign the push
    --tags                                          # push tags (can't be used with --all or --mirror)
    --thin                                          # use thin pack
    --verbose(-v)                                   # be more verbose
    --help                                          # Display this help message
  ]
}

# Get just the extern definitions without the custom completion commands
use completions *

# Generate a `.gitignore` file from a list of technology options
def gi [] {
    let options = (["macos" "windows" "linux" "go" "node" "php" "elixir"] | str collect "\n")
    let ignore = ($options | gum choose --no-limit | str trim | lines | str collect ',')

    fetch $"https://www.toptal.com/developers/gitignore/api/($ignore)"
}

# Open an interactive REPL editor for
#
# • javascript (node)
# • lua
def scratch [language?: string] {
    let options = [javascript lua php graphql]
    let settings = "let g:startify_disable_at_vimenter = 1 | set bt=nofile ls=0 noru nonu nornu | hi ColorColumn guibg=NONE ctermbg=NONE | hi VertSplit guibg=NONE ctermbg=NONE | hi NonText ctermfg=0 | Codi"

    if $language != null {
        nvim -c ([$settings $language] | str collect " ")
    } else {
        nvim -c ([$settings ($options | str collect "\n" | gum choose --limit 1 | str trim)] | str collect " ")
    }
}

# Begin a new typing test
def tt [] {
    ^tt -theme citylights -showwpm -quotes en -json | from json
}

# Find answers to shit on the internet using cURL and https://cheat.sh/
def howto [
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
    let selection = ($options | str collect "\n" | gum filter --placeholder "Choose a tool ..." | str trim)
    let path = ($query | str trim | str collect "+")

    curl $"https://cht.sh/($selection)/($path)"
}

# 1Password CLI wrapper
def onepass [] {
    help onepass
}

# Check if you are currently authenticated with 1password
def "onepass authed" [] {
    # if false == (env | any name == OP_SESSION) {
    #    false
    # } else {
    #    do -i { op list vaults --session $env.OP_SESSION | save /dev/null }
    #    $env.LAST_EXIT_CODE == 0
    # }
}

# Log into a 1password session for the given account
def-env "onepass login" [account: string = 'neofinancial' --return] {
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
def-env "onepass word" [record: string] {
    onepass login
    op get item $"($record)" --session $env.OP_SESSION --fields password | pbcopy
    print ([(ansi green) '  ' (ansi reset) ' Copied your "' $record '" password to the clipboard'] | str collect)
}

# Copy an items MFA token to the clipboard
def-env "onepass mfa" [record: string] {
    onepass login
    op get totp $"($record)" --session $env.OP_SESSION | pbcopy
    print ([(ansi green) '  ' (ansi reset) ' Copied your "' $record '" MFA to the clipboard'] | str collect)
}

# Look at at a given items details
def-env "onepass view" [record: string] {
    onepass login
    op get item $"($record)" --session $env.OP_SESSION | from json
}

# AWSX wrapper
def-env awsx [...argv: string] {
    _awsx ($argv | str collect)
    awsx load
}

# Load AWSX `exports.sh` environment variables
def-env "awsx load" [] {
    load-env (
        open ([$env.HOME .awsx/exports.sh] | path join) |
        split row " " |
        last 2 |
        str replace -a '"' '' |
        split column = |
        rename name value |
        reduce -f {} {|it, acc| $acc | upsert $it.name $it.value }
    )
}

# Make use of the Pritunl VPN through the gotunl CLI utility.
def vpn [] {
    help vpn
}

# List all VPN connections
def "vpn ls" [] {
    gotunl -o tsv -l | from tsv | str trim | rename id name status
}

# Disconnect from all active connections
def "vpn dc" [] {
    gotunl -d all
    vpn ls
}

# Connect to the specified VPN or be prompted for an environment
def-env "vpn connect" [environment?: string] {
    let options = ["staging" "production" "integration"]
    let connection = (if $environment != null {
        $environment
    } else {
        ($options | str collect "\n" | gum filter --placeholder "Choose connection..." | str trim)
    })
    let host = (vpn ls | where name =~ $connection | first)

    onepass mfa pritunl
    gotunl -c $host.id
    gum spin --spinner minidot --title Connecting... -- nu -c 'sleep 3sec'
    vpn ls | where name =~ $connection | first
}

# Connect to a MongoDB database using credentials stored in 1Password
def-env mongo [
    database: string                # The name of the initial database to select upon connection
    environment?: string            # Specific environment to make a connection to
    --cluster: string = 'core' # Specify which cluster in the environment should be connected to
] {
    let options = [local integration staging production]
    let clusters = {
        core: 'connection-string-template'
        reporting: 'Reporting Cluster'
        internal: 'internal-cluster'
    }
    let connection = (if null != $environment {
        $environment
    } else {
        ($options | str collect "\n" | gum filter --placeholder "Choose connection..." | str trim)
    })
    let item = $"mongo-($connection)"
    let credentials = onepass view $item
    let password = ($credentials | get details.fields | where name == password | first | get value)
    let dsn = (
        $credentials |
        get details.sections |
        where title == 'Connection String Templates' |
        first |
        get fields |
        where t =~ $"($clusters | get $cluster)" |
        first |
        get v |
        str replace '{password}' $password
    )

    mongosh $dsn
}
