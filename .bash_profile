alias ls='ls -aFhlG'
alias ll='ls -l'
alias ..='cd ..'
alias ...='cd ../..'
alias g='git'
alias ip='echo -n `ifconfig | grep -Po "(?<=inet )\d*\.\d*\.\d*\.\d*(?=.*broadcast)"` | pbcopy'

PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting
[[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm" # Load RVM function
