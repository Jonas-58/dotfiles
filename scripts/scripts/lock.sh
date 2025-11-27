#!/bin/bash

# --- Adapta-Nokto Color Palette ---
BG="222D32"   # Deep Dark Grey (Background)
RING="00BCD4" # Cyan (The Ring)
TEXT="CFD8DC" # Light Grey (Text)
WRONG="FF5252" # Red (Wrong Password)
VERIF="00BCD4" # Cyan (Verifying)
TYPING="69F0AE" # Material Green (Key Press)

i3lock \
--color=$BG \
--inside-color=$BG \
--ring-color=$RING \
--line-uses-inside \
--keyhl-color=$TYPING \
--bshl-color=$WRONG \
--separator-color=$BG \
--verif-color=$BG \
--wrong-color=$WRONG \
--layout-color=$TEXT \
--date-color=$TEXT \
--time-color=$TEXT \
--screen 1 \
--clock \
--indicator \
--time-str="%H:%M" \
--date-str="%d.%m.%Y" \
--verif-text="Verifying..." \
--wrong-text="Wrong!" \
--no-modkey-text \
--radius=220 \
--ring-width=20 \
--time-size=110 \
--date-size=40 \
--layout-size=50 \
--verif-size=50 \
--wrong-size=50 \
--time-pos="ix:iy-20" \
--date-pos="tx:ty+110"
