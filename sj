#!/bin/bash
a=(子 丑 寅 卯 辰 巳 午 未 申 酉 戌 亥)
k=`date +%H`
k=$[$[$k+1]/2]
if [ $k = 12 ];then k=0;fi
#i=`ccal -u|awk 'NR==1 {print $3}'|awk -F 月 '{print $1}'`
#ccal -u
i=`./nongli.py|awk 'NR==1 {print $5}'`
echo "现在是: $i ${a[$k]}时"
