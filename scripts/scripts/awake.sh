#!/bin/bash
LOCK_FILE="/tmp/awake_mode"

if [ -f "$LOCK_FILE" ]; then
    # --- DEACTIVATE (Back to Normal) ---
    rm "$LOCK_FILE"

    # 1. Re-enable Screen Blanking (DPMS)
    xset +dpms
    xset s on

    # 2. Re-enable Auto-Suspend Timer (Desktop only)
    # (2>/dev/null hides error if xautolock isn't running, e.g. on laptop)
    xautolock -enable 2>/dev/null

    notify-send -u low -t 2000 "Awake Mode OFF" "Power saving is back on."
else
    # --- ACTIVATE (Coffee Mode) ---
    touch "$LOCK_FILE"

    # 1. Disable Screen Blanking
    xset -dpms
    xset s off

    # 2. Disable Auto-Suspend Timer
    xautolock -disable 2>/dev/null

    notify-send -u critical -t 3000 "Awake Mode ON" "System will stay awake forever."
fi
