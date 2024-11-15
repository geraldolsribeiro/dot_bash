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

# npm cache clean --force

# Atualiza configuração dos programas mais utilizados
if [ ! -f ~/.git_last_update ] || [ -n "$( find ~/ -maxdepth 0 -name .git_last_update -mmin +600 )" ]; then
  touch ~/.git_last_update
  source ~/.bash/git_update
else
  echo "Configurações estão atualizadas!" > /dev/null
fi

# Remove arquivos objeto
# for d in ~/git/Intmain ~/git/Taoker
# do
#  echo "Limpando compilações antigas"
#  find $d -name "*.o" -delete
# done

export DENO_INSTALL="/home/geraldo/.deno"
export PATH="$DENO_INSTALL/bin:$PATH"

export GTK_THEME=Adwaita:dark


if [ -f "$HOME/.cargo/env" ]; then
. "$HOME/.cargo/env"
fi

# vim: ft=bash
. "$HOME/.cargo/env"

export QSYS_ROOTDIR="/opt/intelFPGA_lite/23.1std/quartus/sopc_builder/bin"
