#!/usr/bin/env bash

DOTFILES=$(cd $(dirname "${BASH_SOURCE[0]}") && pwd)

rm -rf $HOME/.config/kitty
ln -s $DOTFILES/kitty $HOME/.config/kitty

rm -rf $HOME/.tmux.conf
ln -s $DOTFILES/tmux/tmux.conf $HOME/.tmux.conf
