#start with some suphys stuff
# exec default bashrc
if [ -f /etc/bashrc ]; then
        . /etc/bashrc
fi
if [ "$TERM" = rxvt-unicode-256color ]
then
    export TERM=rxvt
fi
# add custom physics path
#export MANPATH=~/.local/man:/usr/physics/man:$MANPATH

# no coredumps in home
ulimit -S -c 0

# default umask
umask 022

# disable autologout
unset autologout
export EDITOR=vim
export BROWSER=chromium
export PATH=~/.local/bin:~/.local/sbin:~/.cabal/bin:~/android-ndk:/opt/android-sdk/platform-tools:$PATH:/torque/bin:/torque/sbin:/usr/physics/bin:~/.gem/ruby/2.2.0/bin:/usr/local/maui/bin:/usr/local/maui/sbin
export LD_LIBRARY_PATH=".:${HOME}/.local/lib"
export PKG_CONFIG_PATH=~/.local/lib/pkgconfig:/usr/lib/pkgconfig:/usr/lib64/pkgconfig:/usr/share/pkgconfig
# set ICT proxy 
#HTTP_PROXY=http://web-cache.usyd.edu.au:8080
#export http_proxy=$HTTP_PROXY
#export HTTPS_PROXY=$HTTP_PROXY
#export https_proxy=$HTTP_PROXY
#export all_proxy=$HTTP_PROXY
#export ALL_PROXY=$HTTP_PROXY
# no duplicate lines in the history
HISTCONTROL=ignoredups:ignorespace

# append to the history file, no overwrite
shopt -s histappend

# history length
HISTSIZE=100000000
HISTFILESIZE=200000000




# Change default printer in current shell and new shells

# NOTE: echo-ing anything breaks scp

# USER CUSTOM SETTINGS BELOW #
#make mono find dlls properly
export LD_LIBRARY_PATH=.:~/.local/lib:~/.local/lib64
export LD_RUN_PATH=.:~/.local/lib
export LIBRARY_PATH=~/.local/lib
export CPATH=~/.local/include
export PROMPT_COMMAND=''
LESSOPEN="|lesspipe.sh %s"; export LESSOPEN

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set a color prompt
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

bg="$(tput setab 3)"
red="$(tput setaf 1)"
blue="$(tput setaf 4)"
reset="$(tput sgr0)"
ps1prefix=""
ps1postfix=""

alias nmatlab='matlab -nodesktop -nosplash'
#export PS1='$ps1prefix\[$reset$bg\]'"\h"'\[$red\]'" \w "'\[$blue\] $(__git_ps1 "%s") $($ps1postfix) \[$reset\]\$'
[[ -f ~/dotfiles/`hostname -s` ]]                                    && source ~/dotfiles/`hostname -s`


#not sure what any of the escape codes do - important bit is the __git_ps1 to show branch
# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi
#spelling aliases
alias got='git'
alias ci='vim'
alias ks='ls'
alias ake='make'
alias nake='make'
alias naje='make'
alias sl='ls'
# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
#My aliases
#git
alias gdh='git diff HEAD'
alias gcm='git commit -m'
alias gs='git status'
alias ga='git add .'
#others
alias top='htop'
alias quota='echo "" ; df -h ~ | sed /"export"/d ; echo ""'
#calculates most used commands
alias used='cat ~/.bash_history | sort | uniq -c | sort -n | tail'
alias revcount='git log --oneline --all | wc -l'
alias vi='vim' #helpful - on suphys invoking as vi reads different startup files
alias gvim='xmodmap -e "clear Lock" -e "keycode 0x42 = Escape" && gvim'
alias conf='./configure --prefix='`echo ~`'/.local'
alias spell='aspell --lang=en_GB -c'
alias movie='ffmpeg -y -f image2 -threads 4 -i pics/%d.png  -vcodec huffyuv test.avi'
alias proxy=' ssh -C2qTnN -D 8080 aws'
alias ssh='ssh -Y'
alias suphysmount='sudo -E mount -a -T /etc/fstab'
alias makeloop='while true;do make;sleep 4;done'
alias feh='feh -d' #get filenames
function newest()
{
    ls --sort=time $* 2> /dev/null | head -1;
}
alias latest='evince `newest "*.pdf"`'
alias edit='$EDITOR `newest "*.tex *.fs *.c"`'
#calculates most used commands but ignores arguments
function useds(){
cat ~/.bash_history | awk {'print $1'} | sort | uniq -c | sort -n | tail
}
alias open='gnome-open'
function gopen(){
for x in $@ ; do gvim $x; done
}
function latwarn {
pdflatex $1 | grep -i warn
}
#because latex is fun we use this function to compile
function latmake {
pdflatex $1 && bibtex $1 && pdflatex $1 && pdflatex $1
}
#evince doesn't go into the background automatically, but doing this fixes that problem - essentially aliases evince to evince &
#cannot be done with an alias because an alias can't fiddle with arguments
function evince {
exec evince "$1" &
}
#create a skeleton latex document
function latheader {
echo "\documentclass{article}
\usepackage{amsmath,mypack}
\begin{document}
\author{John Palmer, SID : 308219805}
\title{TITLE HERE !!!}
\maketitle

\end{document}" > $1
}
function mkgitig {
echo "*.aux
*.log
*.swp
*.mdb
*.pdf
*.dll
*.exe
*.gz
*.dvi
*sigfile" > .gitignore
}

#WINE
export WINEPREFIX=~/win32
export WINEARCH=win32
export NDK_HOME=~/android-ndk
export ANDROID_NDK_ROOT=~/android-ndk

export MAKEFLAGS='-j8'
bind "set completion-ignore-case on"
[[ -f ~/.autojump/etc/profile.d/autojump.bash ]]            && source ~/.autojump/etc/profile.d/autojump.bash
[[ -f /etc/profile.d/autojump.bash ]]                       && source /etc/profile.d/autojump.bash
[[ -f /usr/share/git/git-prompt.sh  ]]                       && source /usr/share/git/git-prompt.sh
[[ -f ~/.local/etc/bash_completion.d/git-completion.bash ]] && source ~/.local/etc/bash_completion.d/git-completion.bash
[[ -f ~/glados.txt ]]                                       && echo `sort -R ~/glados.txt | head -n 1`
[[ -f /usr/share/doc/pkgfile/command-not-found.bash ]]      && source /usr/share/doc/pkgfile/command-not-found.bash
. ~/.config/powerline.sh
alias howdoi='howdoi -c'

PATH="/home/john/perl5/bin${PATH+:}${PATH}"; export PATH;
PERL5LIB="/home/john/perl5/lib/perl5${PERL5LIB+:}${PERL5LIB}"; export PERL5LIB;
PERL_LOCAL_LIB_ROOT="/home/john/perl5${PERL_LOCAL_LIB_ROOT+:}${PERL_LOCAL_LIB_ROOT}"; export PERL_LOCAL_LIB_ROOT;
PERL_MB_OPT="--install_base \"/home/john/perl5\""; export PERL_MB_OPT;
PERL_MM_OPT="INSTALL_BASE=/home/john/perl5"; export PERL_MM_OPT;

export GOPATH=~/go
export PATH=$PATH:$GOPATH/bin
# Base16 Shell
BASE16_SHELL="$HOME/.config/base16-shell/base16-default.light.sh"
[[ -s $BASE16_SHELL ]] && source $BASE16_SHELL
alias urxvt2='urxvt -fn "xft:Droid Sans Mono:size=10,style=regular:antialias=false,xft:Consolas for Powerline:size=10,style=Regular" -fb "xft:Droid Sans Mono:size=10,style=regular:antialias=false,xft:Consolas for Powerline:size=10,style=Regular"    -vb +sb'
alias vim='nvim'
