#!/bin/sh
if [ ! -d ~/.cache/dein ]; then
  mkdir -p ~/.cache/dein
  cd ~/.cache/dein
  curl https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.sh > installer.sh
  sh ./installer.sh  ~/.cache/dein
fi

mkdir -p ~/.cache/dein
ln -snfv ~/dotfiles/dein/.dein.toml ~/.cache/dein/.dein.toml 
ln -snfv ~/dotfiles/dein/.dein_lazy.toml ~/.cache/dein/.dein_lazy.toml 

mkdir -p ~/.config/nvim
ln -snfv ~/.vimrc ~/.config/nvim/init.vim

# set up neovim
# $ brew install python3
# $ pip3 install --upgrade neovim
# $ brew install neovim
