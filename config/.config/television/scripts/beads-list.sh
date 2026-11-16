#!/usr/bin/env bash
beads list --format json 2>/dev/null | jq -r '.[] | "\(.id)|\(.priority // "–")|\(.status)|\(.title)"'
