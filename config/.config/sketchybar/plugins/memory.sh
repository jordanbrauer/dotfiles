#!/bin/zsh

mem=$(memory_pressure | awk '/^System-wide memory free percentage: /{ printf("%d\n", 100-$5) }')

sketchybar --set memory label=$mem%
