eval "$(oh-my-posh init bash --config ~/.poshthemes/paradox.omp.json)"

# Enable tab completion of flags
source $(dirname $(gem which colorls))/tab_complete.sh

# Move standard ls
alias ols="ls"
# Base formats
alias ls="colorls -A"           # short, multi-line
alias ll="colorls -1A"          # list, 1 per line
alias ld="ll"                   # ^^^, NOTE: Trying to move to this for alternate hand commands
alias la="colorls -lA"          # list w/ info
# [d] Sort output with directories first
alias lsd="ls --sort-dirs"
alias lld="ll --sort-dirs"
alias ldd="ld --sort-dirs"
alias lad="la --sort-dirs"
# [t] Sort output with recent modified first
alias lst="ls -t"
alias llt="ll -t"
alias ldt="ld -t"
alias lat="la -t"
# [g] Add git status of each item in output
alias lsg="ls --git-status"
alias llg="ll --git-status"
alias ldg="ld --git-status"
alias lag="la --git-status"