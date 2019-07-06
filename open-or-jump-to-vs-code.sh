#!/bin/bash

# This script jumps you to the Visual Studio Code Editor
# If the editor is not open it should open it
# the script searches for the editor based on the name visual studio code, in the list about the open windows

# write the currently open windows list into file
function getWindowsIncludeIngVsCodeInName () {
    wmctrl -l | grep -n "Visual\sStudio\sCode" > /usr/local/bin/support-files/open-or-jump-to-vs-code-helper.txt
    notGoogleChromeWindowsDetails=$(grep -v 'Google\sChrome' /usr/local/bin/support-files/open-or-jump-to-vs-code-helper.txt)
    echo $notGoogleChromeWindowsDetails
}

function jumpToVsCode () {
    notGoogleChromeWindowsDetails=$@
    notGoogleChromeWindowsDetails=$(echo $notGoogleChromeWindowsDetails | grep -Eo 'sandor-Lenovo-Flex-2-15.+')
    pureVisualStudioCodeWindowsName="${notGoogleChromeWindowsDetails/'sandor-Lenovo-Flex-2-15'/''}"

    wmctrl -a $pureVisualStudioCodeWindowsName
}

function openVsCode () {
    code
}


# false means there are no vscode editor open
function openOrJumpToVsCode() {
    notGoogleChromeWindowsDetails=$(getWindowsIncludeIngVsCodeInName)

    if [[ $notGoogleChromeWindowsDetails != '' ]] 
    then
        jumpToVsCode $notGoogleChromeWindowsDetails
    else
        openVsCode
    fi
}

openOrJumpToVsCode