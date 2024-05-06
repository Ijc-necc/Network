#!/usr/bin/awk -f
BEGIN {
	FS = ":"	#set the FS to :
}

{
	contr[$1] += $(NF-2) + $(NF-1) + $NF	#contr = contributions save the name($1) and total

}

END {
	for (name in contr) {
		if (contr[name] / 3 < 300) {	#fint the average, is it less than 300
			print name ":", contr[name] / 3
		}
	}
}
