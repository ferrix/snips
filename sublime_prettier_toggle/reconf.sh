#!/bin/bash

set -e -u

FILENAME="$HOME/Library/Application\ Support/Sublime\ Text\ 3/Packages/User/JsPrettier.sublime-settings"
FILENAME="$HOME/conffi"
PARAM='"autoformat_on_save"'

TRUE='true'
FALSE='false'

## end configuration

cd $(dirname "$FILENAME")
FILENAME=$(basename "$FILENAME")

# $1 parameter name, $2 file name
function find_current_value {
  sed -n "/^[[:space:]\[{]*$1:[[:space:]]*/ s/^[[:space:]]*$1:[[:space:]]*//p" "$2" | sed -n "s/[^[:alnum:].-_ \"']*$//p;q"
}

# $1 parameter name, $2 file name, $3 new value
function reconfigure_value {
  sed -i -e "/^[[:space:]\[{]*$1:/ s/$1:[[:space:]]*[[:alnum:].-_ \"']*/$1: $3/g" "$2"
}

# $1 parameter name, $2 file name
function toggle_boolean_value {
  if [ "$(find_current_value $1 "$2")" = "false" ]; then
    echo "toggling $1 to $TRUE"
    reconfigure_value "$1" "$2" "$TRUE"
  else
    echo "toggling $1 to $FALSE"
    reconfigure_value "$1" "$2" "$FALSE"
  fi
}

toggle_boolean_value $PARAM $FILENAME
