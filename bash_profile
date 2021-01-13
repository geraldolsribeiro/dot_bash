#!/bin/bash
# shellcheck disable=SC1090,SC1091

if [ -f ".bashrc" ] ; then
  source .bashrc
fi

#if [ -d "$HOME/bin" ] ; then
#  export PATH=~/bin:$PATH
#fi
#
#export PATH="/usr/local/sbin:$PATH"

source "$HOME/.bash/user-dir"

if ! shopt -oq posix; then
  # versões novas
  if [ -f /etc/profile.d/bash_completion.sh ]; then
    source /etc/profile.d/bash_completion.sh
  elif [ -f /etc/bash_completion ]; then
    source /etc/bash_completion
  fi
fi

test -e "${HOME}/.iterm2_shell_integration.bash" && source "${HOME}/.iterm2_shell_integration.bash"

# Setting PATH for Python 2.7
# The original version is saved in .bash_profile.pysave
PATH="/Library/Frameworks/Python.framework/Versions/2.7/bin:${PATH}"
export PATH

export IBUS_ENABLE_SYNC_MODE=1

# Limpa o cache
# shellcheck disable=SC2046
if [ $(command -v ccache > /dev/null) ]; then
  ccache -C > /dev/null
fi

for d in ~/.ack ~/.vim ~/.config/ranger/ ~/.fonts ~/.clang/ ~/.tmux ~/.bash ~/.local/share/nemo/
do
  if [ -d "$d" ]; then
    pushd "$d" || return
    git pull origin master
    popd || return
  fi
done

