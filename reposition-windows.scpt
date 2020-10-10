   on repositionWindowOnRight(direction)
	tell application "System Events"
		set allVisibleProcessNames to name of processes whose visible is true
		
		repeat with processName in allVisibleProcessNames
			
			set windowsOfCurrentApp to every window of application process processName
			
			repeat with currentWindow in windowsOfCurrentApp
				
				set currentWindowsSize to size of currentWindow
				set currentWindowsWidth to item 1 of currentWindowsSize
				
				set currentWindowsPosition to position of currentWindow
				set currentWindowsLeftPos to item 1 of currentWindowsPosition
				
				if (currentWindowsLeftPos + currentWindowsWidth) = 1680  and currentWindowsWidth < 1170 and currentWindowsWidth > 700 then
					set currentWindowsHeight to item 2 of currentWindowsSize
					
					if direction = "right" then
						set currentWindowsLeftPos to currentWindowsLeftPos + 40
						set currentWindowsWidth to currentWindowsWidth - 40
					else
						set currentWindowsLeftPos to currentWindowsLeftPos - 40
						set currentWindowsWidth to currentWindowsWidth + 40
					end if
					
					set winName to name of currentWindow
					set position of window winName of application process processName to {currentWindowsLeftPos, 0}
					set size of window winName of application process processName to {currentWindowsWidth, currentWindowsHeight}
					get currentWindowsWidth
				end if
			end repeat
		end repeat
	end tell
end tillSideBySideWindows

repositionWindowOnRight("right")

on repositionWindowOnLeft(direction)
	tell application "System Events"
		set allVisibleProcessNames to name of processes whose visible is true
		
		repeat with processName in allVisibleProcessNames
			
			set windowsOfCurrentApp to every window of application process processName
			
			repeat with currentWindow in windowsOfCurrentApp
				
				set currentWindowsSize to size of currentWindow
				set currentWindowsWidth to item 1 of currentWindowsSize
				
				set currentWindowsPosition to position of currentWindow
				set currentWindowsLeftPos to item 1 of currentWindowsPosition
				
				if currentWindowsLeftPos = 0 and currentWindowsWidth < 1170 and currentWindowsWidth > 700  then
					if direction = "right" then
						set currentWindowsWidth to currentWindowsWidth + 40
					else
						set currentWindowsWidth to currentWindowsWidth - 40
					end if
					
					set currentWindowsHeight to item 2 of currentWindowsSize
					set winName to name of currentWindow
					set size of window winName of application process processName to {currentWindowsWidth, currentWindowsHeight}
				end if
			end repeat
		end repeat
	end tell
end tillSideBySideWindows

repositionWindowOnLeft("right")