export PATH=$PATH:$HOME/.deno/bin
export PATH=$PATH:$HOME/.cargo/bin
export PATH=$PATH:$HOME/.rbenv/bin
eval "$(direnv hook zsh)"
eval "$(rbenv init -)"

bindkey -r "^g"

######
# fzfセットアップ
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export FZF_DEFAULT_COMMAND='ag --hidden --ignore .git -g ""'
export FZF_DEFAULT_OPTS="--height ${FZF_TMUX_HEIGHT:-40%}"
export FZF_CTRL_T_COMMAND=$FZF_DEFAULT_COMMAND
export FZF_CTRL_T_OPTS='--reverse --border --prompt="File > " --preview "
  [[ $(file --mime {}) =~ binary ]] && echo {} is a binary file ||
  (highlight -O ansi -l {} || coderay {} || rougify {} || cat {}) 2> /dev/null | head -100"'
export FZF_CTRL_R_OPTS='--reverse --border --no-sort --prompt="History > "'

# branch取得
function select_branch() {
  local tags branches target
  branches=$(
    git --no-pager branch $1 \
      --format="%(if)%(HEAD)%(then)%(else)%(if:equals=HEAD)%(refname:strip=3)%(then)%(else)%1B[0;34;1mbranch%09%1B[m%(refname:short)%(end)%(end)" \
    | sed '/^$/d') || return
  tags=$(
    git --no-pager tag | awk '{print "\x1b[35;1mtag\x1b[m\t" $1}') || return
  target=$(
    (echo "$branches"; echo "$tags") |
    fzf --reverse --border --no-hscroll --no-multi -n 2 \
        --ansi --preview="git --no-pager log -150 --pretty=format:%s '..{2}'") || return
  awk '{print $2}' <<<"$target" | tr -d '\n'
}
function insert_selected_git_branch(){
  LBUFFER+=$(select_branch)
  CURSOR=$#LBUFFER
  zle reset-prompt
}
zle -N insert_selected_git_branch
bindkey "^gb" insert_selected_git_branch

# checkout
function fco(){
  target=$(select_branch) || return
  git checkout $target
}
function fcor(){
  target=$(select_branch '-r') || return
  git checkout $(echo $target | sed "s/origin\///")
}
function fcoa(){
  target=$(select_branch '-ra') || return
  git checkout $(echo $target | sed "s/origin\///")
}

# https://petitviolet.hatenablog.com/entry/20190708/1562544000
# git statusでunstagedなファイルのdiffみながらファイル選択
function select_file_from_git_status() {
  git status -u --short | grep -v ^M | grep -v ^A | grep -v ^D |\
    fzf -m --ansi --reverse --preview 'f() {
      local original=$@
      set -- $(echo "$@");
      if [ $(echo $original | grep -E "^M" | wc -l) -eq 1 ]; then # staged
        git diff --color --cached $2
      elif [ $(echo $original | grep -E "^\?\?" | wc -l) -eq 0 ]; then # unstaged
        git diff --color $2
      elif [ -d $2 ]; then # directory
        ls -la $2
      else
        git diff --color --no-index /dev/null $2 # untracked
      fi
    }; f {}' |\
    awk -F ' ' '{print $NF}' |
    tr '\n' ' '
}
function insert_selected_git_files(){
  LBUFFER+=$(select_file_from_git_status)
  CURSOR=$#LBUFFER
  zle reset-prompt
}
zle -N insert_selected_git_files
bindkey "^gs" insert_selected_git_files

# git logからcommitを取得
select_commit_from_git_log() {
  git log -n1000 --graph $1 --color=always --format="%C(auto)%h%d %s %C(black)%C(bold)%cr" "$@" |\
    fzf -m --ansi --no-sort --reverse --tiebreak=index --preview 'f() {
      set -- $(echo "$@" | grep -o "[a-f0-9]\{7\}" | head -1);
      if [ $1 ]; then
        git show --color $1
      else
        echo "blank"
      fi
    }; f {}' |\
    grep -o "[a-f0-9]\{7\}" |
    tr '\n' ' '
}
function insert_selected_git_log(){
  LBUFFER+=$(select_commit_from_git_log)
  CURSOR=$#LBUFFER
  zle reset-prompt
}
zle -N insert_selected_git_log
bindkey "^gl" insert_selected_git_log
function insert_selected_git_log_all(){
  LBUFFER+=$(select_commit_from_git_log '--all')
  CURSOR=$#LBUFFER
  zle reset-prompt
}
zle -N insert_selected_git_log_all
bindkey "^go" insert_selected_git_log_all
######

alias e='nvim'
alias d='docker'
alias dc='docker-compose'
alias f='fzf'
alias g='git'
alias relogin='exec $SHELL -l'
alias ls='ls -G -a'

# history共有
setopt share_history
# 余計なスペース削除
setopt hist_reduce_blanks
HISTSIZE=20000
SAVEHIST=20000
HISTFILE=~/.zsh_history

# 補完
autoload -U compinit
compinit
fpath=(/usr/local/share/zsh-completions $fpath)

# git表示
autoload -Uz vcs_info
autoload -Uz colors # black red green yellow blue magenta cyan white
colors

zstyle ':vcs_info:git:*' check-for-changes true #formats 設定項目で %c,%u が使用可
zstyle ':vcs_info:git:*' stagedstr "%F{green}!" #commit されていないファイルがある
zstyle ':vcs_info:git:*' unstagedstr "%F{magenta}+" #add されていないファイルがある
zstyle ':vcs_info:*' formats "%F{cyan}%c%u[%b]%f" #通常
zstyle ':vcs_info:*' actionformats '[%b|%a]' #rebase 途中,merge コンフリクト等 formats 外の表示
precmd () { vcs_info }

setopt prompt_subst
PROMPT='%{$fg[red]%}[%c]%{$reset_color%}'
PROMPT=$PROMPT'${vcs_info_msg_0_}%(1j.[%j].) %{${fg[red]}%}%}$%{${reset_color}%} '

function dev() {
  moveto=$(ghq root)/$(ghq list | fzf)
  cd $moveto
  # rename session if in tmux
  if [[ ! -z ${TMUX} ]]
  then
    repo_name=${moveto##*/}
    tmux rename-session ${repo_name//./-}
  fi
}

# コマンド開始終了時刻を表示
export PREV_COMMAND_END_TIME
export NEXT_COMMAND_BGN_TIME

function show_command_end_time() {
  PREV_COMMAND_END_TIME=`date "+%H:%M:%S"`
  RPROMPT="${PREV_COMMAND_END_TIME} -         "
}
autoload -Uz add-zsh-hook
add-zsh-hook precmd show_command_end_time

show_command_begin_time() {
  NEXT_COMMAND_BGN_TIME=`date "+%H:%M:%S"`
  RPROMPT="${PREV_COMMAND_END_TIME} - ${NEXT_COMMAND_BGN_TIME}"
  zle .accept-line
  zle .reset-prompt
}
zle -N accept-line show_command_begin_time

# 環境固有設定用
if [ -f ~/.zshrc_local ]; then
  . ~/.zshrc_local
fi

export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"
