#!/bin/bash
#此脚本在完好系统中调用并生成软件列表备份
comm -23 <(pacman -Qeq|sort) <(pacman -Qgq base base-devel|sort)  >pkglist
comm -12 <(comm -23 <(pacman -Qeq|sort) <(pacman -Qmq|sort)) <(sort pkglist) >paclist
comm -13 <(comm -23 <(pacman -Qeq|sort) <(pacman -Qmq|sort)) <(sort pkglist) >aurlist
comm -12 <(comm -23 <(pacman -Qdq|sort) <(pacman -Qmq|sort)) <(sort pkglist) >asdepslist
