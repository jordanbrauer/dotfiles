#!/bin/bash
# set -x

getcolor() {
  COLOR_NAME=$1
  OPACITY=$2
  local COLOR=""

  if [[ -z $OPACITY ]]; then
    OPACITY=100
  fi

  # Monium palette
  # Source of truth: helix themes/monium.toml + kitty themes/monium.conf
  COLORS=(
    blue "#3388ea"
    teal "#66b2b2"
    cyan "#6666aa"
    grey "#787876"
    green "#065905"
    yellow "#dcdc60"
    orange "#dcdc60"
    red "#a93636"
    purple "#6666aa"
    maroon "#a93636"
    black "#333331"
    trueblack "#000000"
    white "#fffffd"
  )

  # Loop through the array to find the color hex by name
  for ((i = 0; i < ${#COLORS[@]}; i += 2)); do
    if [[ "${COLORS[i]}" == "$COLOR_NAME" ]]; then
      COLOR="${COLORS[i + 1]}"
      break
    fi
  done

  # Check if color was found
  if [[ -z $COLOR ]]; then
    echo "Invalid color name: $COLOR_NAME" >&2
    return 1
  fi

  echo $(PERCENT2HEX $OPACITY)${COLOR:1}
}

PERCENT2HEX() {
  local PERCENTAGE=$1
  local DECIMAL=$(((PERCENTAGE * 255) / 100))
  printf "0x%02X\n" "$DECIMAL"
}

# Color Tokens
export BAR_COLOR=$(getcolor trueblack)
export BAR_BORDER_COLOR=$(getcolor black 0)
export HIGHLIGHT=$(getcolor cyan)
export HIGHLIGHT_75=$(getcolor cyan 75)
export HIGHLIGHT_50=$(getcolor cyan 50)
export HIGHLIGHT_25=$(getcolor cyan 25)
export HIGHLIGHT_10=$(getcolor cyan 10)
export ICON_COLOR=$(getcolor white)
export ICON_COLOR_INACTIVE=$(getcolor white 25)
export LABEL_COLOR=$(getcolor white 75)
export LABEL_COLOR_NEGATIVE=$(getcolor black)
export POPUP_BACKGROUND_COLOR=$(getcolor black 75)
export POPUP_BORDER_COLOR=$(getcolor black 0)
export SHADOW_COLOR=$(getcolor black)
export TRANSPARENT=$(getcolor black 0)

export WHITE=0xfffffffd

export BAR_COLOR=0xddbababd
export ITEM_BG_COLOR=0x00bababd
export ACCENT_COLOR=0xff333331
