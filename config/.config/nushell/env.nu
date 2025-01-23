
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
$env.PROMPT_INDICATOR_VI_INSERT = ([(ansi -e { fg: '#bdfe58' attr: b }) "λ " (ansi reset)] | str join)
$env.PROMPT_INDICATOR_VI_NORMAL = ([(ansi -e { fg: '#c0c0c0' attr: b }) "λ " (ansi reset)] | str join)
$env.PROMPT_MULTILINE_INDICATOR = ([(ansi -e { fg: '#404040' }) "|> " (ansi reset)] | str join)

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
$env.VISUAL = 'hx'
$env.CLICOLOR = 1
$env.LS_COLORS = (^vivid generate darkvoid | str trim)
$env.VIMRC = '~/.vimrc'
$env.GPG_TTY = (tty | str trim)
$env.GREP_OPTIONS = '--color=auto'
$env.FZF_DEFAULT_COMMAND = 'fd --type f --hidden --follow --exclude .git'
$env.STARSHIP_SHELL = "nu"
$env.JQ_COLORS = "0;36:0;36:0;36:0;34:0;37:0;37:0;37:2;37"
# https://vitormv.github.io/fzf-themes#eyJib3JkZXJTdHlsZSI6InJvdW5kZWQiLCJib3JkZXJMYWJlbCI6IiIsImJvcmRlckxhYmVsUG9zaXRpb24iOjAsInByZXZpZXdCb3JkZXJTdHlsZSI6InJvdW5kZWQiLCJwYWRkaW5nIjoiIiwibWFyZ2luIjoiMCIsInByb21wdCI6Is67ICIsIm1hcmtlciI6IisiLCJwb2ludGVyIjoiPiIsInNlcGFyYXRvciI6IuKUgCIsInNjcm9sbGJhciI6InwiLCJsYXlvdXQiOiJyZXZlcnNlIiwiaW5mbyI6InJpZ2h0IiwiY29sb3JzIjoiZmc6I2MwYzBjMCxmZys6I2YxZjFmMSxiZzojMWMxYzFjLGJnKzojMWMxYzFjLGhsOiNiZGZlNTgsaGwrOiNiZGZlNTgsaW5mbzojYzBjMGMwLG1hcmtlcjojMWJmZDljLHByb21wdDojYmRmZTU4LHNwaW5uZXI6IzFiZmQ5Yyxwb2ludGVyOiNiZGZlNTgsaGVhZGVyOiNmMWYxZjEsYm9yZGVyOiM1ODU4NTgsbGFiZWw6IzNjM2MzYyxxdWVyeTojYzBjMGMwIn0=
$env.FZF_DEFAULT_OPTS = '--color=fg:#c0c0c0,fg+:#f1f1f1,bg:#1c1c1c,bg+:#1c1c1c
  --color=hl:#bdfe58,hl+:#bdfe58,info:#c0c0c0,marker:#1bfd9c
  --color=prompt:#bdfe58,spinner:#1bfd9c,pointer:#bdfe58,header:#f1f1f1
  --color=border:#585858,label:#3c3c3c,query:#c0c0c0
  --border="rounded" --border-label="" --preview-window="border-rounded" --padding=1
  --prompt="λ " --marker="+" --pointer=">" --separator="─"
  --scrollbar="|" --layout="reverse" --info="right"'
