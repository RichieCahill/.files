#!/bin/bash
while :; do
		case $1 in
				-l|--laptop) Laptop="True" Video="True" Sweet="True" Bluetooth="True"
				;;
				-d|--desktop) Video="True" Sweet="True" Gaming="True" 
				;;
				-g|--gaming) Gaming="True"
				;;
				-s|--sweet) Sweet="True"
				;;
				-v|--video) Video="True"
				;;
				-b|--bluetooth) Bluetooth="True"
				;;
				*) break
		esac
		shift
done

#setup time zone
sudo timedatectl set-timezone America/New_York
sudo systemctl enable systemd-timesyncd

echo "LANG=en_US.UTF-8" | sudo tee /etc/locale.conf >> /dev/null

#Sets my pacman.conf
sudo cp ~/.files/pacman.conf /etc/pacman.conf

~/.files/update.sh
#Installs archiving/compression packages
sudo pacman -S --needed p7zip unrar tar rsync zstd 
#Installs basic packages
sudo pacman -S --needed base-devel curl wget nano neovim bat usbutils
#Installs File system utilities
sudo pacman -S --needed ntfs-3g nfs-utils

#Installs yay
cd ~/ || exit
git clone https://aur.archlinux.org/yay.git
cd yay || exit
makepkg -si
yay -Syu

#Installs Dev tools
yay -S cgdb nodejs go go-tools rustup python-docutils
rustup toolchain install stable
rustup default stable
rustup component add rust-src clippy rustfmt

#Installs microcode Based on cpu
if [[ $(lscpu) == *AMD* ]]; then
 sudo pacman -S --needed amd-ucode
elif [[ $(lscpu) == *intel* ]]; then
 sudo pacman -S --needed intel-ucode mesa
fi
if [[ $(lspci) == *NVIDIA* ]]; then
	sudo pacman -S --needed nvidia nvidia-utils
fi

#Installs evreything for gui
if [[ $Video == True ]]; then
	sudo pacman -S --needed xorg-server
	#Installs basic gui packages
	sudo pacman -S --needed firefox vlc spotify  gparted
	#Installs Nemo and extensions
	sudo pacman -S --needed nemo nemo-fileroller nemo-image-converter nemo-preview nemo-seahorse nemo-share nemo-terminal nemo-python
	#Installs audio packages
	sudo pacman -S --needed pulseaudio pulseaudio-alsa pulseaudio-bluetooth pulseaudio-equalizer pavucontrol 
	#Installs networking packages
	sudo pacman -S --needed networkmanager-openvpn network-manager-applet iperf3
	#installs fonts
	yay -S --needed adobe-source-code-pro-fonts awesome-terminal-fonts cantarell-fonts gsfonts nerd-fonts-complete noto-fonts-cjk otf-font-awesome ttf-font-awesome ttf-ms-fonts ttf-font-awesome ttf-liberation ttf-ms-fonts ttf-opensans
	#Installs communication packages
	yay -S --needed signal-desktop discord obs-studio v4l2loopback-dkms
	#Installs and enables GUI
	sudo pacman -S xfce4 xfce4-goodies lightdm lightdm-gtk-greeter
	systemctl enable lightdm
fi

if [[ $Laptop == True ]]; then
	#Sets up syncthing
	yay -S syncthing
fi

#Installs and enables reflector 
sudo pacman -S --needed reflector
sudo systemctl enable reflector.service

#Installs gaming packages
if [[ $Gaming == True ]]; then
	yay -S --needed wine lutris steam minecraft-launcher jdk
fi

#Installs and enables Bluetooth
if [[ $Bluetooth == True ]]; then
	yay -S --needed bluez bluez-utils blueman pulseaudio-bluetooth 
	sudo systemctl enable bluetooth.service
fi

#Sets up zerotier
yay -S zerotier-one
sudo systemctl enable  zerotier-one.service --now
sudo zerotier-cli join 35c192ce9beac38f


#Installs zsh
yay -S --needed zsh oh-my-zsh-git && chsh -s /bin/zsh

#Links zshrc and vimrc
ln -fs ~/.files/vimrc ~/.vimrc
ln -fs ~/.files/zshrc ~/.zshrc

if [[ $Sweet == True ]]; then
	mkdir ~/.icons
	mkdir ~/.theams
	git clone https://github.com/EliverLara/candy-icons.git ~/.icons/candy-icons
	git clone -b nova https://github.com/EliverLara/Sweet.git ~/.themes/Sweet-nova
	
	gtk-update-icon-cache ~/.icons/candy-icons 
	gsettings set org.gnome.desktop.interface gtk-theme "Sweet-nova"
	gsettings set org.gnome.desktop.wm.preferences theme "Sweet-nova"
fi
