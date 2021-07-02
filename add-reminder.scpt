try
	set minutesFromNowReminderDialog to display dialog "minutes from now" default answer "10"
	set nameOfTask to display dialog "task description" default answer ""
on error
  delay 0.1
  say "reminder discarded" using "Victoria"
	return
end try

set secsFromNowReminder to (text returned of minutesFromNowReminderDialog) * 60

set nowUnixTime to do shell script "date +%s"
set dateTaskIsDueUnixTime to (nowUnixTime + secsFromNowReminder) as miles as string

set nameOfTask to text returned of nameOfTask

set dateTaskIsDue to do shell script "date -r " & dateTaskIsDueUnixTime & " '+%Y-%m-%d %H:%M:%S'"
get dateTaskIsDue
tell application "Reminders"
	make new reminder at end with properties {name:nameOfTask, due date:date dateTaskIsDue}
end tell

delay 0.1
say "reminder created for" & (text returned of minutesFromNowReminderDialog) & " minutes from now" using "Victoria"