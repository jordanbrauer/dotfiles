# Nushell Environment Config File

# To add entries to PATH (on Windows you might use Path), you can use the following pattern:
# $env.PATH = ($env.PATH | split row (char esep) | prepend '/some/path')
$env.GOPATH = (echo [$env.HOME go] | path join)
$env.PATH = (
    echo $env.PATH |
    prepend '/opt/homebrew/Cellar/avr-gcc@8/8.5.0/bin' |
    prepend '/opt/homebrew/opt/libpq/bin' |
    prepend '/opt/homebrew/sbin' |
    prepend '/opt/homebrew/bin' |
    append '/usr/local/bin' |
    append '/usr/local/bin/php' |
    append '/usr/local/go/bin' |
    append '/usr/local/go/bin' |
    append (echo [$env.HOME '.composer/vendor/bin'] | path join) | 
    # append (echo [$env.GOROOT 'bin'] | path join) | 
    append (echo [$env.GOPATH 'bin'] | path join) |
    append (echo [$env.HOME '.bun/bin'] | path join)
)
$env.CLICOLOR = 1
$env.SHELL = 'nu'
$env.EDITOR = 'hx'
$env.FZF_DEFAULT_COMMAND = 'fd --type f --hidden --follow --exclude .git'
$env.GPG_TTY = (tty | str trim)
$env.GREP_OPTIONS = '--color=auto'
$env.PF_INFO = 'ascii title os host kernel uptime memory shell editor'
$env.STARSHIP_SHELL = "nu"
$env.VIMRC = '~/.vimrc'

# Use nushell functions to define your right and left prompt
# The prompt indicators are environmental variables that represent
# the state of the prompt
def create_left_prompt [] {
    starship prompt --cmd-duration $env.CMD_DURATION_MS $'--status=($env.LAST_EXIT_CODE)'
}

def create_right_prompt [] {
    starship prompt --right --cmd-duration $env.CMD_DURATION_MS $'--status=($env.LAST_EXIT_CODE)'
}

$env.PROMPT_COMMAND = { create_left_prompt }
$env.PROMPT_COMMAND_RIGHT = { create_right_prompt }
$env.PROMPT_INDICATOR = "" # handled by Starship – https://starship.rs/
$env.PROMPT_INDICATOR_VI_INSERT = ([(ansi -e { fg: '#8bd49c' }) "λ + " (ansi reset)] | str join)
$env.PROMPT_INDICATOR_VI_NORMAL = ([(ansi -e { fg: '#5ec4ff' }) "λ : " (ansi reset)] | str join)
$env.PROMPT_MULTILINE_INDICATOR = ([(ansi -e { fg: '#41505e' }) " |> " (ansi reset)] | str join)

# Specifies how environment variables are:
# - converted from a string to a value on Nushell startup (from_string)
# - converted from a value back to a string when running external commands (to_string)
# Note: The conversions happen *after* config.nu is loaded
$env.ENV_CONVERSIONS = {
  "PATH": {
    from_string: { |s| $s | split row (char esep) | path expand -n }
    to_string: { |v| $v | path expand -n | str join (char esep) }
  }
  "Path": {
    from_string: { |s| $s | split row (char esep) | path expand -n }
    to_string: { |v| $v | path expand -n | str join (char esep) }
  }
}

# Directories to search for scripts when calling source or use
#
# By default, <nushell-config-dir>/scripts is added
$env.NU_LIB_DIRS = [
    ($nu.config-path | path dirname | path join 'scripts')
]

# Directories to search for plugin binaries when calling register
#
# By default, <nushell-config-dir>/plugins is added
$env.NU_PLUGIN_DIRS = [
    ($nu.config-path | path dirname | path join 'plugins')
]

# FNM setup
load-env (fnm env --shell bash | lines | str replace 'export ' '' | str replace -a '"' '' | split column = | rename name value | where name != "FNM_ARCH" and name != "PATH" | reduce -f {} {|it, acc| $acc | upsert $it.name $it.value })

$env.PATH = ($env.PATH | prepend [ $"($env.FNM_MULTISHELL_PATH)/bin" ])
$env.LS_COLORS = (^vivid generate citylights | str trim)
