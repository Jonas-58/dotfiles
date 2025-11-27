#!/bin/bash

echo "-------------------------------------------------"
echo "Applying Cinnamon Font Configuration..."
echo "-------------------------------------------------"

# 1. Default Interface Font
gsettings set org.cinnamon.desktop.interface font-name 'Roboto 10'

# 2. Desktop Icons Font
gsettings set org.nemo.desktop font 'Roboto Medium 10'

# 3. Monospace Font
gsettings set org.gnome.desktop.interface monospace-font-name 'MesloLGS NF 10'

# 4. Window Title Bar Font
gsettings set org.cinnamon.desktop.wm.preferences titlebar-font 'Roboto Bold 10'

# 5. Document Font
gsettings set org.gnome.desktop.interface document-font-name 'Roboto 10'

echo "-------------------------------------------------"
echo "Fonts set successfully!"
