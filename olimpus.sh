#!/bin/bash

yay -S visual-studio-code-bin

yay -S docker 
sudo systemctl enable docker.service --now
sudo usermod -aG docker r2r0m0c0

#Creates admin users and groups
echo "Creating admin acounts"
#Sets up an user and group alice
sudo groupadd -g 1100 alice
sudo useradd -m -u 1100 -g alice -G docker -G users -G wheel alice
sudo chsh -s /bin/zsh alice
sudo mkdir /home/alice/.ssh/
echo "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILWG3cIBju6vzX6s8JlmGNJOiWY7pQ19bHvcqDADtWzv snowi@DESKTOP-EVIR8IH" | sudo tee  /home/alice/.ssh/authorized_keys >> /dev/null
sudo chown alice:alice -R /home/alice/

#Sets up an user and group twright
sudo groupadd -g 1104 twright
sudo useradd -m -u 1104 -g twright -G docker -G users -G wheel twright
sudo chsh -s /bin/zsh twright
sudo mkdir /home/twright/.ssh/
echo "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAICKXzPF7Ro70goiM/43unrKLskkjZ2oo1x64sqyJIi2r TYLER" | sudo tee  /home/twright/.ssh/authorized_keys >> /dev/null
sudo chown twright:twright -R /home/twright/

yay -S --needed qemu dhclient openbsd-netcat virt-viewer libvirt dnsmasq dmidecode ebtables virt-install virt-manager bridge-utils

sudo systemctl enable libvirtd --now