#!/bin/bash

sketchybar --add item front_app left \
           --set front_app background.color=$ACCENT_COLOR \
                           background.height=20 \
                           background.corner_radius=6 \
                           icon.color=$BAR_COLOR \
                           icon.padding_left=10 \
                           icon.font="sketchybar-app-font:Regular:14.0" \
                           label.color=$BAR_COLOR \
                           script="$PLUGIN_DIR/front_app.sh" \
           --subscribe front_app front_app_switched
