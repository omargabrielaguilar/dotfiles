#!/usr/bin/env bash

DOTFILES=$(cd $(dirname "${BASH_SOURCE[0]}") && pwd)

rm -rf $HOME/.config/alacritty
ln -s $DOTFILES/alacritty $HOME/.config/alacritty

rm -rf $HOME/.tmux.conf
ln -s $DOTFILES/tmux/tmux.conf $HOME/.tmux.conf

mkdir -p $HOME/.local/bin

rm -rf $HOME/.local/bin/t.sh
ln -s $DOTFILES/scripts/t.sh $HOME/.local/bin/t.sh

rm -rf $HOME/.config/nvim
ln -s $DOTFILES/nvim $HOME/.config/nvim

rm -rf $HOME/.config/phpactor
ln -s $DOTFILES/phpactor $HOME/.config/phpactor
