# ----------------------------------------------------------------------
# Copyright (C) 2017-2023 Geraldo Ribeiro <geraldo@intmain.io>
# ----------------------------------------------------------------------

#   # Configuração do bash
#   
#   ## Instalação
#   
#   ```bash
#   git clone ssh://git@intmain.io:8322/geraldoim/dot_bash.git $HOME/.bash
#   ln -s $HOME/.bash/bashrc $HOME/.bashrc
#   ln -s $HOME/.bash/bash_profile $HOME/.bash_profile
#   ```
#   
#   ## Padronização dos diretórios em inglês
#   
#   O script `user-dir` configura os diretórios para inglês preservando o idioma do resto.
#   
#   ## Nota
#   
#   Após a atualização para o Debian 10 uma mensagem de erro do ruby é exibida toda
#   vez que executa o script de inicialização. Uma maneira de contornar este
#   problema é usar o ruby na versão 3.0.6 (downgrade).
#   
#   ```bash
#   gem update --system 3.0.6
#   ```

# set -x

# Ctrl-a não travar a tela
stty -ixon

setterm --powerdown 1

export PATH=~/bin:$PATH

# https://grpc.io/docs/languages/cpp/quickstart/
export MY_INSTALL_DIR=$HOME/.local
mkdir -p "$MY_INSTALL_DIR"
export PATH="$MY_INSTALL_DIR/bin:$PATH"


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
    # task sync # Atrasa a abertura do novo terminal
    # task context str
    # task
    ;;
  dionisio)
    # task sync
    # task context intmain
    # task
    ;;
esac

# Configuração do git
if [ ! -f "$HOME/.gitconfig" ] || [ "$HOME/.bash/bashrc" -nt "$HOME/.gitconfig" ]
then
  case "$USER" in
    "") # no docker USER não é configurado
      git config --global user.name "Geraldo Intmain"
      git config --global user.email "geraldolsribeiroim@gmail.com"
      ;;
    geraldo)
      git config --global user.name "Geraldo Ribeiro"
      case "$HOSTNAME" in
        geraldo*)
          git config --global user.email "geraldo.ribeiro@katim.com"
          ;;
        golf*)
          git config --global user.email "geraldo@stefaninirafael.com"
          ;;
        *)
          git config --global user.email "geraldolsribeiro@gmail.com"
          ;;
      esac
      ;;
    geraldoim)
      git config --global user.name "Geraldo Intmain"
      git config --global user.email "geraldolsribeiroim@gmail.com"
      ;;
    geraldotk)
      git config --global user.name "Geraldo Taoker"
      git config --global user.email "geraldolsribeirotk@gmail.com"
      ;;
  esac
  git config --global core.editor vim
  git config --global merge.tool vimdiff
  git config --global pull.rebase true

  # gitignore no git gui
  git config --global guitool."Add to .gitignore".cmd $'echo "\n$FILENAME" >> .gitignore & git add .gitignore'
  git config --global guitool."Add to .gitignore".needsfile yes
  git config --global guitool."Add to .gitignore".confirm yes

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

alias e='${EDITOR:-vim} $(fzf --multi)'

# calendar with week day starting on Monday
alias cal='gcal -K -s 1'

alias docker-clean=' \
  docker container prune -f ; \
  docker image prune -f ; \
  docker network prune -f ; \
  docker volume prune -f '

alias cdtil='pushd ~/git/Intmain/site-geraldo-dot-dev/src/content/til'

# shellcheck source=$HOME/.bash/pomodoro.bash
source "$HOME/.bash/pomodoro.bash"

# 0 – Black; 1 – Red; 2 – Green; 3 – Yellow; 4 – Blue; 5 – Magenta; 6 – Cyan; 7 – White;
RESET_COLOR="\[$(tput sgr0)\]"
GIT_COLOR="\[$(tput setab 7)$(tput setaf 1)\]"
PATH_COLOR="\[$(tput setab 2)$(tput setaf 0)\]"
HOST_COLOR="\[$(tput setab 4)$(tput setaf 7)\]"

export PS1="\$(last_cmd_status)\$(pomodoro_time) ${PS_USER_COLOR} ${USER}${HOST_COLOR}@\h ${PATH_COLOR} \w ${GIT_COLOR} \$(parse_git_branch) ${RESET_COLOR}\n\$ "

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

export PATH=$PATH:/opt/intmain/dev/linux/usr/bin

#export PATH=/usr/lib/icecc/bin:$PATH
export ANDROID_HOME=/usr/lib/android-sdk

alias t="todo-txt -d ~/todo/config"
alias k="vim ~/imbok/content/chapter-misc/"
alias gotk="dm-tool switch-to-user geraldotk"
alias goim="dm-tool switch-to-user geraldoim"
alias xclip="xclip -selection clipboard"
export PATH="$PATH":"$HOME/.pub-cache/bin"
export EDITOR=vim
export TERM="xterm-256color"

if [ -x /usr/bin/lsd ]; then
  alias ls='lsd'
fi

# https://github.com/sharkdp/vivid
if [ -x /usr/bin/vivid ]; then
  # To preview themes
  # for theme in $(vivid themes); do echo "Theme: $theme" LS_COLORS=$(vivid generate $theme) ls echo done
  # molokai
  export LS_COLORS="$( vivid generate one-dark )"
fi

export CDPATH=.:~:~/git/Intmain:~/git/Taoker/:~/Seafile/PileOfBooks/:~/Seafile/Books/:~/git/StefaniniRafael:~/git/github:~/Seafile/

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

# Tem uma versão do dart junto com o flutter, vou usar ela em vez do instalado no sistema
for d in \
  /opt/st/stm32cubeide_1.14.0/ \
  /home/geraldo/STMicroelectronics/STM32Cube/STM32CubeProgrammer/bin \
  /usr/local/go/bin \
  /opt/flutter/bin \
  /usr/lib/dart/bin \
  /usr/lib/go-1.14/bin \
  /opt/jabref/bin/ \
  $HOME/git/github/git-fuzzy/bin
do
  if [ -d "$d" ]; then
    export PATH=$PATH:$d
  fi
done

source ~/.bash/remind
source ~/.bash/cwd

# Navega para uma pasta no git
# Use esc para sair
function cg {
  sel=$( find ~/git -maxdepth 5 -type d |
    fzf --reverse -e -i --tiebreak=begin --prompt='Pasta no git: ' )
  [[ -z ${sel} ]] && return
  cd "$sel" || echo "Não consegui ir para ${sel}"
}

# Busca para o projeto FDSCAC
alias acksca="ack --ignore-dir=fdscacTest --ignore-dir=fdscac.code.generation"

# https://github.com/sharkdp/bat
export MANPAGER="sh -c 'col -bx | batcat -l man -p'"


export NNN_BMS='d:~/Documents;g:~/git/Intmain;D:~/Downloads/'
export NNN_SSHFS="sshfs -o follow_symlinks"        # make sshfs follow symlinks on the remote
export NNN_COLORS="2136"                           # use a different color for each context
export NNN_TRASH=1                                 # trash (needs trash-cli) instead of delete
export NNN_DE_FILE_MANAGER=nemo

alias n='nnn -d'

# Para ter acesso ao libnavajo
LD_LIBRARY_PATH=/opt/intmain/dev/linux/usr/lib

# Ajuda a debugar o git. Quebra o git gui
# export GIT_TRACE2=2
# export GIT_CURL_VERBOSE=1

alias cdmt="pushd /home/geraldo/metatrader-wine/drive_c/Program\ Files/Rico\ -\ MetaTrader\ 5/MQL5/Experts/Intmain/"
alias mt64="WINEPREFIX=/home/geraldo/metatrader-wine wine64-development /home/geraldo/metatrader-wine/drive_c/Program\ Files/Rico\ -\ MetaTrader\ 5/terminal64.exe"

# zapcc - compilador mais rápido
# git@github.com:yrnkrn/zapcc.git
export PATH=$PATH:~/git/github/llvm/build/bin/


source /etc/profile.d/bash_completion.sh

export PATH="$PATH:~/.config/rofi/bin:/snap/bin:/sbin"

# redshift alternative
# Ajusta a temperatura de cor
if [ -f /usr/bin/sct ]; then
  # for i in $(seq 6500 -100 4000)
  # do
  #   sct $i
  #   sleep 0.1
  # done
  sct 4000
fi

# Exibe uma dica aleatória
# if [ ! -d ~/git/github/til ]; then
#   mkdir -p ~/git/github/
#   git clone https://github.com/jbranchaud/til.git ~/git/github/til
# fi
# bat "$(find ~/git/github/til/ -name "*.md" | shuf -n 1)"

trap 'echo "🚧 ocorreu um erro no ${FUNCNAME:-terminal} 🚧"' ERR

if [ -f "$HOME/.cargo/env" ]; then
. "$HOME/.cargo/env"
fi


if [ -d /data/home/geraldo/arm-gnu-toolchain-12.3.rel1-x86_64-aarch64-none-linux-gnu ]; then
  export PATH=$PATH:/data/home/geraldo/arm-gnu-toolchain-12.3.rel1-x86_64-aarch64-none-linux-gnu/bin
fi

if [ -d /home/geraldo/go/deps ]; then
  export CGO_CFLAGS="-I/home/geraldo/go/deps/raft/include/ -I/home/geraldo/go/deps/cowsql/include/"
  export CGO_LDFLAGS="-L/home/geraldo/go/deps/raft/.libs -L/home/geraldo/go/deps/cowsql/.libs/"
  export LD_LIBRARY_PATH="/home/geraldo/go/deps/raft/.libs/:/home/geraldo/go/deps/cowsql/.libs/"
  export CGO_LDFLAGS_ALLOW="(-Wl,-wrap,pthread_create)|(-Wl,-z,now)"
fi
