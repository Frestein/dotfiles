#!/usr/bin/env dash

cliphist list | fuzzel -d -w 80 --with-nth 2 -p "Clipboard " --tabs 1 | cliphist decode | wl-copy
