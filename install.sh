#!/bin/bash

# Define the packages we want to install
PACKAGES="git stow curl zsh kitty rofi fonts-roboto fonts-inter"

echo "-------------------------------------------------"
echo "Starting Setup..."
echo "-------------------------------------------------"

# 1. Update and Install System Packages
echo "sudo needed for package installation:"
sudo apt update
sudo apt install -y $PACKAGES

# 2. Install Nerd Fonts (MesloLGS NF)
echo "-------------------------------------------------"
echo "Installing Fonts..."
mkdir -p ~/.local/share/fonts
cd ~/.local/share/fonts
# Download the Regular font (usually sufficient for Terminal)
curl -fLo "MesloLGS NF Regular.ttf" https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Regular.ttf
# Refresh font cache
fc-cache -fv
cd - > /dev/null

# 3. Install Oh My Zsh (Unattended)
if [ ! -d "$HOME/.oh-my-zsh" ]; then
    echo "-------------------------------------------------"
    echo "Installing Oh My Zsh..."
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
else
    echo "Oh My Zsh already installed."
fi

# 4. Install Powerlevel10k Theme
echo "-------------------------------------------------"
echo "Installing Powerlevel10k..."
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k 2>/dev/null || echo "Already installed."

# 5. Install Zsh Plugins (Autosuggestions & Syntax Highlighting)
echo "-------------------------------------------------"
echo "Installing Zsh Plugins..."
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions 2>/dev/null || echo "Autosuggestions already installed."
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting 2>/dev/null || echo "Syntax Highlighting already installed."

# 6. Stow Dotfiles (Link everything)
echo "-------------------------------------------------"
echo "Stowing Config Files..."
cd ~/dotfiles

# IMPORTANT: Delete existing default config files on the new machine
# so Stow doesn't fail.
rm -f ~/.zshrc
rm -rf ~/.config/kitty
rm -rf ~/.config/rofi

# Run Stow
stow kitty rofi zsh vscode

# 7. Change Default Shell to Zsh
echo "-------------------------------------------------"
echo "Changing default shell to Zsh..."
sudo chsh -s $(which zsh) $USER

echo "-------------------------------------------------"
echo "Done! Please restart your computer for changes to take effect."
