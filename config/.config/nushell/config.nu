alias cp = cp -iv
alias edit = ^($env.EDITOR)
alias less = less -FSRXc
alias mv = mv -iv
alias nvm = fnm
alias todo = todo.sh
alias cat = bat
alias vim = nvim
alias top = btm

$env.config = {
  show_banner: false
  edit_mode: vi
  use_ansi_coloring: true
  footer_mode: 25
  float_precision: 2
}

$env.config.keybindings = [
  {
    name: completion_menu
    modifier: none
    keycode: tab
    mode: emacs
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
    mode: [emacs, vi_normal, vi_insert]
    event: { send: menuprevious }
  }
  # {
  #   name: history_menu
  #   modifier: control
  #   keycode: char_r
  #   mode: emacs
  #   event: { send: menu name: history_menu }
  # }
  {
    name: fuzzy_history
    modifier: control
    keycode: char_r
    mode: [emacs, vi_normal, vi_insert]
    event: [
      {
        send: ExecuteHostCommand
        cmd: "do {
          $env.SHELL = "/opt/homebrew/bin/bash"
          commandline edit --insert (
            history
            | get command
            | reverse
            | uniq
            | str join (char -i 0)
            | fzf --scheme=history 
                --read0
                --prompt=""
                --padding=0
                --bind 'ctrl-/:change-preview-window(right,70%|right)'
                --layout=reverse
                --height=40%
                --preview='echo -n {} | nu --stdin -c \'nu-highlight\''
                # Run without existing commandline query for now to test composability
                # -q (commandline)
            | decode utf-8
            | str trim
          )
        }"
      }
    ]
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

$env.config.hooks = {
  # pre_prompt: [
  #   { print "\n"  }
  # ]
  # pre_execution: [
  #   { print "" }
  # ]
  env_change: {
    PWD: [
      {|before, after| null}
    ]
  }
}

$env.config.completions = {
  quick: false          # set this to false to prevent auto-selecting completions when only one remains
  partial: false        # set this to false to prevent partial filling of the prompt
  algorithm: "prefix"   # prefix, fuzzy
  case_sensitive: false # set to true to enable case-sensitive completions
  external: {
    enable: true     # set to false to prevent nushell looking into $env.PATH to find more suggestions, `false` recommended for WSL users as this look up my be very slow
    max_results: 100 # setting it lower can improve completion performance at the cost of omitting some options
    completer: null
  }
}

$env.config.history = {
  max_size: 10000
  sync_on_enter: true
  file_format: "plaintext"
}

$env.config.filesize = {
  metric: true
  format: "auto"
}

$env.config.ls = {
  use_ls_colors: true
}

$env.config.rm = {
  always_trash: false
}

let palette = {
  White: white
  Black: black
  Red: red
  Green: green
  Yellow: yellow
  Blue: blue
  Magenta: magenta
  Cyan: cyan

  Fg: "#c0c0c0"
  Bg: "#1c1c1c"
  Cursor: "#bdfe58"
  LineNr: "#404040"
  Visual: "#303030"
  Comment: "#585858"
  String: "#d1d1d1"
  Func: "#e1e1e1"
  Kw: "#f1f1f1"
  Identifier: "#b1b1b1"
  Type: "#a1a1a1"
  SearchHighlight: "#1bfd9c"
  Operator: "#1bfd9c"
  Bracket: "#e6e6e6"
  Preprocessor: "#4b8902"
  Bool: "#66b2b2"
  Constant: "#b2d8d8"
  Added: "#baffc9"
  Changed: "#ffffba"
  Removed: "#ffb3ba"
  Error: "#dea6a0"
  Warning: "#d6efd8"
  Hint: "#bedc74"
  Info: "#7fa1c3"
  PmenuBg: "#1c1c1c"
  PmenuSelBg: "#1bfd9c"
  PmenuFg: "#c0c0c0"
  Eob: "#3c3c3c"
  Border: "#585858"
  Title: "#bdfe58"
  BufferlineSelection: "#1bfd9c"
}
let colours = $palette

$env.config.color_config = {
  # color for nushell primitives
  leading_trailing_space_bg: { attr: n } # no fg, no bg, attr none effectively turns this off
  separator: $palette.Visual
  header: $palette.Visual
  empty: $palette.Yellow
  bool: $palette.Bool
  int: $palette.Constant
  filesize: $palette.Constant
  duration: $palette.Constant
  date: $palette.Constant
  range: $palette.Operator
  float: $palette.Constant
  string: $palette.String
  nothing: $palette.White
  binary: $palette.White
  cellpath: $palette.White
  row_index: $palette.LineNr
  record: $palette.Bracket
  list: $palette.Bracket
  block: $palette.Bracket
  hints: $palette.Comment

  # shapes are used to change the cli syntax highlighting
  shape_garbage: { fg: $palette.Black bg: $palette.Error attr: b}
  shape_binary: $palette.White
  shape_bool: $palette.Bool
  shape_int: $palette.Constant
  shape_float: $palette.Constant
  shape_range: yellow_bold
  shape_internalcall: $palette.Func
  shape_external: $palette.Func
  shape_externalarg: $palette.Identifier
  shape_literal: $palette.Blue
  shape_operator: $palette.Operator
  shape_signature: $palette.Operator
  shape_string: $palette.String
  shape_string_interpolation: $palette.Preprocessor
  shape_datetime: $palette.Constant
  shape_list: cyan_bold
  shape_table: blue_bold
  shape_record: cyan_bold
  shape_block: blue_bold
  shape_filepath: $palette.Blue
  shape_globpattern: cyan_bold
  shape_variable: $palette.Identifier
  shape_flag: blue_bold
  shape_custom: green
  shape_nothing: light_cyan
}

$env.config.table = {
  mode: rounded
  index_mode: always
  trim: {
    methodology: truncating
    wrapping_try_keep_words: true
    truncating_suffix: "..."
  }
}

$env.config.menus = [
  # Configuration for default nushell menus
  # Note the lack of souce parameter
  {
    name: completion_menu
    only_buffer_difference: false
    marker: ([(ansi -e { fg: $colours.Operator attr: b }) "λ " (ansi reset)] | str join)
    type: {
        layout: ide
        columns: 4
        col_width: 20   # Optional value. If missing all the screen width is used to calculate column width
        col_padding: 2
    }
    style: {
        text: white
        selected_text: $colours.Green
        description_text: $colours.Comment
    }
  }
  {
    name: history_menu
    only_buffer_difference: true
    marker: ([(ansi -e { fg: $colours.Operator attr: b }) "λ " (ansi reset)] | str join)
    type: {
        layout: list
        page_size: 10
    }
    style: {
        text: white
        selected_text: white_reverse
        description_text: $colours.Comment
    }
  }
  {
    name: help_menu
    only_buffer_difference: true
    marker: ([(ansi -e { fg: $colours.Operator attr: b }) "λ " (ansi reset)] | str join)
    type: {
        layout: description
        columns: 4
        col_width: 20   # Optional value. If missing all the screen width is used to calculate column width
        col_padding: 2
        selection_rows: 4
        description_rows: 10
    }
    style: {
        text: white
        selected_text: white_reverse
        description_text: $colours.Comment
    }
  }
  # Example of extra menus created using a nushell source
  # Use the source field to create a list of records that populates
  # the menu
  {
    name: commands_menu
    only_buffer_difference: false
    marker: "λ "
    type: {
        layout: columnar
        columns: 4
        col_width: 20
        col_padding: 2
    }
    style: {
        text: white_bold
        selected_text: white_reverse
        description_text: $colours.Comment
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
    marker: "λ "
    type: {
        layout: list
        page_size: 10
    }
    style: {
        text: white_bold
        selected_text: white_reverse
        description_text: $colours.Comment
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
    marker: "λ "
    type: {
        layout: description
        columns: 4
        col_width: 20
        col_padding: 2
        selection_rows: 4
        description_rows: 10
    }
    style: {
        text: white_bold
        selected_text: white_reverse
        description_text: $colours.Comment
    }
    source: { |buffer, position|
        $nu.scope.commands
        | where command =~ $buffer
        | each { |it| {value: $it.command description: $it.usage} }
    }
  }
]

export def "gh pr create" [
    --draft # make the pr a draft
] {
    let tag = [feat fix docs style refactor perf test build ci revert chore infra] | to text | gum filter | str trim
    let subject = gum input --prompt "> " --placeholder '(optional) the affected component' --header scope | str trim
    let summary = gum input --prompt "> " --placeholder 'a brief summary of the change' --header summary | str trim
    let title = [$tag (if ($subject | str length) == 0 { "" } else { $"\(($subject)\)" }) ": " $summary] | str join | str trim

    if $draft {
        ^gh pr create -a @me -t $title -d
    } else {
        ^gh pr create -a @me -t $title
    }
}

export def "git ui" [] {
    gitui
}

# Generate a `.gitignore` file from a list of technology options
export def gi [] {
    let options = (["macos" "windows" "linux" "go" "node" "php" "elixir"] | str join "\n")
    let ignore = ($options | gum choose --no-limit | str trim | lines | str join ',')

    http get $"https://www.toptal.com/developers/gitignore/api/($ignore)"
}

# Open an interactive REPL editor for
#
# • javascript (node)
# • lua
export def scratch [language?: string] {
    let options = [javascript lua php graphql]
    let settings = "let g:startify_disable_at_vimenter = 1 | set bt=nofile ls=0 noru nonu nornu | hi ColorColumn guibg=NONE ctermbg=NONE | hi VertSplit guibg=NONE ctermbg=NONE | hi NonText ctermfg=0 | Codi"

    if $language != null {
        nvim -c ([$settings $language] | str join " ")
    } else {
        nvim -c ([$settings ($options | str join "\n" | gum choose --limit 1 | str trim)] | str join " ")
    }
}

# Print the top 10 (by default) commands from the history file
# 
# The equivalent in regular Bash shell would be
# ```
# printf "\n" && history | awk '{CMD[$2]++;count++;}END { for (a in CMD)print CMD[a] " " CMD[a]/count*100 "% " a;}' | grep -v "./" | column -c3 -s " " -t | sort -nr | nl | head -n10
# ```
export def freq [
    commands: int = 10 # The number of commands to calculate
] {
    history | get command | each {|e| $e | split row -r '\s+' | first} | to text | awk '{CMD[$1]++;count++;}END { for (a in CMD)print CMD[a] " " CMD[a]/count*100 "% " a;}' | grep -v ./ | column -c3 -s " " -t | ^sort -nr | nl | head -n $commands | lines | str trim | split column -r '\s+' | rename place invocations percentage command | reject place
}

# Begin a new typing test
export def tt [] {
    ^tt -theme citylights -showwpm -quotes en -json | from json
}

# Find answers to shit on the internet using cURL and https://cheat.sh/
export def howto [
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
    let selection = ($options | str join "\n" | gum filter --placeholder "Choose a tool ..." | str trim)
    let path = ($query | str trim | str join "+")

    curl $"https://cht.sh/($selection)/($path)"
}

# list notes
export def "nb ls" [] {
    ^nb ls -l --no-footer --no-header --no-indicator
}

# view notes in rendered markdown
export def "nb view" [
    id: int # the id of the document to read
] {
    ^nb view $id -p --no-color | glow
}

# export def "nb q" [
#     --tag(-t): string # a tag to query by
# ] {
#     mut args = [search -l]

#     if ($tag | str length) > 0 {
#        $args = ($args | append $"-t ($tag)") 
#     }

#     print $args

#     ^nb ($args | str join " ")
# }

def "nu-complete code projects" [] {
    ls ~/Code/github.com/*/* | where type == dir | get name | each {|l| path split | last 2 | path join}
}

# Open the given project in a new or existing terminal tab
def "code open" [
  ...project: string@"nu-complete code projects" # the name of the project to open
] {
  if ($project | length) == 0 {
    nu-complete code projects
      | to text
      | fzf -m --bind 'ctrl-c:clear-query' --bind 'enter:become(code op {+})' --height=25% --header-border rounded --header "select code repo(s)" --header-label="open" --header-label-pos=3 --prompt "" --padding=0
    return    
  }

  ^code open ($project | str join " ")
}

# # Open the given project in a new or existing terminal tab
# export extern "code open" [
#     ...project: string@"nu-complete code projects" # the name of the project to open
# ]

alias "code op" = code open

# Custom completions for external commands (those outside of Nushell)
# Each completions has two parts: the form of the external command, including its flags and parameters
# and a helper command that knows how to complete values for those flags and parameters
def "nu-complete git branches" [] {
    ^git branch | lines | each { |line| $line | str replace '[\*\+] ' '' | str trim }
}

def "nu-complete git remotes" [] {
    ^git remote | lines | each { |line| $line | str trim }
}

# This is a simplified version of completions for git branches and git remotes
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
