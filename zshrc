# Set the preferred zsh layout:
prompt pure

# Stop that stupid beep (silently):
xset -b &> /dev/null
setterm -blength 0 &> /dev/null

# Load rvm default environment used by the legacy Dito projects:
source $HOME/.rvm/scripts/rvm
rvm default

alias compose='docker-compose'
alias vi=vim
