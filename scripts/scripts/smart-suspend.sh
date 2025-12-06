#!/bin/bash

# Check for running audio streams (sink-inputs)
if pactl list sink-inputs | grep -q "Corked: no"; then
    notify-send "Suspend Blocked" "Audio is playing. Keep the vibes going!" -t 3000
    exit 0
fi

# No audio? Goodnight.
systemctl suspend
