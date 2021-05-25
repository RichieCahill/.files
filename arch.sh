#!/bin/bash
#setup time zone
sudo timedatectl set-timezone America/New_York
sudo systemctl enable systemd-timesyncd

~/.files/update.sh
#Installs archiving/compreshion Pacages
sudo pacman -S --needed p7zip unrar tar rsync zstd 
#Installs basic pacages
sudo pacman -S --needed base-devel curl wget nano neovim firefox vlc
#Installs zsh
sudo pacman -S --needed zsh && sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
#Nemo and extentions
sudo pacman -S --needed nemo nemo-fileroller nemo-image-converter nemo-preview nemo-seahorse nemo-share nemo-terminal nemo-python


#Installs microcode Based on cpu
if [[ $(lscpu) == *AMD* ]]; then
 sudo pacman -S amd-ucode
elif [[ $(lscpu) == *intel* ]]; then
 sudo pacman -S intel-ucodepac
 sudo pacman -S mesa
fi

#Installs xorg and nvida driver if needed
if [[ $Video == Y ]]; then
 sudo pacman -S xorg-server
  if [[ $(lspci) == *NVIDIA* ]]; then
 sudo pacman -S nvidia nvidia-utils
  fi
fi

#Installs and enables gui
sudo pacman -S xfce4 xfce4-goodies lightdm lightdm-gtk-greeter
systemctl enable lightdm

#Installs yay
cd ~/
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si
yay -Syu

#installs genral pacages
yay -S --needed spotify minecraft-launcher jdk bat
#installs fonts
yay -S --needed adobe-source-code-pro-fonts awesome-terminal-fonts cantarell-fonts gsfonts nerd-fonts-complete noto-fonts-cjk otf-font-awesome ttf-font-awesome ttf-ms-fonts ttf-font-awesome ttf-liberation ttf-ms-fonts ttf-opensans

#Installs discord and stuff for virtual camra
discord
yay -S discord obs-studio v4l2loopback-dkms

#Installs gaming resorces
yay -S --needed wine lutris steam

#Links zsh and vim rc files
ln -f ~/.files/vimrc ~/.vimrc
ln -f ~/.files/zshrc ~/.zshrc