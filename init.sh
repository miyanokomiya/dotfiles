#!/bin/sh

ln -snfv ~/dotfiles/.bashrc ~/.bashrc
ln -snfv ~/dotfiles/.tmux.conf ~/.tmux.conf

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
ln -snfv ~/dotfiles/.vimrc ~/.config/nvim/init.vim

ln -snfv ~/dotfiles/rplugin ~/.config/nvim

# set up neovim
# $ sudo mkdir /usr/local/Frameworks
# $ sudo chown $(whoami):admin /usr/local/Frameworks
# $ brew install python3
# $ pip3 install --upgrade neovim
# $ brew install neovim

# ag
# $ brew install the_silver_searcher

# fzf
# $ brew install fzf
# $ sh /usr/local/opt/fzf/install

# language-server
# $ npm install -g vue-language-server
# $ npm install -g typescript typescript-language-server
# $ npm install -g javascript-typescript-langserver
# $ pip3 install python-language-server
# $ gem install solargraph

# .gitconfig
git config --global alias.gr "log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit --date=relative"
git config --global alias.gra "log --graph --all --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit --date=relative"
