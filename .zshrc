# fzfセットアップ
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export FZF_DEFAULT_COMMAND='ag --hidden --ignore .git -g ""'
export FZF_DEFAULT_OPTS="--height ${FZF_TMUX_HEIGHT:-40%}"
export FZF_CTRL_T_COMMAND=$FZF_DEFAULT_COMMAND
export FZF_CTRL_T_OPTS='--reverse --border --preview "
  [[ $(file --mime {}) =~ binary ]] && echo {} is a binary file ||
  (highlight -O ansi -l {} || coderay {} || rougify {} || cat {}) 2> /dev/null | head -100"'
export FZF_CTRL_R_OPTS='--reverse --border'

function select-history() {
  BUFFER=$(history -n -r 1 | fzf --no-sort +m --query "$LBUFFER" --prompt="History > ")
  CURSOR=$#BUFFER
}
zle -N select-history
bindkey '^r' select-history

alias e='nvim'

# history共有
setopt share_history
HISTSIZE=5000

export PATH=$PATH:$HOME/.deno/bin
export PATH=$PATH:$HOME/.cargo/bin
eval "$(direnv hook zsh)"
eval "$(rbenv init -)"

# 環境固有設定用
if [ -f ~/.zshrc_local ]; then
  . ~/.zshrc_local
fi

# 補完
autoload -U compinit
compinit

# git表示
autoload -Uz vcs_info
autoload -Uz colors # black red green yellow blue magenta cyan white
colors

setopt prompt_subst

zstyle ':vcs_info:git:*' check-for-changes true #formats 設定項目で %c,%u が使用可
zstyle ':vcs_info:git:*' stagedstr "%F{green}!" #commit されていないファイルがある
zstyle ':vcs_info:git:*' unstagedstr "%F{magenta}+" #add されていないファイルがある
zstyle ':vcs_info:*' formats "%F{cyan}%c%u(%b)%f" #通常
zstyle ':vcs_info:*' actionformats '[%b|%a]' #rebase 途中,merge コンフリクト等 formats 外の表示
precmd () { vcs_info }

PROMPT='%{$fg[red]%}[%~]%{$reset_color%}'
PROMPT=$PROMPT'${vcs_info_msg_0_} %{${fg[red]}%}%}$%{${reset_color}%} '
