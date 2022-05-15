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

#Gets the os information
OS=$(cat /etc/os-release)

#Runs the corect coman based on the OS ID
case $OS in
	*ID=arch*)
		if which yay ; then
			#runs yay update
			yay -Syu --noconfirm
			yay -Yc
		else
			#Runs pacman update if yay isnt present
			pacman -Syu --noconfirm
		fi
	;;
	*ID=ubuntu*|*ID=debian*|*ID=pop*)
		#Runs apt update upgrade and autoremove
	sudo apt update && sudo apt upgrade -y && sudo apt autoremove
	;;
	*)
esac

if which snap ; then
	sudo snap refresh
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
