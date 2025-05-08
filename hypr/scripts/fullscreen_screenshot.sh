#!/usr/bin/zsh


{
  setopt LOCAL_OPTIONS
  unsetopt HISTFILE
  unsetopt HIST_SAVEHIST
  unsetopt INC_APPEND_HISTORY

# Generate filename with timestamp
filename=~/Pictures/$(date +%Y-%m-%d_%H-%M-%S).png

# Capture fullscreen and copy it to clipboard
grim "$filename" && wl-copy < "$filename"
}
