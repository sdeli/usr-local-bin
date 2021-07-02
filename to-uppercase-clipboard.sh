#!/usr/bin/env bash

contentOnCipboard=$( pbpaste )
osascript -e "say \"${contentOnCipboard^^}\" using \"Victoria\""
echo "${contentOnCipboard}"| tr [a-z] [A-Z] | tr '\n' ' '  | /usr/bin/pbcopy;