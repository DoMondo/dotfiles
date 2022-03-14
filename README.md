# Domondo Dotfiles

## Automation of installation and configuration
The scripts `pre-installation.sh`, `pre-installation-user.sh` and `post-installation.sh` automate the most part of the process. If there are not unexpected problems, the process should take from 15 to 20 minutes.

### Preinstallation
1. Create partitions (`fdisk`). For example, one swap, one root partition and one efi system partition (>300MiB). Choose appropiately between UEFI/GPT and BIOS/GPT. Check [Example Layouts](https://wiki.archlinux.org/title/Partitioning#Example_layouts) if needed. I'll assume UEFI from now on.
2. Format the partitions 
```bash
mkfs.ext4 /dev/root_partition
mkswap /dev/swap_partition
mkfs.fat -F 32 /dev/efi_system_partition
```
3. Mount the partitions
```bash
mount /dev/root_partition /mnt
mkdir /mnt/boot
mount /dev/efi_system_partition /mnt/boot
```
4. Install essential packages, generate fstab and chroot into the new installation
```bash
pacstrap /mnt base linux linux-firmware
genfstab -U /mnt >> /mnt/etc/fstab
arch-chroot /mnt
```
### Running the installer

Just after chroot-ing in the fresh installation, run the installer script like so:
```bash
pacman -S wget
cd /tmp
wget https://raw.githubusercontent.com/DoMondo/dotfiles/master/pre-installation.sh
chmod +x pre-installation.sh
./pre-installation.sh
```

