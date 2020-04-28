# Set the preferred zsh layout:
prompt pure

# Stop that stupid beep (silently):
xset -b &> /dev/null
setterm -blength 0 &> /dev/null

# Load rvm default environment used by the legacy Dito projects:
source $HOME/.rvm/scripts/rvm
rvm default

alias compose='docker-compose'
alias ku='kubectl'
alias vi=vim
alias please=sudo

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:/usr/share/rvm/bin"

# Add pip packages to PATH:
export PATH="$PATH:$HOME/.local/bin"

export SVN_EDITOR=vim
export GIT_EDITOR=vim
export VISUAL=vim
export EDITOR=vim

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
