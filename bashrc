alias netlex='cd /home/fox/projects/netlex/netlex/'
alias js='cd /home/fox/projects/netlex/netlex/resources/assets/js/angular/modules/'
alias views='cd /home/fox/projects/netlex/netlex/resources/views/'
alias http='cd /home/fox/projects/netlex/netlex/app/Http/'
alias app='cd /home/fox/projects/netlex/netlex/app/Http/'

alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'

if [ -f ~/.profile ]; then
  source ~/.profile
fi

# Disable ctrl+s to freeze programs:
stty -ixon

export GOPATH=~/projects/go

#export BC_ENV_ARGS
BC_ENV_ARGS=$(<<< scale=2) && export BC_ENV_ARGS
set -o vi

#export WORKDIR=`cat /home/fox/.workdir`

# For using iepy preprocessing feature.
export JAVAHOME=/usr/bin/java
export ENGLISH_SCRIPT_HOME=/home/fox/serios/workspace/english-script

export WORKON_HOME=/home/workspace/envs
export VIRTUALENVWRAPPER_PYTHON=/usr/bin/python
#source /usr/bin/virtualenvwrapper.sh

# Source global definitions
if [ -f /etc/bashrc ]; then
	source /etc/bashrc
fi

export PATH=$PATH:$HOME/.local/bin

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"
# [[ -s "$HOME/.gem/ruby/2.5.0/bin" ]] && export PATH="$PATH:$HOME/.gem/ruby/2.5.0/bin"

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"

#export PATH="$PATH:$(python -m site --user-base)/bin)"

export SVN_EDITOR=vim
export GIT_EDITOR=vim
export VISUAL=vim
export EDITOR=vim

