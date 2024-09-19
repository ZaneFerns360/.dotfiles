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

if [ -L $HOME/.zshrc ]; then
    rm $HOME/.zshrc
fi

if [ -L $HOME/.wezterm.lua ]; then
    rm $HOME/.wezterm.lua
fi

# Symlink tmux to $HOME/.config/tmux

mkdir $HOME/.config/tmux
mkdir $HOME/.config/kitty
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

# Symlink .wezterm.lua to $HOME/
stow -v -S --override --target=$HOME wezterm

source $HOME/.zshrc
