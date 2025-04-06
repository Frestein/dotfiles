#! /usr/bin/env sh

# This script switches between whatever sinks exist.
# Removing pulseaudio (but not libpulse) means removing pacmd, so this is an attempt at switching the default via pactl instead.

# Sinks can be specified by name or index. Index changes sometimes when you disconnect and reconnect, restart or whatever, so names are better as they are persistent.
# Annoyingly the command used to switch audio over to a new sink cannot take a name as its argument, otherwise I'd only need the name here.

# TODO: Trigger a zenity or dmenu dialog with entr that asks whether to switch monitor and/or sound to hdmi? Could do
# the same for mounting.

get_all_sinks() {
  pactl list short sinks | cut -f 2
}

get_default_sink() {
  #pw-play --list-targets | grep \* | tail -n 1 | cut -d' ' -f 2 | cut -d : -f 1
  pactl info | grep 'Default Sink' | cut -d':' -f 2
}

DEF_SINK=$(get_default_sink)
for SINK in $(get_all_sinks) ; do
  [ -z "$FIRST" ] && FIRST=$SINK # Save the first index in case the current default is the last in the list
  # get_default_sink currently returns the index with a leading space
  if [ " $SINK" = "$DEF_SINK" ]; then
    NEXT=1;
  # Subsequent pass, don't need continue above
  elif [ -n "$NEXT"  ]; then
    NEW_DEFAULT_SINK=$SINK
    break
  fi
done

# Don't particularly like this method of making it circular, but...
[ -z "$NEW_DEFAULT_SINK" ] && NEW_DEFAULT_SINK=$FIRST

# Set default sink for new audio playback
pactl set-default-sink "$NEW_DEFAULT_SINK"

notify-send --expire-time 1350 "Switched default output sink to: $NEW_DEFAULT_SINK"