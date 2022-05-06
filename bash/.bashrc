export PS1="\n \[\033[38;5;240m\]\W\[\033[0m\] \[\033[1;36m\]@\[\033[0m\] \[\033[1;34m\]\u\[\033[0m\] \[\033[1;32m\]\$(git_hud)\[\033[0m\]\n \[\033[1;36m\]λ\[\033[0m\] "
export PS2=" \[\033[1;36m\]λ\[\033[0m\] "

if [[ $(arch) == 'arm64' ]]; then
  export SHELL_ARCH="arm64"
  export PATH="/opt/homebrew/bin:/opt/homebrew/sbin:$PATH"
else
  export SHELL_ARCH="x86"
  export PATH="/usr/local/bin:/usr/local/sbin:$PATH"
fi

export PATH="$HOME/.composer/vendor/bin:/usr/local/bin/php:$PATH"
export PATH=$PATH:/usr/local/go/bin
export HISTSIZE=20000
export HISTFILESIZE=20000
export GOPATH=$HOME/go
export PATH=$PATH:$GOROOT/bin:$GOPATH/bin
export NVM_DIR="$HOME/.nvm"

export CLICOLOR=1
export LSCOLORS=GxFxCxDxBxegedabagaced
export GREP_OPTIONS='--color=auto'
export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'
export BASH_SILENCE_DEPRECATION_WARNING=1 # silence the shitty zsh warning from MacOS
export EDITOR='nvim'
export VIMRC='~/.vimrc'
export GPG_TTY=$(tty)
export PF_INFO="ascii title os host kernel uptime memory shell editor"

eval "$(/opt/homebrew/bin/brew shellenv)"
set -o vi

[[ $TERM == 'xterm-kitty' ]] && source <(kitty + complete setup bash)
[[ -f ~/.fzf.bash ]] && source ~/.fzf.bash
[[ -e ~/.phpbrew/bashrc ]] && source ~/.phpbrew/bashrc

# Improved Shell
alias ls="ls -alFhG"                        # Preferred 'ls' implementation
alias cp='cp -iv'                           # Preferred 'cp' implementation
alias mv='mv -iv'                           # Preferred 'mv' implementation
alias mkdir='mkdir -pv'                     # Preferred 'mkdir' implementation
alias less='less -FSRXc'                    # Preferred 'less' implementation
alias which='type -all'                     # Find executables
alias path='echo -e ${PATH//:/\\n}'         # Echo all executable Paths
alias tmux="tmux -f ~/.config/.tmux.conf"   # Custom Tmux config location
alias todo="todo.sh"                        # Alias todo-txt for less keystrokes
alias tt='echo $(bat ~/.dotfiles/typing.json) $(\tt -theme citylights -showwpm -quotes en -json) | jq -c -s add > ~/.dotfiles/typing.json.new && \rm -f ~/.dotfiles/typing.json && \mv ~/.dotfiles/typing.json.new ~/.dotfiles/typing.json'  # Typing test
alias wpm='expr $(bat ~/.dotfiles/typing.json | jq .[].wpm | tr "\n" "+" | sed "s/+$//" | xargs | bc) / $(bat ~/.dotfiles/typing.json | jq ". | length")' # Calculate average Words Per Minute
alias edit=$EDITOR                          # Open prefered editor
alias cheat="~/.dotfiles/cheat"             # Cheat sheet access
alias x86="arch -x86_64 /bin/bash"          # Start an x86 shell
alias sizeof="du -sh"                       # Size on disk of a file

# Print most frequently used commands
freq() {
    printf "\n" && history | awk '{CMD[$2]++;count++;}END { for (a in CMD)print CMD[a] " " CMD[a]/count*100 "% " a;}' | grep -v "./" | column -c3 -s " " -t | sort -nr | nl |  head -n10
}

# Always list directory contents upon 'cd'
cd() { 
    builtin cd "$@"
    \ls
}

# MacOS copy current working directory to clipboard
cwd() { 
    pwd | pbcopy;
}

# Moves a file to the MacOS trash
trash () {
    command mv "$@" ~/.Trash ;
}

# Opens any file in MacOS Quicklook Preview
ql () {
    qlmanage -p "$*" >& /dev/null;
}

# Search for a file using MacOS Spotlight's metadata
spotlight () {
    mdfind "kMDItemDisplayName == '$@'wc";
}

# Git branch in prompt
git_hud() {
    # [[ -d .git ]] && echo "ᚠ $(git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/')"
    git rev-parse 2> /dev/null && echo " $(git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/')"
}

# list all 256 terminal colours an how they would look in your terminal
palette () {
    color=0;
    while [ $color -lt 245 ]; do
        echo -e "$color: \\033[38;5;${color}mhello\\033[48;5;${color}mworld\\033[0m"
        ((color++));
    done;
    echo '';
    echo ' Foreground Usage:';
    echo ' \[\033[38;5;{$color}m\] hello world \[\033[0m\]';
    echo '';
    echo ' Background Usage:';
    echo ' \[\033[48;5;{$color}m\] hello world \[\033[0m\]';
}

function gi() {
    curl -sL https://www.toptal.com/developers/gitignore/api/$@; 
}

export -f gi

# Codi shell wrapper
# 
# Usage: scratch [language]
scratch() {
    local syntax="${1:-php}"
    local repl=$syntax
    local header=''
    local commands=''

    case $syntax in
        php)
            header='<?php\n\ndeclare(strict_types = 1);\n\n\n'
            commands=' | + normal G $"'
            ;;
        js | node)
            repl='javascript'
            ;;
    esac

    printf "$header" | nvim -c \
        "let g:startify_disable_at_vimenter = 1 |\
        set bt=nofile ls=0 noru nonu nornu |\
        hi ColorColumn guibg=NONE ctermbg=NONE |\
        hi VertSplit guibg=NONE ctermbg=NONE |\
        hi NonText ctermfg=0 |\
        Codi $repl$commands" -
}

function reload() {
    clear
    printf " \033[38;5;3m↻\033[0m Reloading shell configuration ...\n"
    source ~/.bashrc
    printf " \033[38;5;2m✔\033[0m Done!\n"
}

function spaces() {
    local space=$1

    [[ "" == $space ]] && {
        printf " \033[38;5;1mNo workspace was provided!\033[0m\n"

        return 1
    }

    [[ -f ~/Code/workspaces/$space ]] && ~/Code/workspaces/$space || {
        printf " \033[38;5;1mUnknown workspace:\033[0m %s\n" $space
    }
}
