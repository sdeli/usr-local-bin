#!/bin/bash
echo 'majom3' > /usr/local/bin/support-files/log_exercise.txt
gnome-terminal -e devilspie2 &
echo 'majom2' > /usr/local/bin/support-files/log_exercise.txt
gnome-terminal -e run-back-end-watch.sh &
echo 'majom22' > /usr/local/bin/support-files/log_exercise.txt
gnome-terminal -e run-front-end-watch.sh &
echo 'majom232' > /usr/local/bin/support-files/log_exercise.txt
