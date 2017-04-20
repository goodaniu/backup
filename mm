#!/bin/bash
gua_dir=/home/spark/document/jiegua/guaci
tian=/home/spark/document/jiegua/xiantian
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

#[[ $2 =~ ^[1-9][0-9]*$ ]] || exit
#[[ $3 =~ ^[1-9][0-9]*$ ]] || exit
if [[ $1 =~ cx|cm|cuo|zong|bian|ben ]];then
	shang=1      	
else
	echo "Error:wrong pattern."
	exit
fi

#按卦序查询，2个参数，如：mm cx 43
if [ $1 == "cx" ];then
	shang=$[$2/10+10]
	xia=$[$2%10]
	gua_shu=`awk -v var1=$shang -v var2=$xia 'NR==var1 {print $var2}' $tian`
	shang=$[$gua_shu/10]
	xia=$[$gua_shu%10]
	dong=$[$[$2-1]%6+1]
fi

#按卦名查询,如: mm cm 丰
####if [ $1 == "cm" ];then
####	shang=`grep $2 $tian|awk  'FS==ENVIRON[2] {print $1}'|awk '{print result=NF+1}'|echo $result`
####	xia=`grep -n $2 $tian|cut -d ':' -f 1`
####	dong=1
####fi

#数字占，3个参数，如：mm 5 3
if [[ $1 =~ cuo|zong|bian|ben ]];then
	shang=$[$[$2-1]%8+1]
	xia=$[$[$3-1]%8+1]
	dong=$[$[$2+$3-1]%6+1]
	case $1 in 
		cuo)	#错卦
			a=(9 8 7 6 5 4 3 2 1)
			shang=${a[$shang]}
			xia=${a[$xia]}
		;;
		zong)	#综卦
			a=( 9 1 5 3 7 2 6 4 8 )
			zhong=$shang
			shang=${a[$xia]}
			xia=${a[$zhong]}
		;;
		bian)	#变卦
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

#上下卦数及变爻数已定
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
