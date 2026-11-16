#!/usr/bin/env python3
"""Preview a pi agent session. Arg 1: relative path under sessions dir."""
import json, sys, os

path = os.path.join(os.path.expanduser("~/.pi/agent/sessions"), sys.argv[1])
msgs = []
model = ""
with open(path) as f:
    for line in f:
        obj = json.loads(line)
        t = obj.get("type", "")
        if t == "session":
            print(f'  Session:  {obj.get("id", "")}')
            print(f'  Started:  {obj.get("timestamp", "")}')
            print(f'  CWD:      {obj.get("cwd", "")}')
        elif t == "model_change":
            model = obj.get("modelId", "")
            provider = obj.get("provider", "")
            print(f"  Model:    {provider}/{model}")
        elif t == "message":
            role = obj.get("message", {}).get("role", "")
            content = obj.get("message", {}).get("content", "")
            if isinstance(content, list):
                text = next((c.get("text", "") for c in content if c.get("type") == "text"), "")
            else:
                text = str(content)
            msgs.append((role, text))
            if len(msgs) >= 6:
                break
print()
for role, text in msgs:
    icon = "\u25b6" if role == "user" else "\u25c0"
    label = "USER" if role == "user" else "ASSISTANT"
    print(f"  {icon} {label}:")
    for line in text[:600].split("\n"):
        print(f"    {line}")
    print()
