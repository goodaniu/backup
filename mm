#!/bin/bash
gua_dir=/home/spark/jiegua/guaci
####卦名 乾 兑 离 震 巽 坎 艮 坤
####本卦 1 2 3 4 5 6 7 8 已知
####二进 7 3 5 1 6 2 4 0 求
####综卦 1 5 3 7 2 6 4 8
####错卦 8 7 6 5 4 3 2 1
####变1  5 6 7 8 1 2 3 4
####变2  3 4 1 2 7 8 5 6
####变3  2 1 4 3 6 5 8 7
####变4  5 6 7 8 1 2 3 4
####变5  3 4 1 2 7 8 5 6
####变6  2 1 4 3 6 5 8 7

 [[ $2 =~ ^[1-9][0-9]*$ ]] || exit
 [[ $3 =~ ^[1-9][0-9]*$ ]] || exit
#按卦序查询，2个参数，如：mm  43
if [ $1 == "s" ];then
	shang=$[$3/10+10]
	xia=$[$3%10]
	gua_shu=`awk -v var1=$shang -v var2=$xia 'NR==var1 {print $var2}' $gua_dir/xiantian`
	dong=$[$3%6]
	if [ $dong == 0 ];then dong=6;fi
	dong=${gua_shu}$dong
	gua_shu=${gua_shu}"0"
	
fi

#数字占，3个参数，如：mm 5 3
if [ $1 != "s" ];then
	shang=$[$2%8]
	if [ $shang == 0 ];then shang=8;fi
	xia=$[$3%8]
	if [ $xia == 0 ];then xia=8;fi
	dong=$[$[$2+$3]%6]
	if [ $dong == 0 ];then dong=6;fi
	case $1 in 
		c)	#错卦
			a=(9 8 7 6 5 4 3 2 1)
			shang=${a[$shang]}
			xia=${a[$xia]}
		;;
		z)	#综卦
			a=( 9 1 5 3 7 2 6 4 8 )
			zhong=$shang
			shang=${a[$xia]}
			xia=${a[$zhong]}
		;;
		b)	#变卦
			case $dong in
				1)	a=(9 4 8 2 6 3 7 1 5);;
				2)	a=(9 6 2 8 4 5 1 7 3);;
				3)	a=(9 7 3 5 1 8 4 6 2);;
				4)	a=(9 4 8 2 6 3 7 1 5);;
				5)	a=(9 6 2 8 4 5 1 7 3);;
				6)	a=(9 7 3 5 1 8 4 6 2);;
			esac
			shang=${a[$shang]}
			xia=${a[$xia]}
		;;
	esac
fi
dong=${shang}${xia}$dong
gua_shu=${shang}${xia}"0"
	

#输出
case $shang in
	1) echo -e "—————\n—————\n—————";;
	2) echo -e "—— ——\n—————\n—————";;
	3) echo -e "—————\n—— ——\n—————";;
	4) echo -e "—————\n—— ——\n—————";;
	5) echo -e "—————\n—————\n—— ——";;
	6) echo -e "—— ——\n—————\n—— ——";;
	7) echo -e "—————\n—— ——\n—— ——";;
	8) echo -e "—— ——\n—— ——\n—— ——";;
esac
case $xia in
	1) echo -e "—————\n—————\n—————";;
	2) echo -e "—— ——\n—————\n—————";;
	3) echo -e "—————\n—— ——\n—————";;
	4) echo -e "—————\n—— ——\n—————";;
	5) echo -e "—————\n—————\n—— ——";;
	6) echo -e "—— ——\n—————\n—— ——";;
	7) echo -e "—————\n—— ——\n—— ——";;
	8) echo -e "—— ——\n—— ——\n—— ——";;
esac

head -4 $gua_dir/$gua_shu
head -3 $gua_dir/$dong
tail -3 $gua_dir/$dong

#less $gua_shu
#less $dong

if [ $? != 0 ] ;then echo -e "\e[1;31mError:出现错误了哦！\e[0m";fi
