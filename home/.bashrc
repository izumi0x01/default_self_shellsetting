# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.


if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi

# 初回シェル時のみ tmux実行
if [ $SHLVL = 1 ]; then
    # tmuxのmainセッションにアタッチ
    /bin/tmux a -t main
    tmux_return=$?
    # 失敗したらmainセッションを作成
    if [ $tmux_return = 1 ]; then
        /bin/tmux new-session -s main -n tmuxの使い方 "less ~/tmux.txt"
    fi
fi

#eval "$(oh-my-posh init bash --config ~/.poshthemes/catppuccin_macchiato.omp.json)"


