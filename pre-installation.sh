#!/bin/bash

set -e

ln -sf /usr/share/zoneinfo/Atlantic/Canary /etc/localtime
hwclock --systohc
echo en_US.UTF-8 UTF-8 > /etc/locale.gen
locale-gen
echo LANG=en_US.UTF-8 > /etc/locale.conf
read -p '******* Set host name: ' hostname
echo $hostname > /etc/hostname
echo ******* Set ROOT password
passwd

# Install GRUB
while true; do
    read -p "Do you wish to install or update GRUB?" yn
    case $yn in
        [Yy]*) 
           pacman -S grub efibootmgr
           grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=GRUB
           grub-mkconfig -o /boot/grub/grub.cfg 
           break
           ;;
        [Nn]*) break;;
        * ) echo "Please answer yes or no.";;
    esac
done

# install dhcpcd
pacman -S dhcpcd
systemctl enable dhcpcd.service
systemctl start dhcpcd.service

# Create the main user
pacman -S sudo
useradd -m -G wheel ogomez -s /bin/bash
echo ******* Set USER password
passwd ogomez

pacman -S vi
read -p '******* Uncomment wheel entry in sudoers file ' unused
visudo 

# Install i3wm
pacman -S vim noto-fonts xf86-input-libinput xf86-video-amdgpu xf86-video-vesa xf86-video-vmware xf86-video-fbdev xf86-video-intel xf86-video-nouveau git
wget https://raw.githubusercontent.com/DoMondo/dotfiles/master/pre-installation-user.sh
chmod +x pre-installation-user.sh
sudo -u ogomez ./pre-installation-user.sh 
