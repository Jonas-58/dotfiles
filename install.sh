#!/bin/bash

# 1. Define Packages
# Base Utilities
BASE_PKGS="git stow curl zsh kitty rofi fonts-roboto fonts-inter imagemagick"
# i3 Window Manager & Applets
I3_PKGS="i3 i3-wm i3status suckless-tools dunst feh arandr policykit-1-gnome"
# Audio & GUI Tools
GUI_PKGS="pavucontrol pasystray scrot lxappearance qt5ct playerctl brightnessctl"
# Dependencies for building i3lock-color (The fancy lock screen)
BUILD_DEPS="autoconf gcc make pkg-config libpam0g-dev libcairo2-dev libfontconfig1-dev libxcb-composite0-dev libev-dev libx11-xcb-dev libxcb-xkb-dev libxcb-xinerama0-dev libxcb-randr0-dev libxcb-image0-dev libxcb-util-dev libxcb-xrm-dev libxkbcommon-dev libxkbcommon-x11-dev libjpeg-dev"

echo "-------------------------------------------------"
echo "Starting Setup..."
echo "-------------------------------------------------"

# 2. Install System Packages
echo "Installing Packages..."
sudo apt update
sudo apt install -y $BASE_PKGS $I3_PKGS $GUI_PKGS $BUILD_DEPS

# 3. Install Nerd Fonts (MesloLGS NF)
echo "-------------------------------------------------"
echo "Installing Fonts..."
mkdir -p ~/.local/share/fonts
cd ~/.local/share/fonts
curl -fLo "MesloLGS NF Regular.ttf" https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Regular.ttf
fc-cache -fv
cd - > /dev/null

# 4. Install Oh My Zsh (Unattended)
if [ ! -d "$HOME/.oh-my-zsh" ]; then
    echo "-------------------------------------------------"
    echo "Installing Oh My Zsh..."
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
fi

# 5. Install Powerlevel10k & Plugins
echo "-------------------------------------------------"
echo "Installing Zsh Theme & Plugins..."
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k 2>/dev/null || echo "P10k already installed."
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions 2>/dev/null || echo "Autosuggestions already installed."
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting 2>/dev/null || echo "Syntax Highlighting already installed."

# 6. Compile & Install i3lock-color
# We need this because standard i3lock doesn't support the ring colors in your script
if ! command -v i3lock-color &> /dev/null; then
    echo "-------------------------------------------------"
    echo "Building i3lock-color..."
    cd /tmp
    git clone https://github.com/Raymo111/i3lock-color.git
    cd i3lock-color
    ./install-i3lock-color.sh --noverify
    cd - > /dev/null
else
    echo "i3lock-color is already installed."
fi

# 7. Stow Dotfiles
echo "-------------------------------------------------"
echo "Stowing Config Files..."
cd ~/dotfiles

# Delete defaults to prevent conflicts
rm -f ~/.zshrc
rm -rf ~/.config/kitty
rm -rf ~/.config/rofi
rm -rf ~/.config/i3
rm -rf ~/.config/i3status

# Run Stow (Added i3, gtk, i3status)
stow kitty rofi zsh vscode scripts i3 gtk i3status

# 8. Change Default Shell
echo "-------------------------------------------------"
echo "Changing default shell to Zsh..."
sudo chsh -s $(which zsh) $USER

echo "-------------------------------------------------"
echo "Done! Please restart your computer."
echo "Note: You can run ~/scripts/setup-fonts.sh later to apply font settings."
