# get rid of greeting
set fish_greeting
# vim mode
fish_vi_key_bindings
# aliases
alias rm="trash-put"
alias ls="exa"
alias la="exa -a"
alias ll="exa -la"
alias cat="bat"
alias grep='grep --color=auto'
alias ..='cd ..'
alias mv='mv -i'
# export default editor and terminal
set -x EDITOR vim
set -x VISUAL vim
set -x TERM alacritty
set -x TERMINAL alacritty
# use starship prompt
starship init fish | source
