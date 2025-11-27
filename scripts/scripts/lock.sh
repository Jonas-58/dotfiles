#!/bin/bash

# 1. Take a screenshot (Fast)
#scrot /tmp/screenshot.png

# 2. The "Scale" Trick (Fast Blur)
# We shrink it to 5% (pixelating it) then blow it back up.
#convert /tmp/screenshot.png -scale 5% -scale 2000% /tmp/screenshotblur.png

# 3. Lock
#i3lock -i /tmp/screenshotblur.png

i3lock -c 222D32 --no-unlock-indicator
