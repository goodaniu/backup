#!/bin/bash
#重启后以新用户登录，安装必要的软件，在此之前，请先在完整系统中调用'creat-pkglist'生成软件列表
cd /home/archinstall
pacman -Syyu --noconfirm
pacman -S --needed --noconfirm $(< paclist)
yaourt -S --needed $(< aurlist)
pacman -S  --asdeps --needed  $(< asdepslist)

#配置转移，在原先系统中先备份好
cat bashrc >/home/myarch/.bashrc
cat xinitrc >/home/myarch/.xinitrc
cat Xdefaults >/home/myarch/.Xdefaults

# .tmux.conf
# .config/i3
# .config/awesome
# /usr/share/fonts
# /etc/pacman.d/mirrorlist
# /etc/pacman.conf
# /etc/yaourtrc  #AURURL
# /etc/udev/rules.d/81-backlight.rules
# /etc/systemd
# /etc/grub.d/40_custom
# /etc/default/grub
# /usr/share/stardict/dic
# /etc/fish/config.fish
