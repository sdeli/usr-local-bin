
on mainEncloser()
  set languagelessonforjocci to "Hey Joci you should fire this girl finally"
  say languagelessonforjocci using "Victoria"
  set languagelessonforjocci to languagelessonforjocci & " and let it be damned"
  display alert languagelessonforjocci
  say languagelessonforjocci using "Victoria"
  get languagelessonforjocci

  set pantiguilt to "Alexanderdeli the great is apologising for your panties"
  say pantiguilt using "Victoria"
  beep 3
  say "hello world"
  say "You are not listening to me!" using "Victoria"
  display alert "Insert generic warning here."
  set myrecord to {"majom", "atom", "chipmonk"}
  get myrecord
  set item 2 of myrecord to "weird language"
  get item 1 of myrecord
  set newrecord to items 2 through 3 of myrecord
  get newrecord
  get length of newrecord
  get myrecord & newrecord

  set sandorthegreat to "sandor the great is apologizing for his slipper guilt"
  say sandorthegreat
  display alert "now listen to Victoria"
  say "it was not what it seems like" using "Victoria"

  set answer to display dialog "arou you an bear" buttons {"shut up", "are you mad?", "no I am not"}
  say button returned of answer

  set textAnswer to display dialog "enter an answer" default answer ""

  set var1 to 2
  set var2 to 2

  if var1 ­ var2 then
    display dialog "they are equal"
  else
    display dialog "they are not equal"
  end if

  repeat 3 times
    say "this is an action"
  end repeat

  set speechCounter to 0
  repeat until speechCounter = 4
    set speechCounter to speechCounter + 1
    say "counter is now" & speechCounter & "?" using "Victoria"
  end repeat

  set repeatCondition to false
  repeat until repeatCondition is true
    try
      set usersAge to display dialog "enter your age" default answer ""
      set usersAge to text returned of usersAge as number
      set repeatCondition to true
    on error
      beep 1
      display alert "you must enter a number as you age"
    end try
  end repeat
  display dialog "your age is: " & usersAge
  tell application "Finder" to get the index of Finder window "/Users/sandordeli/Desktop"
  tell application "Finder" to open "Macintosh HD:Users:sandordeli:Desktop:"
  tell application "Finder" to open "Macintosh HD:Users:sandordeli:Desktop:"
  tell application "Finder" to set the index of Finder window "/Users/sandordeli/Desktop" to 1
  tell application "Finder" to get the index of Finder window "/Users/sandordeli"

  try
    tell application "Finder" to get the index of Finder window "/Users/sandordeli/Desktop"
    tell application "Finder" to close window "/Users/sandordeli/Desktop"
    tell application "Finder" to open "Macintosh HD:Users:sandordeli:Desktop:"
    tell application "Finder" to set the index of Finder window "/Users/sandordeli/Desktop" to 1
  on error
    tell application "Finder" to open "Macintosh HD:Users:sandordeli:Desktop:"
    tell application "Finder" to set the index of Finder window "/Users/sandordeli/Desktop" to 1
  end try

  try
    tell application "Finder" to get the index of Finder window "/Applications"
    tell application "Finder" to close window "/Applications"
    tell application "Finder" to open "Macintosh HD:Applications:"
    tell application "Finder" to set the index of Finder window "/Applications" to 1
  on error
    tell application "Finder" to open "Macintosh HD:Applications:"
    tell application "Finder" to set the index of Finder window "/Applications" to 1
  end try
  tell application "Finder" to open "Macintosh HD:Applications:"
  tell application "Finder" to set the index of Finder window "/Applications" to 1
  set TheNameOfTheWindowYouSeek to "/Users/sandordeli/Desktop"

  tell application "Finder"
    set allwindows to get every window
  end tell
  get allwindows
  repeat with i in allwindows
    if i's name is TheNameOfTheWindowYouSeek then
      tell application "Finder" to close i
    end if
  end repeat

  do shell script "open /Users/sandordeli/Desktop"

  set screenshotName to "screenshot-2022.png"
  do shell script "screencapture /Users/sandordeli/Desktop/" & screenshotName
  do shell script "screencapture /Users/sandordeli/Desktop/" & screenshotName

  tell application "System Events"
  click at {242, 134} 
  end tell

  set mousePointLocation to {248, 482}

  tell application "System Events"
    set allWindows to window of processes
  end tell

  tell application Finder to get the bounds of the front window
  set windowList to {}
  tell application "System Events"
    set windowList to name of every process
  end tell

  tell application "System Events"
    get position of first window of application process fuck
  end tell

  tell application "System Events"
    set allAppNames to name of every process
  end tell

  set majom to item 6 of allAppNames

  tell application "System Events"
    #set position of first window of application process majom to {100, 100}
    get name of first window of application process majom
  end tell

  set visibleWindows to {}
  tell application "System Events"
    set listOfProcesses to (name of every process where background only is false)
  end tell

  tell application "System Events"
    #set position of first window of application process majom to {100, 100}
    repeat with visibleProcess in listOfProcesses
      set visibleWindows to visibleWindows & ", " & (get name of every window of application process visibleProcess)
    end repeat
  end tell
  get listOfProcesses

  set majom to "Electron"
  tell application "System Events"
    #set position of first window of application process majom to {100, 100}
    get position of window "window-tiling.sh Ñ usr-local-bin" of application process majom
  end tell


  set majom to "Electron"
  tell application "System Events"
    set faszom to name of every window of application process majom
    
    set idea to ""
    get faszom
    repeat with visibleProcess in faszom
      set idea to idea & ", " & visibleProcess
    end repeat
  end tell

  tell application "System Events"
    set appOfInterest to name of application process 1 whose frontmost is true
    #set position of first window of application process appOfInterest to {22, 0}
    set size of first window of application process appOfInterest to {800, 1027}
    #get properties of first window of application process appOfInterest
  end tell

  set processName to get item 2 of allVisibleProcessNames

  tell application "System Events"
    set windowsOfCurrentApp to every window of application process processName
    set windowCount to length of windowsOfCurrentApp
    if windowCount > 0 then
      set currentWindowsSize to size of item 1 of windowsOfCurrentApp
      set currentWindowsWidth to item 1 of currentWindowsSize
      
      set currentWindowsPosition to position of item 1 of windowsOfCurrentApp
      set currentWindowsLeftPos to item 1 of currentWindowsPosition
      
      if currentWindowsLeftPos = 0 then
        set currentWindowsWidth to currentWindowsWidth - 30
        set currentWindowsHeight to item 2 of currentWindowsSize
        set size of window 1 of application process processName to {currentWindowsWidth, currentWindowsHeight}
      end if
      get currentWindowsLeftPos
    end if
  end tell

  -- get windowCount
end mainEncloser

on tillSideBySideWindows(direction)
	tell application "System Events"
		set allVisibleProcessNames to name of processes whose visible is true

		repeat with processName in allVisibleProcessNames

			set windowsOfCurrentApp to every window of application process processName

			repeat with currentWindow in windowsOfCurrentApp

				set currentWindowsSize to size of currentWindow
				set currentWindowsWidth to item 1 of currentWindowsSize

				set currentWindowsPosition to position of currentWindow
				set currentWindowsLeftPos to item 1 of currentWindowsPosition

				if currentWindowsLeftPos = 0 then
					if direction = "right" then
						set currentWindowsWidth to currentWindowsWidth + 30
					else
						set currentWindowsWidth to currentWindowsWidth - 30
					end if

					set currentWindowsHeight to item 2 of currentWindowsSize
					set winName to name of currentWindow
					set size of window winName of application process processName to {currentWindowsWidth, currentWindowsHeight}
				end if

				if (currentWindowsLeftPos + currentWindowsWidth) = 1680 then
					set currentWindowsHeight to item 2 of currentWindowsSize

					if direction = "right" then
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

	get allVisibleProcessNames
end tillSideBySideWindows

-- tillSideBySideWindows("left")

    -- display dialog "The script encountered a problem.sss"

--   set answer to display dialog "arou you an bear" buttons {"shut up", "are you mad?", "no I am not"}

set theResponse to display dialog "What's your name?" default answer "" with icon note buttons {"Cancel", "Continue"} default button "Continue"
-- > {button returned:"Continue", text returned:"Jen"}
get theResponse
display dialog "Hello, " & (text returned of theResponse) & "."