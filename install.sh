#!/usr/bin/zsh

# Undo existing symlinks if they exist
if [ -d "$HOME/.config/tmux" ]; then
    rm -rf "$HOME/.config/tmux"
fi

if [ -d "$HOME/.tmux" ]; then
    rm -rf "$HOME/.tmux"
fi

# Delete the .config/kitty directory if it exists
if [ -d "$HOME/.config/kitty" ]; then
    rm -r "$HOME/.config/kitty"
fi

if [ -d "$HOME/.config/ghostty" ]; then
    rm -r "$HOME/.config/ghostty"
fi

if [ -d "$HOME/.config/hypr" ]; then
    rm -r "$HOME/.config/hypr"
fi

if [ -d "$HOME/.config/waybar" ]; then
    rm -r "$HOME/.config/waybar"
fi

if [ -d "$HOME/.config/xdg-desktop-portal" ]; then
    rm -r "$HOME/.config/xdg-desktop-portal"
fi

if [ -d "$HOME/.config/rofi" ]; then
    rm -r "$HOME/.config/rofi"
fi

if [ -d "$HOME/.config/wlogout" ]; then
    rm -r "$HOME/.config/wlogout"
fi

if [ -d "$HOME/.config/dunst" ]; then
    rm -r "$HOME/.config/dunst"
fi

if [ -d "$HOME/.config/swaync" ]; then
    rm -r "$HOME/.config/swaync"
fi

if [ -d "$HOME/.config/gBar" ]; then
    rm -r "$HOME/.config/gBar"
fi


if [ -L $HOME/.zshrc ]; then
    rm $HOME/.zshrc
fi

if [ -L $HOME/.wezterm.lua ]; then
    rm $HOME/.wezterm.lua
fi

if [ -L $HOME/.ideavimrc ]; then
    rm $HOME/.ideavimrc
fi

#if [ -L $HOME/.config/brave-flags.conf ]; then
#    rm $HOME/.config/brave-flags.conf
#fi

# Symlink tmux to $HOME/.config/tmux

mkdir $HOME/.config/tmux
mkdir $HOME/.config/kitty
mkdir $HOME/.config/ghostty
mkdir $HOME/.config/hypr
mkdir $HOME/.config/waybar
mkdir $HOME/.config/rofi
mkdir $HOME/.config/wlogout
mkdir $HOME/.config/gBar
mkdir $HOME/.config/dunst
mkdir $HOME/.config/swaync
mkdir $HOME/.config/xdg-desktop-portal

stow -v -S --target=$HOME/.config/tmux tmux

# Clone Tmux Plugin Manager (TPM)
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# Source Tmux configuration
tmux source ~/.config/tmux/tmux.conf

# Symlink .zshrc to $HOME/
stow -v -S --override --target=$HOME zsh
source $HOME/.zshrc

# Install all Tmux plugins using TPM
~/.tmux/plugins/tpm/bin/install_plugins

tmux source ~/.config/tmux/tmux.conf

# Symlink kitty to $HOME/.config/kitty
stow -v -S --target=$HOME/.config/kitty kitty

stow -v -S --target=$HOME/.config/ghostty ghostty

# Symlink hypr to $HOME/.config/hypr
stow -v -S --target=$HOME/.config/hypr hypr

# Symlink hypr to $HOME/.config/waybar
stow -v -S --target=$HOME/.config/waybar waybar

# Symlink hypr to $HOME/.config/gBar
stow -v -S --target=$HOME/.config/gBar gBar

# Symlink hypr to $HOME/.config/rofi
stow -v -S --target=$HOME/.config/rofi rofi

# Symlink hypr to $HOME/.config/wlogout
stow -v -S --target=$HOME/.config/wlogout wlogout

# Symlink hypr to $HOME/.config/dunst
stow -v -S --target=$HOME/.config/dunst dunst

# Symlink hypr to $HOME/.config/swaync
stow -v -S --target=$HOME/.config/swaync swaync

# Symlink hypr to $HOME/.config/xdg-desktop-portal
stow -v -S --target=$HOME/.config/xdg-desktop-portal xdg-desktop-portal

# Symlink .wezterm.lua to $HOME/
stow -v -S --override --target=$HOME wezterm

stow -v -S --override --target=$HOME idea

# stow -v -S --override --target=$HOME brave/brave

source $HOME/.zshrc
starship preset pure-preset -o ~/.config/starship.toml
