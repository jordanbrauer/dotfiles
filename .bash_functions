# Git branch in prompt
parse_git_branch() {
    git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/'
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
