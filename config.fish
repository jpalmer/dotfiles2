set --global --export LANG en_AU.UTF-8
set -U fish_user_paths $fish_user_paths ~/.local/bin
alias vim="nvim"
set --export --global HTTP_PROXY http://web-cache.usyd.edu.au:8080
set --export --global http_proxy $HTTP_PROXY
set --export --global HTTPS_PROXY $HTTP_PROXY
set --export --global https_proxy $HTTP_PROXY
set --export --global all_proxy $HTTP_PROXY
set --export --global ALL_PROXY $HTTP_PROXY
alias gdh='git diff HEAD'
alias gcm='git commit -m'
alias gs='git status'
alias ga='git add .'
alias nmatlab='matlab -nodesktop -nosplash'
if status --is-interactive
    . /etc/profile.d/autojump.fish
    eval sh $HOME/.config/base16-shell/base16-solarized.light.sh
    set fish_function_path $fish_function_path "/home/john/.local/lib/python3.4/site-packages/powerline/bindings/fish"
    powerline-setup
end
