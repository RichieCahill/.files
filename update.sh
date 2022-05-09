#!/bin/bash
while :; do
		case $1 in
				-R|--reboot) Reboot="True"
				;;
				-S|--shutdown) Shutdown="True"
				;;
				*) break
		esac
		shift
done

OS=$(uname -a)

#Checks if the system is arch 
if [[ $OS == *arch* ]]; then
	#Checks if yay -s installed
	if [[ $(which yay) == /usr/bin/yay ]]; then
		#runs yay update
		yay -Syu --noconfirm
		yay -Yc
	else
		#Runs pacman update
		pacman -Syu --noconfirm
	fi
#Checks if the system is Ubuntu 
elif [[ $OS == *Ubuntu* ]]; then
	#Runs apt update upgrad and auto remove
	sudo apt update && sudo apt upgrade -y && sudo apt autoremove
#Checks if the system is Debian
elif [[ $OS == *Debian* ]]; then
	#Runs apt update upgrad
	sudo apt update && sudo apt upgrade -y
fi
#Reboot is flag is presed
if [[ $Reboot == True ]]; then
	sudo reboot
#shutdown is flag is presed
elif [[ $Shutdown == True ]]; then
	shutdown now
else
	exit
fi
