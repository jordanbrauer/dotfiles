# Environment variables
set -gx GOPATH $HOME/go
set -gx SHELL (which fish)
set -gx EDITOR hx
set -gx VISUAL hx
set -gx MANPAGER "less -R --use-color -Dd+231 -Du+253 -DS+49.240"
set -gx CLICOLOR 1
set -gx VIMRC ~/.vimrc
set -gx GPG_TTY (tty)
set -gx GREP_OPTIONS --color=auto
set -gx FZF_DEFAULT_COMMAND 'fd --type f --hidden --follow --exclude .git'
set -gx JQ_COLORS "0;36:0;36:0;36:0;34:0;37:0;37:0;37:2;37"
set -gx BEADS_DIR $HOME/.beads

# LS_COLORS via vivid (monium theme)
set -gx LS_COLORS (vivid generate monium)

# FZF theme (monium palette)
set -gx FZF_DEFAULT_OPTS '--color=fg:#333331,fg+:#fffffd,bg:#bababd,bg+:#3388ea
  --color=hl:#fffffd,hl+:#5fd7ff,info:#333331,marker:#787876
  --color=prompt:#000000,spinner:#000000,pointer:#fffffd,header:#333331
  --color=gutter:#bababd,border:#000000,label:#3c3c3c,query:#333331
  --border="rounded" --border-label="" --preview-window="border-rounded" --padding="1"
  --prompt="λ " --marker="+" --pointer=">" --separator="─"
  --scrollbar="|" --layout="reverse" --info="right"'

# NAP snippet manager
set -gx NAP_THEME bw
set -gx NAP_PRIMARY_COLOR "#3388ea"
set -gx NAP_PRIMARY_COLOR_SUBDUED "#333331"
set -gx NAP_RED "#a93636"
set -gx NAP_BRIGHT_RED "#cc0000"
set -gx NAP_GREEN "#065905"
set -gx NAP_BRIGHT_GREEN "#065905"
set -gx NAP_FOREGROUND "#333331"
set -gx NAP_BACKGROUND "#bababd"
set -gx NAP_BLACK "#000000"
set -gx NAP_GRAY "#787876"
set -gx NAP_WHITE "#fffffd"
