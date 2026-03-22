
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
    | append (echo [$env.HOME '.cargo/bin'] | path join)
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
$env.PROMPT_INDICATOR_VI_INSERT = ([(ansi -e { fg: '#000000' attr: b }) "λ " (ansi reset)] | str join)
$env.PROMPT_INDICATOR_VI_NORMAL = ([(ansi -e { fg: '#787876' attr: b }) "λ " (ansi reset)] | str join)
$env.PROMPT_MULTILINE_INDICATOR = ([(ansi -e { fg: '#333331' }) "|> " (ansi reset)] | str join)

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
$env.MANPAGER = "less -R --use-color -Dd+231 -Du+253 -DS+49.240"
$env.CLICOLOR = 1
$env.LS_COLORS = (^vivid generate darkvoid | str trim)
$env.VIMRC = '~/.vimrc'
$env.GPG_TTY = (tty | str trim)
$env.GREP_OPTIONS = '--color=auto'
$env.FZF_DEFAULT_COMMAND = 'fd --type f --hidden --follow --exclude .git'
$env.STARSHIP_SHELL = "nu"
$env.JQ_COLORS = "0;36:0;36:0;36:0;34:0;37:0;37:0;37:2;37"
# https://vitormv.github.io/fzf-themes#eyJib3JkZXJTdHlsZSI6InJvdW5kZWQiLCJib3JkZXJMYWJlbCI6IiIsImJvcmRlckxhYmVsUG9zaXRpb24iOjAsInByZXZpZXdCb3JkZXJTdHlsZSI6InJvdW5kZWQiLCJwYWRkaW5nIjoiMSIsIm1hcmdpbiI6IjAiLCJwcm9tcHQiOiLOuyAiLCJtYXJrZXIiOiIrIiwicG9pbnRlciI6Ij4iLCJzZXBhcmF0b3IiOiLilIAiLCJzY3JvbGxiYXIiOiJ8IiwibGF5b3V0IjoicmV2ZXJzZSIsImluZm8iOiJyaWdodCIsImNvbG9ycyI6ImZnOiMzMzMzMzEsZmcrOiNmZmZmZmQsYmc6I2JhYmFiZCxiZys6IzMzODhlYSxobDojZmZmZmZkLGhsKzojNWZkN2ZmLGluZm86IzMzMzMzMSxtYXJrZXI6Izc4Nzg3Nixwcm9tcHQ6IzAwMDAwMCxzcGlubmVyOiMwMDAwMDAscG9pbnRlcjojZmZmZmZkLGhlYWRlcjojMzMzMzMxLGd1dHRlcjojYmFiYWJkLGJvcmRlcjojMDAwMDAwLGxhYmVsOiMzYzNjM2MscXVlcnk6IzMzMzMzMSJ9
$env.FZF_DEFAULT_OPTS = '--color=fg:#333331,fg+:#fffffd,bg:#bababd,bg+:#3388ea
  --color=hl:#fffffd,hl+:#5fd7ff,info:#333331,marker:#787876
  --color=prompt:#000000,spinner:#000000,pointer:#fffffd,header:#333331
  --color=gutter:#bababd,border:#000000,label:#3c3c3c,query:#333331
  --border="rounded" --border-label="" --preview-window="border-rounded" --padding="1"
  --prompt="λ " --marker="+" --pointer=">" --separator="─"
  --scrollbar="|" --layout="reverse" --info="right"'

# $env.NAP_CONFIG = "~/.config/nap/config.yaml" # NOTE: file does not work for some reason
$env.NAP_THEME = "bw"
$env.NAP_PRIMARY_COLOR = "#1bfd9c"
$env.NAP_PRIMARY_COLOR_SUBDUED = "#303030"
$env.NAP_RED = "#dea6a0"
$env.NAP_BRIGHT_RED = "#dea6a0"
$env.NAP_GREEN = "#baffc9"
$env.NAP_BRIGHT_GREEN = "#baffc9"
$env.NAP_FOREGROUND = "#c0c0c0"
$env.NAP_BACKGROUND = "#1c1c1c"
$env.NAP_BLACK = "#1c1c1c"
$env.NAP_GRAY = "#404040"
$env.NAP_WHITE = "#d1d1d1"

zoxide init nushell | save -f ~/.zoxide.nu
