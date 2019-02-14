# set -x
export PATH=~/bin:$PATH

source $HOME/.bash/bashrc_cb

# Habilita o modo vi no bash
# set -o vi

platform='unknown'
unamestr=`uname`

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
	alias ctags="`/usr/local/bin/brew --prefix`/bin/ctags"
	alias vim='mvim -vf'
	alias vi='mvim -vf'
	alias ls='ls -GFlash'
	alias vlc='/Applications/VLC.app/Contents/MacOS/VLC'
	alias audacity='/Applications/Audacity/Audacity.app/Contents/MacOS/Audacity'
	alias packages='/Applications/Packages.app/Contents/MacOS/Packages'
	alias gimp='/Applications/GIMP.app/Contents/MacOS/GIMP'
	export OS=macos
fi

# Configuração do git
if [ ! -f "$HOME/.gitconfig" ] || [ "$HOME/.bashrc" -nt "$HOME/.gitconfig" ]
then
case "$USER" in
    geraldo)
      git config --global user.name "Geraldo Ribeiro"
      git config --global user.email geraldolsribeiro@gmail.com
      git config --global core.editor vim
      git config --global merge.tool vimdiff
      ;;
    geraldoim)
      git config --global user.name "Geraldo Intmain"
      git config --global user.email geraldolsribeiroim@gmail.com
      git config --global core.editor vim
      git config --global merge.tool vimdiff
      ;;
    geraldotk)
      git config --global user.name "Geraldo Taoker"
      git config --global user.email geraldolsribeirotk@gmail.com
      git config --global core.editor vim
      git config --global merge.tool vimdiff
      ;;
  esac
fi

case "$platform" in
  linux) PS_OS_ICON="△" ;;
  macos) PS_OS_ICON="⌘" ;;
  win32) PS_OS_ICON="❖" ;;
  win64) PS_OS_ICON="❖" ;;
esac

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

# 0 – Black; 1 – Red; 2 – Green; 3 – Yellow; 4 – Blue; 5 – Magenta; 6 – Cyan; 7 – White;
RESET_COLOR="\[$(tput sgr0)\]"
GIT_COLOR="\[$(tput setab 7)$(tput setaf 1)\]"
PATH_COLOR="\[$(tput setab 2)$(tput setaf 0)\]"
HOST_COLOR="\[$(tput setab 4)$(tput setaf 7)\]"

export PS1="${PS_USER_COLOR} ${USER} ${PS_USER_ICON} ${HOST_COLOR} @\h ${PATH_COLOR} \w ${GIT_COLOR} \$(parse_git_branch) ${RESET_COLOR}\n\$ "



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

[ -f ~/.fzf.bash ] && source ~/.fzf.bash

export PATH=$PATH:/opt/intmain/dev/linux/usr/bin

export PATH=/usr/lib/icecc/bin:$PATH
export ANDROID_HOME=/usr/lib/android-sdk


alias t="todo-txt -d ~/todo/config"

alias k="vim ~/imbok/content/chapter-misc/"

export PATH=$PATH:/usr/lib/dart/bin/
export PATH="$PATH":"$HOME/.pub-cache/bin"

export EDITOR=vim
export TERM="xterm-256color"

#CDPATH=.:~:~/src:~/calculations:~/ssh_mounts

export CDPATH=.:~:~/git/Intmain

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
