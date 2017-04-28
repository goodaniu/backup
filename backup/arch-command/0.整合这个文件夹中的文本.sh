#!/bin/bash
echo -e "#+TITLE:Linux使用命令集锦\n#+AUTHOR:Gong\n#+OPTIONS: \\\n:t\n-------\n" > 111.org
for test in ./*
do
	if [ $test != $0 -a $test != './111.org' ];then
		echo -e "\n** $test\n" >>111.org
		cat $test >>111.org
	fi
done

