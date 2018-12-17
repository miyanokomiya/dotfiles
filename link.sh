#!/bin/sh
ln -snfv ~/dotfiles/.vimrc ~/.vimrc
mkdir ~/.cache/dein
ln -snfv ~/dotfiles/dein/.dein.toml ~/.cache/dein/.dein.toml 
ln -snfv ~/dotfiles/dein/.dein_lazy.toml ~/.cache/dein/.dein_lazy.toml 
mkdir ~/.config/nvim
ln -snfv ~/.vim ~/.config/nvim/
ln -snfv ~/.vimrc ~/.config/nvim/init.vim

