# fzfセットアップ
[ -f ~/.fzf.bash ] && source ~/.fzf.bash
export FZF_DEFAULT_COMMAND='ag --hidden --ignore .git -g ""'
export FZF_CTRL_T_COMMAND=$FZF_DEFAULT_COMMAND
export FZF_DEFAULT_OPTS="--reverse --border"
# historyの重複削除
__fzf_history__() {
  if type tac > /dev/null 2>&1; then tac="tac"; else tac="tail -r"; fi
  shopt -u nocaseglob nocasematch
  echo $(HISTTIMEFORMAT= history | command $tac | sed -e 's/^ *[0-9]\{1,\}\*\{0,1\} *//' -e 's/ *$//' | awk '!a[$0]++' |
    FZF_DEFAULT_OPTS="--height ${FZF_TMUX_HEIGHT:-40%} $FZF_DEFAULT_OPTS --sync -n2..,.. --tiebreak=index --bind=ctrl-r:toggle-sort $FZF_CTRL_R_OPTS +m" $(__fzfcmd))
}
bind '"\C-r": " \C-e\C-u\C-y\ey\C-u`__fzf_history__`\e\C-e\er\e^"'

# console表示改造
# branch名
source /usr/local/etc/bash_completion.d/git-prompt.sh
source /usr/local/etc/bash_completion.d/git-completion.bash
GIT_PS1_SHOWDIRTYSTATE=true
# job数
jobscount() {
  set -- $(jobs -rp)
  set $# $(jobs -sp)
  set $1 $(($#-1))
  if [ $1 -ne 0 ] || [ $2 -ne 0 ]; then echo "[${1}r/${2}s]"; fi
}
export PS1='\W\[\033[31m\]$(__git_ps1 [%s])\[\033[00m\]$(jobscount)\$ '

alias e='nvim'
