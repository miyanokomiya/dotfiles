#!/bin/sh

ln -snfv ~/dotfiles/.zshrc ~/.zshrc
ln -snfv ~/dotfiles/.editorconfig ~/.editorconfig

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
ln -snfv ~/dotfiles/dict ~/.config/nvim
ln -snfv ~/dotfiles/snippets ~/.config/nvim

# set up zsh
# $ brew install zsh zsh-completions

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

# ghq
# $ brew install ghq
git config --global ghq.root ~/ghq

### language-server
# $ npm install -g vue-language-server
# $ npm install -g typescript typescript-language-server
# $ pip3 install python-language-server
# $ gem install solargraph

# for rust
# $ rustup update
# $ rustup component add rls-preview
# $ rustup component add rust-src
# $ rustup component add rust-analysis
# $ rustup component add rustfmt


# .gitconfig
git config --global core.editor nvim
git config --global alias.a "add"
git config --global alias.b "branch"
git config --global alias.c "commit"
git config --global alias.ch "checkout"
git config --global alias.gr "log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit --date=relative"
git config --global alias.gra "log --graph --all --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit --date=relative"
git config --global alias.l "log"
git config --global alias.s "status"

# tmux
ln -snfv ~/dotfiles/.tmux.conf ~/.tmux.conf
if [ ! -e ~/.tmux ]; then
  mkdir -p ~/.tmux/plugins
  git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
fi
