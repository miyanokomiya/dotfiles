export PATH=$PATH:$HOME/.deno/bin
export PATH=$PATH:$HOME/.cargo/bin
export PATH=$PATH:$HOME/.rbenv/bin
eval "$(direnv hook zsh)"
eval "$(rbenv init -)"

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

# branch補完
_fzf_complete_git() {
  ARGS="$@"
  local branches
  branches=$(git branch -vv --all)
  if [[ $ARGS == 'git co'* ]]; then
    _fzf_complete "--reverse --border --multi" "$@" < <(
    echo $branches
    )
  else
    eval "zle ${fzf_default_completion:-expand-or-complete}"
  fi
}
_fzf_complete_git_post() {
  awk '{print $1}'
}

# チェックアウト
fco() {
  local tags branches target
  branches=$(
    git --no-pager branch \
      --format="%(if)%(HEAD)%(then)%(else)%(if:equals=HEAD)%(refname:strip=3)%(then)%(else)%1B[0;34;1mbranch%09%1B[m%(refname:short)%(end)%(end)" \
    | sed '/^$/d') || return
  tags=$(
    git --no-pager tag | awk '{print "\x1b[35;1mtag\x1b[m\t" $1}') || return
  target=$(
    (echo "$branches"; echo "$tags") |
    fzf --reverse --border --no-hscroll --no-multi -n 2 \
        --ansi --preview="git --no-pager log -150 --pretty=format:%s '..{2}'") || return
  git checkout $(awk '{print $2}' <<<"$target" )
}
######

alias e='nvim'
alias d='docker'
alias dc='docker-compose'
alias g='git'

# history共有
setopt share_history
# history重複無視
setopt hist_ignore_dups
HISTSIZE=5000
SAVEHIST=5000
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

# 環境固有設定用
if [ -f ~/.zshrc_local ]; then
  . ~/.zshrc_local
fi
