#!/usr/bin/env bash
# Open/resume a pi session in a kitty tab. Arg 1: relative session path.
set -euo pipefail

session_file="$1"
session_id=$(basename "$session_file" .jsonl | cut -d_ -f2)
cwd=$(python3 -c "
import json, os, sys
path = os.path.join(os.path.expanduser('~/.pi/agent/sessions'), sys.argv[1])
with open(path) as f:
    obj = json.loads(f.readline())
    print(obj.get('cwd', os.path.expanduser('~')))
" "$session_file")

# Check if session is already open in a kitty tab
existing=$(kitty @ ls 2>/dev/null | python3 -c "
import json, sys
try:
    data = json.load(sys.stdin)
    for w in data:
        for t in w.get('tabs', []):
            for win in t.get('windows', []):
                if '$session_id' in win.get('title', ''):
                    print(t['id']); sys.exit(0)
except: pass
" 2>/dev/null || true)

if [ -n "$existing" ]; then
    kitty @ focus-tab --match id:"$existing"
else
    kitty @ launch --type=tab --cwd="$cwd" pi --resume "$session_id"
fi
