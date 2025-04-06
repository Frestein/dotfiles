#!/usr/bin/env dash

cliphist list | fuzzel -d -p "Clipboard " --tabs 1 | cliphist decode | wl-copy
