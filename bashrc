# set -x

# Ctrl-a não travar a tela
stty -ixon

export PATH=~/bin:$PATH

# shellcheck disable=SC1090
source "$HOME/.bash/bashrc_cb"

# Habilita o modo vi no bash
# set -o vi

platform='unknown'
unamestr=$(uname)

if [[ "$unamestr" == 'Linux' ]]; then
   platform='linux'
elif [[ "$unamestr" == 'Darwin' ]]; then
   platform='macos'
elif [[ "$unamestr" == 'FreeBSD' ]]; then
   platform='freebsd'
else
  echo "Not supported platform: $unamestr"
fi


if [[ $platform == 'macos' ]]; then
  alias ctags="$(/usr/local/bin/brew --prefix)/bin/ctags"
	alias vim='mvim -vf'
	alias vi='mvim -vf'
	alias ls='ls -GFlash'
	alias vlc='/Applications/VLC.app/Contents/MacOS/VLC'
	alias audacity='/Applications/Audacity/Audacity.app/Contents/MacOS/Audacity'
	alias packages='/Applications/Packages.app/Contents/MacOS/Packages'
	alias gimp='/Applications/GIMP.app/Contents/MacOS/GIMP'
	export OS=macos
fi

case "$HOSTNAME" in
  sites)
    alias bash_ubuntu='make -C /opt/docker/docker-debian-dev/ bash_ubuntu'
    alias bash_debian='make -C /opt/docker/docker-debian-dev/ bash_debian'
    alias apt_debian='make -C /opt/intmain-apt/ q_all q_sync'
    ;;
  golf.local)
    task sync
    task context str
    task
    ;;
  dionisio)
    task sync
    task context intmain
    task
    ;;
esac

# Configuração do git
if [ ! -f "$HOME/.gitconfig" ] || [ "$HOME/.bashrc" -nt "$HOME/.gitconfig" ]
then
  case "$USER" in
    "") # no docker USER não é configurado
      git config --global user.name "Geraldo Intmain"
      git config --global user.email geraldolsribeiroim@gmail.com
      ;;
    geraldo)
      git config --global user.name "Geraldo Ribeiro"
      case "$HOSTNAME" in
        golf*)
          git config --global user.email geraldo@stefaninirafael.com
          ;;
        *)
          git config --global user.email geraldolsribeiro@gmail.com
          ;;
      esac
      ;;
    geraldoim)
      git config --global user.name "Geraldo Intmain"
      git config --global user.email geraldolsribeiroim@gmail.com
      ;;
    geraldotk)
      git config --global user.name "Geraldo Taoker"
      git config --global user.email geraldolsribeirotk@gmail.com
      ;;
  esac
  git config --global core.editor vim
  git config --global merge.tool vimdiff
  #git config --global pack.threads 1
  #git config --global pack.packSizeLimit 128m
  #git config --global pack.deltaCacheSize 128m
  #git config --global pack.windowMemory 128m
  #git config --global core.packedGitLimit 128m
  #git config --global core.packedGitWindowSize 128m
fi

  # case "$platform" in
  #   linux) PS_OS_ICON="🐧" ;;
  #   macos) PS_OS_ICON="🍎" ;;
  #   win32) PS_OS_ICON="❖" ;;
  #   win64) PS_OS_ICON="❖" ;;
  # esac

  case "$USER" in
    flavia)     PS_USER_ICON="ⓕ"; PS_USER_COLOR="\[$(tput setab 2)$(tput setaf 0)\]";  ;;
    geraldo)    PS_USER_ICON="ⓖ"; PS_USER_COLOR="\[$(tput setab 2)$(tput setaf 0)\]";  ;;
    anderson)   PS_USER_ICON="ⓐ"; PS_USER_COLOR="\[$(tput setab 2)$(tput setaf 0)\]";  ;;
    geraldoim)  PS_USER_ICON="ⓘ"; PS_USER_COLOR="\[$(tput setab 2)$(tput setaf 0)\]"; ;;
    andersonim) PS_USER_ICON="ⓘ"; PS_USER_COLOR="\[$(tput setab 2)$(tput setaf 0)\]"; ;;
    geraldotk)  PS_USER_ICON="ⓣ"; PS_USER_COLOR="\[$(tput setab 2)$(tput setaf 0)\]";  ;;
    andersontk) PS_USER_ICON="ⓣ"; PS_USER_COLOR="\[$(tput setab 2)$(tput setaf 0)\]";  ;;
    miguel)     PS_USER_ICON="ⓜ"; PS_USER_COLOR="\[$(tput setab 2)$(tput setaf 0)\]";  ;;
    root)       PS_USER_ICON="♔";	 PS_USER_COLOR="\[$(tput setab 2)$(tput setaf 0)\]"; ;;
  esac


  parse_git_branch() {
    git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/'
  }

  last_cmd_status() {
    if [ $? -eq 0 ]; then
      echo "👍"
    else
      echo "🔥"
    fi
  }

  # 0 – Black; 1 – Red; 2 – Green; 3 – Yellow; 4 – Blue; 5 – Magenta; 6 – Cyan; 7 – White;
  RESET_COLOR="\[$(tput sgr0)\]"
  GIT_COLOR="\[$(tput setab 7)$(tput setaf 1)\]"
  PATH_COLOR="\[$(tput setab 2)$(tput setaf 0)\]"
  HOST_COLOR="\[$(tput setab 4)$(tput setaf 7)\]"

  export PS1="\$(last_cmd_status) ${PS_USER_COLOR} ${USER} ${PS_USER_ICON} ${HOST_COLOR} @\h ${PATH_COLOR} \w ${GIT_COLOR} \$(parse_git_branch) ${RESET_COLOR}\n\$ "



  PATH="/home/intmain/geraldoim/perl5/bin${PATH:+:${PATH}}"; export PATH;
  PERL5LIB="/home/intmain/geraldoim/perl5/lib/perl5${PERL5LIB:+:${PERL5LIB}}"; export PERL5LIB;
  PERL_LOCAL_LIB_ROOT="/home/intmain/geraldoim/perl5${PERL_LOCAL_LIB_ROOT:+:${PERL_LOCAL_LIB_ROOT}}"; export PERL_LOCAL_LIB_ROOT;
  PERL_MB_OPT="--install_base \"/home/intmain/geraldoim/perl5\""; export PERL_MB_OPT;
  PERL_MM_OPT="INSTALL_BASE=/home/intmain/geraldoim/perl5"; export PERL_MM_OPT;

  # Para encontrar as gems
  PATH="`ruby -e 'puts Gem.user_dir'`/bin:$PATH"

  if [ -d ~/.fonts ]; then
    source ~/.fonts/*.sh
  fi

  export NVM_DIR="$HOME/.nvm"
  [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
  [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

  # FZF
  # Primeira instalacao:
  #   git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
  #   ~/.fzf/install
  # Atualizacao:
  # cd ~/.fzf && git pull && ./install
  [ -f ~/.fzf.bash ] && source ~/.fzf.bash

  export PATH=$PATH:/opt/intmain/dev/linux/usr/bin

  #export PATH=/usr/lib/icecc/bin:$PATH
  export ANDROID_HOME=/usr/lib/android-sdk

  alias t="todo-txt -d ~/todo/config"

  alias k="vim ~/imbok/content/chapter-misc/"

  alias gotk="dm-tool switch-to-user geraldotk"
  alias goim="dm-tool switch-to-user geraldoim"

  export PATH="$PATH":"$HOME/.pub-cache/bin"

  export EDITOR=vim
  export TERM="xterm-256color"

  #CDPATH=.:~:~/src:~/calculations:~/ssh_mounts'

  export CDPATH=.:~:~/git/Intmain:~/git/Taoker/:~/Seafile/Books/

  # >>> conda init >>>
  # !! Contents within this block are managed by 'conda init' !!
  # __conda_setup="$(CONDA_REPORT_ERRORS=false '/opt/anaconda3/bin/conda' shell.bash hook 2> /dev/null)"
  # if [ $? -eq 0 ]; then
  #     \eval "$__conda_setup"
  # else
  #     if [ -f "/opt/anaconda3/etc/profile.d/conda.sh" ]; then
  #         . "/opt/anaconda3/etc/profile.d/conda.sh"
  #         CONDA_CHANGEPS1=false conda activate base
  #     else
  #         \export PATH="/opt/anaconda3/bin:$PATH"
  #     fi
  # fi
  # unset __conda_setup
  # <<< conda init <<<

  export FUSION_FONTS=~/.fonts/

  # para fazer a extensao pass_import ser localizado pelo pass
  # export PYTHONPATH=$PYTHONPATH:/usr/lib/python3.5/site-packages/

  for d in \
    /usr/local/go/bin \
    /usr/lib/dart/bin \
    /opt/flutter/bin \
    /usr/lib/go-1.14/bin
  do
    if [ -d "$d" ]; then
      export PATH=$PATH:$d
    fi
  done

# Navega para uma pasta no git
# Use esc para sair
function cg {
  sel=$( find ~/git -maxdepth 5 -type d |
    fzf --reverse -e -i --tiebreak=begin --prompt='Pasta no git: ' )
  [[ -z ${sel} ]] && return
  cd "$sel" || echo "Não consegui ir para ${sel}"
}

alias acksca="ack --ignore-dir=fdscacTest --ignore-dir=fdscac.code.generation"

# https://github.com/sharkdp/bat
export MANPAGER="sh -c 'col -bx | bat -l man -p'"


export NNN_BMS='d:~/Documents;g:~/git/Intmain;D:~/Downloads/'
export NNN_SSHFS="sshfs -o follow_symlinks"        # make sshfs follow symlinks on the remote
export NNN_COLORS="2136"                           # use a different color for each context
export NNN_TRASH=1                                 # trash (needs trash-cli) instead of delete
export NNN_DE_FILE_MANAGER=nemo

alias n='nnn -d'

# Para ter acesso ao libnavajo
LD_LIBRARY_PATH=/opt/intmain/dev/linux/usr/lib
