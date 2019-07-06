#!/bin/bash

IS_VSCODE_TERMINAL_FILE_PATH="/usr/local/bin/support-files/is_vscode_terminal.txt"

function checkIfCurrTerminalIsVscodeTerminal() {
    firstLineArr=( `head -n1 $IS_VSCODE_TERMINAL_FILE_PATH | tail -1`)
    echo ${firstLineArr[0]}
    return;
}

function renameNewTerminal() {
    bash -c 'sleep 0.1; xdotool getactivewindow set_window --name vs-terminal;' &
}

function closeOtherVsterminals() {
    wmctrl -c "vs-terminal"
}

function openCloseVsTerminal() {
    local isOpeningTerminalVscodeTerminal=$(checkIfCurrTerminalIsVscodeTerminal)
    if [ $isOpeningTerminalVscodeTerminal == 'true' ];
    then
        closeOtherVsterminals
        echo 'false' > $IS_VSCODE_TERMINAL_FILE_PATH
        renameNewTerminal
    else 
        echo 'yes2'
    fi

}

openCloseVsTerminal