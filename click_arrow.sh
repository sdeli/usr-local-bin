#!/usr/bin/env bash

DATE=$(date '+%Y-%m-%d_%H-%M-%S')
SCREENSHOT_FILE_NAME=screenshot_"${DATE}"
SCREENSHOT_FILE_PATH=/Users/sandordeli/Documents/screenshots/"${SCREENSHOT_FILE_NAME}"

screencapture -t jpg $SCREENSHOT_FILE_PATH
open -a Preview $SCREENSHOT_FILE_PATH

FRONT_WINDOW_NAME=`osascript -e "tell application \"Preview\" to get the name of front window"`

if [ "$SCREENSHOT_FILE_NAME" != "$FRONT_WINDOW_NAME" ]; then
  osascript -e "say \"something has gone here wrong\" using \"Victoria\""
  exit 1
fi

sleep 0.5
/Users/sandordeli/bin/cliclick c:1221,58
sleep 0.2
/Users/sandordeli/bin/cliclick c:205,98
sleep 0.2
/Users/sandordeli/bin/cliclick c:209,139
sleep 0.2
/Users/sandordeli/bin/cliclick m:787,580