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

npm cache clean --force

# Atualiza configuração dos programas mais utilizados
if [ ! -f ~/.git_last_update ] || [ -n "$( find ~/ -maxdepth 0 -name .git_last_update -mmin +600 )" ]; then
  touch ~/.git_last_update
  for d in \
    ~/.ack \
    ~/.bash \
    ~/.clang/ \
    ~/.config/ranger/ \
    ~/.config/zim/ \
    ~/.fonts \
    ~/.git \
    ~/.local/share/nemo/ \
    ~/.tmux \
    ~/.vim
  do
    if [ -d "$d" ]; then
      echo "Atualizando $d"
      pushd "$d" || return
      git pull origin master
      popd || return
    else
      echo "Configuração $d não encontrada"
    fi
  done
else
  echo "Configurações estão atualizadas!"
fi

# Remove arquivos objeto
# for d in ~/git/Intmain ~/git/Taoker
# do
#  echo "Limpando compilações antigas"
#  find $d -name "*.o" -delete
# done
