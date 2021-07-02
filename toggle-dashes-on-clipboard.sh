#!/usr/bin/env bash

contentOnCipboard=$( pbpaste )
if [[ "$contentOnCipboard" == *" "* ]]; then
  echo $contentOnCipboard | /usr/bin/sed -e "s/ /-/g" | /usr/bin/pbcopy;
  osascript -e "say \"now it has dashes\" using \"Victoria\""
fi

if [[ "$contentOnCipboard" == *"-"* ]]; then
osascript -e "say \"removed dashes\" using \"Victoria\""
  echo $contentOnCipboard | /usr/bin/sed -e "s/-/ /g" | /usr/bin/pbcopy ;
fi

# big-natural-tit-solo-Mila-Azul-pussy-fingering-orgasm