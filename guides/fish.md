# fish / alacritty setup

`sudo pacman -S fish alacritty`

# alacritty

`mkdir ~/.config/alacritty`

`mv /usr/share/doc/alacritty/example/alacrityy.yml ~/.config/alacritty/`

[one dark theme for alacritty](https://gist.github.com/r-darwish/f8bb21a6c89a02c4bef76cc38bddad39)

# fish

`cat /etc/shells`

`to get path to fish and to check it is installed`

`echo $0 will check current shell`

`chsh `

`will ask for path to new shell`

## ~/.config/fish/config.fish

`set fish_greeting`

`starship init fish | source`

`fish_vi_key_bindings`

`alias rm="trash-put"`

`alias ls="exa"`

`alias la="exa -a"`

`alias ll="exa -la"`

`alias cat="bat"`

