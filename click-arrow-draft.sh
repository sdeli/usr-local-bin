#!/usr/bin/env bash

SCREENSHOTS_FOLDER_PATH=/Users/sandordeli/Documents/screenshots
NOW_UNIX_TIME=$(date "+%s")
SCREENSHOT_FILE_NAME=screenshot_"${NOW_UNIX_TIME}".png
SCREENSHOT_FILE_PATH="${SCREENSHOTS_FOLDER_PATH}/${SCREENSHOT_FILE_NAME}"

screencapture -t png $SCREENSHOT_FILE_PATH

open -a Preview $SCREENSHOT_FILE_PATH

FRONT_WINDOWS_NAME=$(osascript <<EOF
tell application "System Events"
	set frontApp to name of first application process whose frontmost is true
end tell
if frontApp is "Preview" then
	tell application frontApp
		get name of front window
	end tell
else
	say "no"
end if
EOF
)

if [ $SCREENSHOT_FILE_NAME == $FRONT_WINDOWS_NAME ]; then
  echo "Strings are equal"
else
  echo "Strings are not equal"
fi


# echo $SCREENSHOT_FILE_PATH
# open -a /Applications/create-screenshot-open-in-preview.app
# ATTOM=$(osascript <<ADDTEXT
# tell application "System Events"
# 	set frontApp to name of first application process whose frontmost is true
# end tell

# tell application frontApp
# 	set window_name to name of front window
#   get window_name
# end tell
# ADDTEXT
# )