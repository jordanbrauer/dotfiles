#!/usr/bin/env nu

# taken from yazelix: https://github.com/luccahuguet/yazelix/blob/4a9582266afd50b54729e691ecbb69f64be7e23e/yazi/open_file.nu#L3-L40
def is_hx_running [list_clients_output: string] {
    let cmd = $list_clients_output | str trim | str downcase
    
    # Split the command into parts
    let parts = $cmd | split row " "
    
    # Check if any part ends with 'hx' or is 'hx'
    let has_hx = ($parts | any {|part| $part | str ends-with "/hx"})
    let is_hx = ($parts | any {|part| $part == "hx"})
    let has_or_is_hx = $has_hx or $is_hx
    
    # Find the position of 'hx' in the parts
    let hx_positions = ($parts | enumerate | where {|x| ($x.item == "hx" or ($x.item | str ends-with "/hx"))} | get index)
    
    # Check if 'hx' is the first part or right after a path
    let is_hx_at_start = if ($hx_positions | is-empty) {
        false
    } else {
        let hx_position = $hx_positions.0
        $hx_position == 0 or ($hx_position > 0 and ($parts | get ($hx_position - 1) | str ends-with "/"))
    }
    
    let result = $has_or_is_hx and $is_hx_at_start
    
    # # Debug information
    # print $"input: list_clients_output = ($list_clients_output)"
    # print $"treated input: cmd = ($cmd)"
    # print $"  parts: ($parts)"
    # print $"  has_hx: ($has_hx)"
    # print $"  is_hx: ($is_hx)"
    # print $"  has_or_is_hx: ($has_or_is_hx)"
    # print $"  hx_positions: ($hx_positions)"
    # print $"  is_hx_at_start: ($is_hx_at_start)"
    # print $"  Final result: ($result)"
    # print ""
    
    $result
}

def main [file_path: path] {
    # Move focus to the next pane
    kitty @ focus-window -m neighbor:left --no-response

    let wins = kitty @ ls
        | from json
        | first
        | get tabs
        | where is_focused == true
        | first
        | get windows

    mut win = $wins
        | where is_focused == true
        | first

    let fn = $file_path | split row " " | first
    let cmdline = $win.foreground_processes.cmdline | last | str join " "

    # Check if the command running in the current pane is hx
    if (is_hx_running $cmdline) {
        $win = ^kitty @ ls
            | from json
            | first
            | get tabs
            | where is_focused == true
            | first
            | get windows
            | where is_focused == true
            | first

        let repodir = code repo view (kitty @ ls | from json | first | get tabs | where is_focused == true | first | get title) | from json | get path

        # The current pane is running hx, use zellij actions to open the file
        kitty @ send-key -m $"id:($win.id)" escape
        kitty @ send-text -m $"id:($win.id)" $":e \"($fn | str replace $repodir "" | str trim -c /)\""
        kitty @ send-key -m $"id:($win.id)" enter
    } else {
        let repodir = code repo view (kitty @ ls | from json | first | get tabs | where is_focused == true | first | get title) | from json | get path

        # The current pane is not running hx, so open hx in a new pane
        if ($wins | length) == 1 {
            kitty @ action reset_window_sizes
            kitty @ new-window --cwd $repodir
            kitty @ action move_window left
            kitty @ action resize_window wider 50

            sleep 0.2sec

            $win = ^kitty @ ls
                | from json
                | first
                | get tabs
                | where is_focused == true
                | first
                | get windows
                | where is_focused == true
                | first
        }
        
        # start helix
        kitty @ send-text -m $"id:($win.id)" $"hx ."
        kitty @ send-key -m $"id:($win.id)" enter
        sleep 0.1sec        
        
        # open target file
        kitty @ send-key -m $"id:($win.id)" escape
        kitty @ send-text -m $"id:($win.id)" $":e \"($fn | str replace $repodir "" | str trim -c /)\""
        kitty @ send-key -m $"id:($win.id)" enter
    }
}
