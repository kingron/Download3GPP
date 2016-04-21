#!/bin/sh
cd ~
wget -r -np -nd --spider  http://www.3gpp.org/ftp/Specs/archive/ -o list.txt.tmp
cat list.txt.tmp | grep -o 'http:[^"]*.zip' |awk 'BEGIN{
FS="/"
} 

{ 
if ($9!="" && $10=="" && $11=="")
 { 
 s1 = sprintf("%s/%s/%s/%s/%s/%s/%s/%s",$1,$2,$3,$4,$5,$6,$7,$8);
 MAX[s1]=$9;
 A[s1]++;
 MAX[s1]=($9>MAX[s1]?$9:MAX[s1]);
 }
else if($10!="" && $11=="")
 {
 s2 = sprintf("%s/%s/%s/%s/%s/%s/%s/%s/%s",$1,$2,$3,$4,$5,$6,$7,$8,$9);
 MAX[s2]=$10;
 B[s2]++;
 MAX[s2]=($10>MAX[s2]?$10:MAX[s2]);
 }
else if ($11!="" && $12="")
{
 s3 = sprintf("%s/%s/%s/%s/%s/%s/%s/%s/%s/%s",$1,$2,$3,$4,$5,$6,$7,$8,$9,$10);
 MAX[s3]=$11;
 C[s3]++;
 MAX[s3]=($11>MAX[s3]?$11:MAX[s3]);
}
}
END{ for (a in A) printf ("%s/%s\n",a,MAX[a]);
     for (b in B) printf ("%s/%s\n",b,MAX[b]);
	 for (c in C) printf ("%s/%s\n",c,MAX[c]);
}' | sort >> ~/list.txt

wget  -c -i ~/list.txt
