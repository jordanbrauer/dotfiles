#!/usr/bin/env python3
"""List pi agent sessions, pipe-delimited: timestamp|project|first_msg|rel_path"""
import json, os, glob

sessions_dir = os.path.expanduser("~/.pi/agent/sessions")
entries = []
for f in glob.glob(os.path.join(sessions_dir, "*", "*.jsonl")):
    rel = os.path.relpath(f, sessions_dir)
    basename = os.path.basename(f)
    ts_part = basename.split("_")[0]
    ts_display = ts_part[0:10] + " " + ts_part[11:13] + ":" + ts_part[14:16]
    cwd = first_msg = ""
    try:
        with open(f) as fh:
            for line in fh:
                obj = json.loads(line)
                if obj.get("type") == "session":
                    cwd = obj.get("cwd", "").replace(os.path.expanduser("~/"), "~/").replace(os.path.expanduser("~"), "~")
                elif obj.get("type") == "message" and obj.get("message", {}).get("role") == "user" and not first_msg:
                    content = obj["message"].get("content", "")
                    if isinstance(content, list):
                        first_msg = next((c.get("text", "") for c in content if c.get("type") == "text"), "")
                    else:
                        first_msg = str(content)
                    first_msg = first_msg[:80].replace("\n", " ").replace("\t", " ").replace("|", "/")
                    break
    except Exception:
        pass
    project = cwd.replace("~/Code/github.com/", "").replace("~/", "") or "~"
    entries.append((ts_part, ts_display, project, first_msg, rel))

entries.sort(key=lambda x: x[0], reverse=True)
for _, ts, project, msg, rel in entries:
    print(f"{ts}|{project}|{msg}|{rel}")
