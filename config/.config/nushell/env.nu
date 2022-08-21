# Nushell Environment Config File

# To add entries to PATH (on Windows you might use Path), you can use the following pattern:
# let-env PATH = ($env.PATH | split row (char esep) | prepend '/some/path')
let-env CLICOLOR = 1
let-env GREP_OPTIONS = '--color=auto'
let-env FZF_DEFAULT_COMMAND = 'fd --type f --hidden --follow --exclude .git'
let-env EDITOR = 'nvim'
let-env VIMRC = '~/.vimrc'
let-env GPG_TTY = (tty)
let-env PF_INFO = 'ascii title os host kernel uptime memory shell editor'
let-env STARSHIP_SHELL = "nu"
let-env GOPATH = (echo [$env.HOME go] | path join)
let-env PATH = (
    echo $env.PATH |
    prepend '/opt/homebrew/sbin' |
    prepend '/opt/homebrew/bin' |
    append '/usr/local/bin' |
    append '/usr/local/bin/php' |
    append '/usr/local/go/bin' |
    append '/usr/local/go/bin' |
    append (echo [$env.HOME '.composer/vendor/bin'] | path join) | 
    # append (echo [$env.GOROOT 'bin'] | path join) | 
    append (echo [$env.GOPATH 'bin'] | path join)
)

def create_left_prompt [] {
    starship prompt --cmd-duration $env.CMD_DURATION_MS $'--status=($env.LAST_EXIT_CODE)'
}

def create_right_prompt [] {
    starship prompt --right --cmd-duration $env.CMD_DURATION_MS $'--status=($env.LAST_EXIT_CODE)'
}

# Use nushell functions to define your right and left prompt
let-env PROMPT_COMMAND = { create_left_prompt }
let-env PROMPT_COMMAND_RIGHT = { create_right_prompt }

# The prompt indicators are environmental variables that represent
# the state of the prompt
let-env PROMPT_INDICATOR = ""
let-env PROMPT_INDICATOR_VI_INSERT = "+ "
let-env PROMPT_INDICATOR_VI_NORMAL = ": " 
let-env PROMPT_MULTILINE_INDICATOR = " > "

# Specifies how environment variables are:
# - converted from a string to a value on Nushell startup (from_string)
# - converted from a value back to a string when running external commands (to_string)
# Note: The conversions happen *after* config.nu is loaded
let-env ENV_CONVERSIONS = {
  "PATH": {
    from_string: { |s| $s | split row (char esep) | path expand -n }
    to_string: { |v| $v | path expand -n | str collect (char esep) }
  }
  "Path": {
    from_string: { |s| $s | split row (char esep) | path expand -n }
    to_string: { |v| $v | path expand -n | str collect (char esep) }
  }
}

# Directories to search for scripts when calling source or use
#
# By default, <nushell-config-dir>/scripts is added
let-env NU_LIB_DIRS = [
    ($nu.config-path | path dirname | path join 'scripts')
]

# Directories to search for plugin binaries when calling register
#
# By default, <nushell-config-dir>/plugins is added
let-env NU_PLUGIN_DIRS = [
    ($nu.config-path | path dirname | path join 'plugins')
]
