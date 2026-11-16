# Yazi file manager with cwd tracking
# When you quit yazi, your shell cd's to wherever you navigated
function y --wraps=yazi --description "Yazi file manager with directory tracking"
    set -l tmp (mktemp -t "yazi-cwd.XXXXXX")
    yazi $argv --cwd-file $tmp

    set -l cwd (cat $tmp)
    if test -n "$cwd" -a "$cwd" != "$PWD"
        cd $cwd
    end

    rm -f $tmp
end
