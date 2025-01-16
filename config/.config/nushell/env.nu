
$env.GOPATH = (echo [$env.HOME go] | path join)
$env.PATH = (
    echo $env.PATH
    | prepend '/opt/homebrew/Cellar/avr-gcc@8/8.5.0/bin'
    | prepend '/opt/homebrew/opt/libpq/bin'
    | prepend '/opt/homebrew/sbin'
    | prepend '/opt/homebrew/bin'
    | append '/usr/local/bin'
    | append '/usr/local/bin/php'
    | append '/usr/local/go/bin'
    | append '/usr/local/go/bin'
    | append (echo [$env.HOME '.composer/vendor/bin'] | path join)
    | append (echo [$env.GOPATH 'bin'] | path join)
    | append (echo [$env.HOME '.bun/bin'] | path join)
)

load-env (
    fnm env --shell bash
    | lines
    | str replace 'export ' ''
    | str replace -a '"' ''
    | split column "="
    | rename name value
    | where name != "FNM_ARCH" and name != "PATH"
    | reduce -f {} {|it, acc| $acc | upsert $it.name $it.value }
)

$env.PATH = ($env.PATH | prepend [ $"($env.FNM_MULTISHELL_PATH)/bin" ])
$env.PROMPT_INDICATOR = ""
$env.PROMPT_COMMAND = {(starship prompt --cmd-duration $env.CMD_DURATION_MS $'--status=($env.LAST_EXIT_CODE)')}
$env.PROMPT_COMMAND_RIGHT = {(starship prompt --right --cmd-duration $env.CMD_DURATION_MS $'--status=($env.LAST_EXIT_CODE)')}
$env.PROMPT_INDICATOR_VI_INSERT = ([(ansi -e { fg: '#bdfe58' }) "λ + " (ansi reset)] | str join)
$env.PROMPT_INDICATOR_VI_NORMAL = ([(ansi -e { fg: '#c0c0c0' }) "λ : " (ansi reset)] | str join)
$env.PROMPT_MULTILINE_INDICATOR = ([(ansi -e { fg: '#404040' }) " |> " (ansi reset)] | str join)

$env.NU_LIB_DIRS = [
    ($nu.config-path | path dirname | path join 'scripts')
]

$env.NU_PLUGIN_DIRS = [
    ($nu.config-path | path dirname | path join 'plugins')
]

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

$env.SHELL = 'nu'
$env.EDITOR = 'hx'
$env.CLICOLOR = 1
$env.LS_COLORS = (^vivid generate darkvoid | str trim)
$env.VIMRC = '~/.vimrc'
$env.GPG_TTY = (tty | str trim)
$env.GREP_OPTIONS = '--color=auto'
$env.FZF_DEFAULT_COMMAND = 'fd --type f --hidden --follow --exclude .git'
$env.STARSHIP_SHELL = "nu"
