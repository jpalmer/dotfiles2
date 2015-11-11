set --global --export LANG en_AU.UTF-8
set -U fish_user_paths $fish_user_paths ~/.local/bin
abbr -a gdh git diff HEAD
abbr -a gcm git commit -m
abbr -a gs git status
abbr -a ga git add .
abbr -a vim nvim
abbr -a nmatlab matlab -nodesktop -nosplash
abbr -a sl ls
abbr -a top htop
if status --is-interactive
    . /etc/profile.d/autojump.fish
#    eval sh $HOME/.config/base16-shell/base16-bright.light.sh
    set fish_function_path $fish_function_path "/home/john/.local/lib/python3.5/site-packages/powerline/bindings/fish"
    powerline-setup
end
