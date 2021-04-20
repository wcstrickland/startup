apt install vim vim-gtk3 feh nodejs vlc htop ranger terminator neofetch compton rofi i3 i3blocks
mkdir ~/.config/i3/
mkdir ~/.vim
cp ../vim/docs.txt ~/.vim/
cp ../vim/git.md ~/.vim/
cp ../.vimrc ~/
cp .Xresources ~/
cp .bashrc ~/
cp ../images/wall.jpg ~/Pictures/
cp config ~/.config/i3/
cp i3blocks.conf  ~/.config/i3/
#cp wall.jpg /usr/share/sddm/themes/lubuntu/
#cp theme.conf /usr/share/sddm/themes/lubuntu/
feh --bg-scale ~/Pictures/wall.jpg
apt-get update
apt upgrade
