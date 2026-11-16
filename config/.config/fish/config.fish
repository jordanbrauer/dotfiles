# The following lines were added by Docker Desktop to add commands to your PATH.
export PATH="$PATH:$HOME/.docker/bin"
# End of Docker Desktop section.

if status is-interactive
    set -g fish_greeting

    # Vi keybindings
    fish_vi_key_bindings

    # Keybindings
    bind \ce edit_command_buffer        # ctrl-e: edit command in $EDITOR
    bind -M insert \ce edit_command_buffer

    # Cursor shape per vi mode
    set -g fish_cursor_default block
    set -g fish_cursor_insert block
    set -g fish_cursor_replace_one block
    set -g fish_cursor_visual block

    # Monium syntax colors
    # Palette: s0=#000000 s1=#333331 s2=#5f5f5d s3=#787876
    #          s4=#a1a1a1 s5=#bababd s9=#fffffd
    #          blue=#6666aa red=#a93636 green=#065905 cursor=#3388ea
    set -g fish_color_normal        333331    # typed text
    set -g fish_color_command        333331    # recognized commands
    set -g fish_color_keyword        333331 --bold  # keywords (if, for, etc.)
    set -g fish_color_param          5f5f5d    # arguments / sub-commands
    set -g fish_color_option         5f5f5d    # --flags
    set -g fish_color_quote          5f5f5d    # 'strings'
    set -g fish_color_escape         787876    # \n, \t, etc.
    set -g fish_color_operator       787876    # pipes, &&, etc.
    set -g fish_color_end            787876    # ; and statement terminators
    set -g fish_color_redirection    787876    # > >> 2>&1
    set -g fish_color_comment        787876    # # comments
    set -g fish_color_error          a93636    # invalid input
    set -g fish_color_autosuggestion 787876    # history suggestions
    set -g fish_color_valid_path     --underline  # underline valid paths
    set -g fish_color_selection      fffffd --background=3388ea  # selection highlight
    set -g fish_color_search_match   fffffd --background=3388ea  # search matches
    set -g fish_color_cancel         a93636    # ctrl-c indicator
    set -g fish_color_cwd            333331    # current directory in default prompt
    set -g fish_color_user           333331    # username
    set -g fish_color_host           333331    # hostname
    set -g fish_color_host_remote    787876    # remote hostname (SSH)
    set -g fish_color_status         a93636    # exit code

    # Pager (tab-completion menu)
    set -g fish_pager_color_completion       333331              # completion text
    set -g fish_pager_color_description      787876 --italics    # description text
    set -g fish_pager_color_prefix           333331 --bold       # matched prefix
    set -g fish_pager_color_progress         333331 --background=d2d2d0  # progress bar
    set -g fish_pager_color_selected_background --background=3388ea
    set -g fish_pager_color_selected_completion   fffffd
    set -g fish_pager_color_selected_description  fffffd --italics
    set -g fish_pager_color_selected_prefix       fffffd --bold

    # Abbreviations — expand in-place so the full command appears in history.
    # This is the idiomatic fish alternative to aliases. When you type "cat"
    # and press space, it visibly becomes "bat" — transparent and searchable.
    abbr --add cp 'cp -iv'
    abbr --add mv 'mv -iv'
    abbr --add less 'less -FSRXc'
    abbr --add nvm fnm
    abbr --add todo todo.sh
    abbr --add cat bat
    abbr --add vim nvim
    abbr --add top btm
    abbr --add edit hx
    abbr --add rot13 "tr 'A-Za-z' 'N-ZA-Mn-za-m'"
    abbr --add co code_open

    # ZK note shortcuts
    abbr --add zke  'zk edit -i'
    abbr --add zkr  'zk recent'
    abbr --add zkl  'zk last'
    abbr --add zki  'zk index'
    abbr --add zkg  'zk graph -f json -q'

    # Source API keys (separate file, not tracked in version control)
    set -l secrets_file ~/.config/fish/secrets.fish
    if test -f $secrets_file
        source $secrets_file
    end
end

# kimi-code
fish_add_path -g "$HOME/.kimi-code/bin"

# FNM must initialize after all fish_add_path calls to take precedence over Homebrew Node.
# When enabling this, remove or comment out conf.d/fnm.fish to avoid initializing FNM twice.
# fnm env --shell fish | source

# pnpm
set -gx PNPM_HOME "$HOME/Library/pnpm"
if test "$PATH[1]" != "$PNPM_HOME/bin"
  set -gx PATH "$PNPM_HOME/bin" $PATH
end
# pnpm end
