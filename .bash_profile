echo '' && neofetch
source ~/.bash_functions
# source ~/git-completion.bash

# Exports
export PS1="\n \[\033[38;5;240m\]\w\[\033[0m\] \[\033[1;36m\]@\[\033[0m\] \[\033[0;34m\]\h\[\033[0m\] (\[\033[1;36m\]\u\[\033[0m\]) {\[\033[1;32m\]\$(parse_git_branch)\[\033[0m\]}\n \[\033[1;36m\]→\[\033[0m\] "
export PS2=" \[\033[1;36m\]→\[\033[0m\] "

export PATH="/usr/local/opt/icu4c/bin:$PATH"
export PATH="/usr/local/opt/icu4c/sbin:$PATH"

export CLICOLORS=1
export LSCOLORS=ExFxBxDxCxegedabagacad
export GREP_OPTIONS='--color=auto'
export PHPBREW_SET_PROMPT=0
[[ -e ~/.phpbrew/bashrc ]] && source ~/.phpbrew/bashrc

# Improved Shell
alias ls="ls -alFhG"                        # Preferred 'ls' implementation
alias lr='ls -R | grep ":$" | sed -e '\''s/:$//'\'' -e '\''s/[^-][^\/]*\//--/g'\'' -e '\''s/^/   /'\'' -e '\''s/-/|/'\'' | less'
alias cp='cp -iv'                           # Preferred 'cp' implementation
alias mv='mv -iv'                           # Preferred 'mv' implementation
alias mkdir='mkdir -pv'                     # Preferred 'mkdir' implementation
alias less='less -FSRXc'                    # Preferred 'less' implementation
alias which='type -all'                     # Find executables
alias path='echo -e ${PATH//:/\\n}'         # Echo all executable Paths

cwd() { pwd | pbcopy; }
cd() { builtin cd "$@"; ls; }               # Always list directory contents upon 'cd'
mcd () { mkdir -p "$1" && cd "$1"; }        # Makes new Dir and jumps inside
trash () { command mv "$@" ~/.Trash ; }     # Moves a file to the MacOS trash
ql () { qlmanage -p "$*" >& /dev/null; }    # Opens any file in MacOS Quicklook Preview
spotlight () { mdfind "kMDItemDisplayName == '$@'wc"; } # Search for a file using MacOS Spotlight's metadata

# Shortcut Aliases
alias composer="php -f ~/composer.phar"     # Composer
alias artisan="php -f ./artisan"            # Artisan shortcut for when lazy
alias phpd="docker-compose exec app php"
