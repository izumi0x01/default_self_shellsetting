alias cp='cp -i'
alias mv='mv -i'
alias rm='rm -i'

for N in $(seq 10)
do 
  S='.'
  D=''
  for I in $(seq $N)
  do
    S="$S."
    D="$D../"
  done
  alias cd$S="cd $D"
done

alias c="docker-compose "
alias cup="docker-compose up"
alias cdown="docker-compose down"
alias cr="docker-compose run "
alias cx="docker-compose exec "
alias dkps="docker ps"
alias dknuke="docker system prune --volumes"

alias chrome="open -a \"Google Chrome\""

glg() { git log --pretty=format:"%C(yellow)%h %ad%Cred%d %Creset%s%Cblue [%cn]" --decorate --date=short; }
gll() { git log --pretty=format:"%C(yellow)%h%Cred%d %Creset%s%Cblue [%cn]" --decorate --numstat; }
gld() { git log --pretty=format:"%C(yellow)%h %C(green)%ad%Cred%d %Creset%s%Cblue [%cn]" --decorate --date=short --graph; }
gls() { git log --pretty=format:"%C(green)%h %C(yellow)[%ad]%Cred%d %Creset%s%Cblue [%cn]" --decorate --date=relative; }
gb() { git for-each-ref --sort='-authordate' --format='%(authordate)%09%(objectname:short)%09%(refname)' refs/heads | sed -e 's-refs/heads/--'; }

alias copy="xsel --clipboard --input"
alias paste="xsel --clipboard --output"

alias nat="nautilus $(pwd) &"

alias tm="tmux"
alias tml="tmux list-sessions"
alias tms="tmux new-session"
alias tmss="tmux new-session -s"
alias tmd="tmux detach"
alias tma="tmux attach"
alias tmat="tmux attach -t"
alias tmkt="tmux kill-session -t"
alias tmka="tmux kill-session -a"
alias tmkw="tmux kill-window"
alias tmw="tmux new-window"
alias tmwn="tmux new-window -n"
alias vsp="tmux splitw -v"
alias hsp="tmux splitw -h"