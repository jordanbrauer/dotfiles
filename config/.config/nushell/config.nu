# Nushell Config File
#
# for more information on themes see
# https://www.nushell.sh/book/coloring_and_theming.html

alias cp = cp -iv
alias edit = ^($env.EDITOR)
alias less = less -FSRXc
alias mv = mv -iv
alias nvm = fnm
alias todo = todo.sh
alias cat = bat
alias vim = nvim
alias top = btm

use '~/.dotfiles/config/.config/nushell/completions.nu' * # Get just the extern definitions without the custom completion commands
use '~/.dotfiles/config/.config/nushell/jorb.nu' *
use '~/.dotfiles/config/.config/nushell/onepass.nu'
use '~/.dotfiles/config/.config/nushell/theme.nu' [CityLights]

let theme = (CityLights | get theme)
let colours = (CityLights | get colour)

# The default config record. This is where much of your global configuration is setup.
let-env config = {
  edit_mode: vi # emacs, vi
  color_config: $theme
  use_ansi_coloring: true
  use_grid_icons: true
  footer_mode: "25" # always, never, number_of_rows, auto
  float_precision: 2
  buffer_editor: "nvim" # command that will be used to edit the current line buffer with ctrl+o, if unset fallback to $env.EDITOR and $env.VISUAL
  shell_integration: true # enables terminal markers and a workaround to arrow keys stop working issue
  # A strategy of managing table view in case of limited space.
  show_banner: false # true or false to enable or disable the banner

  table: {
    mode: rounded # basic, compact, compact_double, light, thin, with_love, rounded, reinforced, heavy, none, other
    index_mode: always
    trim: {
      methodology: truncating, # truncating
      # A strategy which will be used by 'wrapping' methodology
      wrapping_try_keep_words: true,
      # A suffix which will be used with 'truncating' methodology
      truncating_suffix: "..."
    }
  }

  history: {
    max_size: 10000 # Session has to be reloaded for this to take effect
    sync_on_enter: true # Enable to share the history between multiple sessions, else you have to close the session to persist history to file
    file_format: "plaintext" # "sqlite" or "plaintext"
  }

  completions: {
    quick: false  # set this to false to prevent auto-selecting completions when only one remains
    partial: false  # set this to false to prevent partial filling of the prompt
    algorithm: "prefix"  # prefix, fuzzy
    case_sensitive: false # set to true to enable case-sensitive completions
    external: {
      enable: true # set to false to prevent nushell looking into $env.PATH to find more suggestions, `false` recommended for WSL users as this look up my be very slow
      max_results: 100 # setting it lower can improve completion performance at the cost of omitting some options
      completer: null
    }
  }

  filesize: {
    metric: false
    format: "auto" # b, kb, kib, mb, mib, gb, gib, tb, tib, pb, pib, eb, eib, zb, zib, auto
  }

  ls: {
    use_ls_colors: true
  }

  rm: {
    always_trash: false
  }

  cd: {
    abbreviations: false # set to true to allow you to do things like cd s/o/f and nushell expand it to cd some/other/folder
  }

  hooks: {
    pre_prompt: [{
        print "\n" # blank line between output & prompt
    }]
    pre_execution: [{
        print "" # blank line between output & prompt
    }]
    env_change: {
      PWD: [{|before, after|
        $nothing  # replace with source code to run if the PWD environment is different since the last repl input
      }]
    }
  }

  menus: [
      # Configuration for default nushell menus
      # Note the lack of souce parameter
      {
        name: completion_menu
        only_buffer_difference: false
        marker: ([(ansi -e { fg: $colours.Orange }) "λ | " (ansi reset)] | str collect)
        type: {
            layout: columnar
            columns: 4
            col_width: 20   # Optional value. If missing all the screen width is used to calculate column width
            col_padding: 2
        }
        style: {
            text: green
            selected_text: green_reverse
            description_text: yellow
        }
      }
      {
        name: history_menu
        only_buffer_difference: true
        marker: ([(ansi -e { fg: $colours.Yellow }) "λ ? " (ansi reset)] | str collect)
        type: {
            layout: list
            page_size: 10
        }
        style: {
            text: green
            selected_text: green_reverse
            description_text: yellow
        }
      }
      {
        name: help_menu
        only_buffer_difference: true
        marker: ([(ansi -e { fg: $colours.Yellow }) "λ ? " (ansi reset)] | str collect)
        type: {
            layout: description
            columns: 4
            col_width: 20   # Optional value. If missing all the screen width is used to calculate column width
            col_padding: 2
            selection_rows: 4
            description_rows: 10
        }
        style: {
            text: green
            selected_text: green_reverse
            description_text: yellow
        }
      }
      # Example of extra menus created using a nushell source
      # Use the source field to create a list of records that populates
      # the menu
      {
        name: commands_menu
        only_buffer_difference: false
        marker: "λ # "
        type: {
            layout: columnar
            columns: 4
            col_width: 20
            col_padding: 2
        }
        style: {
            text: green
            selected_text: green_reverse
            description_text: yellow
        }
        source: { |buffer, position|
            $nu.scope.commands
            | where command =~ $buffer
            | each { |it| {value: $it.command description: $it.usage} }
        }
      }
      {
        name: vars_menu
        only_buffer_difference: true
        marker: "λ # "
        type: {
            layout: list
            page_size: 10
        }
        style: {
            text: green
            selected_text: green_reverse
            description_text: yellow
        }
        source: { |buffer, position|
            $nu.scope.vars
            | where name =~ $buffer
            | sort-by name
            | each { |it| {value: $it.name description: $it.type} }
        }
      }
      {
        name: commands_with_description
        only_buffer_difference: true
        marker: "λ # "
        type: {
            layout: description
            columns: 4
            col_width: 20
            col_padding: 2
            selection_rows: 4
            description_rows: 10
        }
        style: {
            text: green
            selected_text: green_reverse
            description_text: yellow
        }
        source: { |buffer, position|
            $nu.scope.commands
            | where command =~ $buffer
            | each { |it| {value: $it.command description: $it.usage} }
        }
      }
  ]

  keybindings: [
    {
      name: completion_menu
      modifier: none
      keycode: tab
      mode: emacs # Options: emacs vi_normal vi_insert
      event: {
        until: [
          { send: menu name: completion_menu }
          { send: menunext }
        ]
      }
    }
    {
      name: completion_previous
      modifier: shift
      keycode: backtab
      mode: [emacs, vi_normal, vi_insert] # Note: You can add the same keybinding to all modes by using a list
      event: { send: menuprevious }
    }
    {
      name: history_menu
      modifier: control
      keycode: char_r
      mode: emacs
      event: { send: menu name: history_menu }
    }
    {
      name: next_page
      modifier: control
      keycode: char_x
      mode: emacs
      event: { send: menupagenext }
    }
    {
      name: undo_or_previous_page
      modifier: control
      keycode: char_z
      mode: emacs
      event: {
        until: [
          { send: menupageprevious }
          { edit: undo }
        ]
       }
    }
    {
      name: yank
      modifier: control
      keycode: char_y
      mode: emacs
      event: {
        until: [
          {edit: pastecutbufferafter}
        ]
      }
    }
    {
      name: unix-line-discard
      modifier: control
      keycode: char_u
      mode: [emacs, vi_normal, vi_insert]
      event: {
        until: [
          {edit: cutfromlinestart}
        ]
      }
    }
    {
      name: kill-line
      modifier: control
      keycode: char_k
      mode: [emacs, vi_normal, vi_insert]
      event: {
        until: [
          {edit: cuttolineend}
        ]
      }
    }
    # Keybindings used to trigger the user defined menus
    {
      name: commands_menu
      modifier: control
      keycode: char_t
      mode: [emacs, vi_normal, vi_insert]
      event: { send: menu name: commands_menu }
    }
    {
      name: vars_menu
      modifier: alt
      keycode: char_o
      mode: [emacs, vi_normal, vi_insert]
      event: { send: menu name: vars_menu }
    }
    {
      name: commands_with_description
      modifier: control
      keycode: char_s
      mode: [emacs, vi_normal, vi_insert]
      event: { send: menu name: commands_with_description }
    }
  ]
}

hide CityLights
