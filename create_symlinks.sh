#!/bin/bash
for src in vim agignore bashrc ctags gitconfig gitignore zshrc
do
    [[ -e "$HOME/.$src" ]] || ln -s $HOME/dotfiles/$src $HOME/.$src
done
