export PS1="\n \[\033[38;5;240m\]\w\[\033[0m\] \[\033[1;36m\]@\[\033[0m\] \[\033[1;34m\]\u\[\033[0m\] \[\033[1;32m\]\$(git_hud)\[\033[0m\]\n \[\033[1;36m\]λ\[\033[0m\] "
export PS2=" \[\033[1;36m\]λ\[\033[0m\] "

export PATH="$HOME/.composer/vendor/bin:/usr/local/bin/php:$PATH"
export PATH="/usr/local/opt/python@3.7/bin:$PATH"

export CLICOLOR=1
export LSCOLORS=GxFxCxDxBxegedabagaced
export GREP_OPTIONS='--color=auto'
export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'
export BASH_SILENCE_DEPRECATION_WARNING=1 # silence the shitty zsh warning from MacOS
export EDITOR='nvim'

set -o vi

pfetch

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
alias edit=$EDITOR

# Always list directory contents upon 'cd'
cd() { 
    builtin cd "$@"
    \ls
}

# Makes new Dir and jumps inside
mcd () { 
    mkdir -p "$1" && cd "$1"; 
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
    [[ -d .git ]] && echo "ᚠ $(git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/')"
}

# list all 256 terminal colours an how they would look in your terminal
palette () {
    color=16;
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
