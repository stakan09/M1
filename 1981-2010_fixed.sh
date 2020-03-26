#!/bin/bash

rm 1981_2010_fixed.txt
touch 1981_2010_fixed.txt

for name in *.ctl
do

echo ${name%%.*} >> 1981_2010_fixed.txt

rm 1981-2010_fixed.gs
cat > 1981-2010_fixed.gs <<EOF
'reinit'
'open ${name}'

'set x 1 144'
'set y 1 73'
'set z 1'
'set time jan2011'
'set display white'
'set grads off'
'set grid off'
'set ccolor 1'
'set cthick 4'
'set cstyle 4'
'define yave = ave(clm,time=jan2011,time=dec2011)'
'define areaave = aave(yave,x=1,x=144,y=1,y=73)'
'set x 1'
'set y 1'
'set z 1'
'set time jan2011'
'set gxout print'
'set prnopts %7.2f 1 1'
'd areaave'
rc=write(1981_2010_fixed.txt,result,append)
rc=close(1981_2010_fixed.txt)
'quit'
EOF
grads -blc 'run 1981-2010_fixed.gs'
done
