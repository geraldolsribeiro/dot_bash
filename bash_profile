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
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

test -e "${HOME}/.iterm2_shell_integration.bash" && source "${HOME}/.iterm2_shell_integration.bash"

# Setting PATH for Python 2.7
# The original version is saved in .bash_profile.pysave
PATH="/Library/Frameworks/Python.framework/Versions/2.7/bin:${PATH}"
export PATH

# Setting PATH for Python 2.7
# The original version is saved in .bash_profile.pysave
PATH="/Library/Frameworks/Python.framework/Versions/2.7/bin:${PATH}"
export PATH

export IBUS_ENABLE_SYNC_MODE=1

# Limpa o cache
if [ $(which ccache > /dev/null) ]; then
  ccache -C > /dev/null
fi

for d in ~/.ack ~/.vim ~/.config/ranger/ ~/.fonts ~/.clang/ ~/.tmux
do
  if [ -d "$d" ]; then
    pushd "$d"
    git pull origin master
    popd
  fi
done

