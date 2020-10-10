#!/bin/sh

osascript <<HEREDOC
	tell application "System Events"
		set allVisibleProcessNames to name of processes whose visible is true
		
		repeat with processName in allVisibleProcessNames
			
			set windowsOfCurrentApp to every window of application process processName
			
			repeat with currentWindow in windowsOfCurrentApp
				
				set currentWindowsSize to size of currentWindow
				set currentWindowsWidth to item 1 of currentWindowsSize
				
				set currentWindowsPosition to position of currentWindow
				set currentWindowsLeftPos to item 1 of currentWindowsPosition
				
				if (currentWindowsLeftPos + currentWindowsWidth) = 1680 then
					set currentWindowsHeight to item 2 of currentWindowsSize
					
					if "$1" = "right" then
						set currentWindowsLeftPos to currentWindowsLeftPos + 30
						set currentWindowsWidth to currentWindowsWidth - 30
					else
						set currentWindowsLeftPos to currentWindowsLeftPos - 30
						set currentWindowsWidth to currentWindowsWidth + 30
					end if
					
					set winName to name of currentWindow
					set position of window winName of application process processName to {currentWindowsLeftPos, 0}
					set size of window winName of application process processName to {currentWindowsWidth, currentWindowsHeight}
					get currentWindowsWidth
				end if
			end repeat
		end repeat
	end tell
HEREDOC