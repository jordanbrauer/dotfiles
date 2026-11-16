#!/bin/zsh

mem=$(memory_pressure | awk '/^System-wide memory free percentage: /{ printf("%03d\n", 100-$5) }')

sketchybar --set memory label="${mem}%"
