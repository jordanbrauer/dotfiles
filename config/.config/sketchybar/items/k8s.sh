#!/bin/bash

sketchybar --add item k8s right \
           --set k8s icon=􀵲 \
                 update_freq=30 \
                 script="$PLUGIN_DIR/k8s.sh"
