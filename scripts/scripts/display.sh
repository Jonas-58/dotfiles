#!/bin/bash

# Options
normal="🖥️  Normal (TV Off)"
tv="📺  TV Mode (4K @ 60Hz)"

# Rofi Theme (Same styling as Power Menu)
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
        spacing: 0px;
    }
    listview {
        lines: 2;
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
        horizontal-align: 0.5;
        vertical-align: 0.5;
        background-color: transparent;
        text-color: inherit;
    }
'

# Pass options to Rofi
chosen="$(echo -e "$normal\n$tv" | rofi -dmenu -i -theme-str "${theme_str}")"

case $chosen in
    $normal)
        ~/.screenlayout/normal.sh
        ;;
    $tv)
        ~/.screenlayout/tv.sh
        ;;
esac
