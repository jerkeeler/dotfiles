alias vim nvim
alias v nvim
alias l 'ls -lah'
alias cl clear
alias reload 'exec fish'
alias obs "cd ~/Documents/in_my_life && nvim"
alias glog "git log --oneline --graph"
alias ta "tmux attach"
alias dev "cd ~/Developer"

# git
abbr -a gs  git status -sb
abbr -a ga  git add
abbr -a gc --set-cursor 'git commit -am "%"'
abbr -a gcm git commit -m
abbr -a gco git checkout
abbr -a gp  git push
abbr -a gpl git pull
abbr -a gd  git diff
abbr -a gco git checkout
