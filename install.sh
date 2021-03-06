#!/bin/bash
#safe mode
set -euo pipefail
IFS=$'\n\t'
git submodule update
#install yaourt - first pkgquery
if  [ -n   "$(pacman -Qs package-query)" ]
then
echo "package-query installed - skipping"
else
curl https://aur.archlinux.org/packages/pa/package-query/package-query.tar.gz > pkgquery.tar.gz
tar -xvf pkgquery.tar.gz
cd package-query
makepkg -s -f
sudo pacman -U  *.xz
cd ..
fi
#now actual yaourt
if  [ -n "$(pacman -Qs yaourt)" ]
then
echo "yaourt installed -skipping" || false
else
curl https://aur.archlinux.org/packages/ya/yaourt/yaourt.tar.gz > yaourt.tar.gz
tar -xvf yaourt.tar.gz
cd yaourt
makepkg -s -f
sudo pacman -U *.xz
cd ..
fi

#Install stuff with yaourt
sudo pacman -Syu
#pacman stuff
sudo pacman -S --needed --noconfirm texlive-most python-pip fontforge xclip strace opencv doxygen dialog graphviz clang pkgfile xorg-xsetroot fish base-devel evince eog htop wget
#aur stuff 
    #yaourt dep resolution broken
    yaourt -S --needed --noconfirm python2-trollius
    yaourt -S --needed --noconfirm neovim-git ttf-vista-fonts python-neovim  python2-neovim
pip install --user powerline-status
sudo  pkgfile --update #build the pkgfile database

#config files
declare -A MAP

MAP[~/.ssh/config]="config"
MAP[~/.bashrc]="bashrc"
MAP[~/.nvimrc]="nvimrc"
MAP[~/.Xdefaults]="Xdefaults"
MAP[~/.config/powerline]="powerline"
MAP[~/.config/base16-shell]="base16-shell"
MAP[~/.config/fish/config.fish]="config.fish"
mkdir -p ~/.nvim/autoload
curl https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim > ~/.nvim/autoload/plug.vim
mkdir -p ~/.config
for K in "${!MAP[@]}";
do

echo $K --- ${MAP[$K]};
ln -nsf $(pwd)/${MAP[$K]} $K
done
nvim -c "PlugInstall" -c ":q" -c ":q" -c ":q"

ln -sf $(pip show -f powerline-status | grep Location | awk '{print $2}')/$(pip show -f powerline-status | grep powerline.sh | grep bash | tr -d ' ') ~/.config/powerline.sh
fontforge -script fontpatcher/scripts/powerline-fontpatcher $(fc-match --verbose consolas | grep file | tr '"' ' ' | awk '{print $2}')
mkdir -p ~/.fonts
mv Consolas\ for\ Powerline.ttf ~/.fonts
fc-cache
fish_update_completions
