#!/bin/bash

# Options
shutdown="    Shutdown"
coffee="    Awake Mode"
reboot="    Reboot"
lock="    Lock"
suspend="    Suspend"
logout="    Logout"

theme_str='
    window {
        width: 300px;
        border: 2px;
        border-color: #00BCD4;
        background-color: #222D32;
        font: "MesloLGS NF 14";
    }
    mainbox {
        children: [listview];
        background-color: #222D32;
    }
    listview {
        lines: 5;
        scrollbar: false;
        background-color: #222D32;
	border: 0px;
	spacing: 0px;
    }
    element {
        padding: 20px;
        background-color: #222D32;
        text-color: #CFD8DC;
    }
    element selected {
        background-color: #00BCD4;
        text-color: #ffffff;
        border-radius: 4px;
    }
    element-text {
        vertical-align: 0.5;   /* <--- The fix for vertical centering */
        background-color: transparent;
        text-color: inherit;
    }
'

# 3. Pass the list to Rofi
chosen="$(echo -e "$suspend\n$shutdown\n$coffee\n$reboot\n$logout\n$lock" | rofi -dmenu -theme-str "${theme_str}")"

# 4. Execute the command
case $chosen in
    $shutdown)
        systemctl poweroff
        ;;
    $reboot)
        systemctl reboot
        ;;
    $lock)
        ~/scripts/lock.sh
        ;;
    $suspend)
        ~/scripts/lock.sh && systemctl suspend
        ;;
    $logout)
        i3-msg exit
        ;;
    $coffee)
        ~/scripts/awake.sh
        ;;
esac
