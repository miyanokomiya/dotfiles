#!/bin/sh
ln -sf ~/dotfiles/.vimrc ~/.vimrc
mkdir ~/.cache/dein
ln -sf ~/dotfiles/dein/.dein.toml ~/.cache/dein/.dein.toml 
ln -sf ~/dotfiles/dein/.dein_lazy.toml ~/.cache/dein/.dein_lazy.toml 

