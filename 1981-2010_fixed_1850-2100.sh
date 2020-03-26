#!/bin/bash

rm 1981_2010_fixed.txt
touch 1981_2010_fixed.txt

for name in *.ctl
do

echo ${name%%.*} >> 1981_2010_fixed.txt

rm 1981-2010_fixed_1850-2100.gs
cat > 1981-2010_fixed_1850-2100.gs <<EOF
'reinit'
'open ${name}'

'set x 1 144'
'set y 1 73'
'set z 1'
'set time jan1981 dec1981'
'set display white'
'set grads off'
'set grid off'
'set ccolor 1'
'set cthick 4'
'set cstyle 4'
'define tsave = ave(tos,t+0,time=dec2010,1yr)'
'define yave = ave(tsave,time=jan1981,time=dec1981)'
'define areaave = aave(yave,x=1,x=144,y=1,y=73)'
'set x 1'
'set y 1'
'set z 1'
'set time jan1981'
'set gxout print'
'set prnopts %7.2f 1 1'
'd areaave'
rc=write(1981_2010_fixed.txt,result,append)
rc=close(1981_2010_fixed.txt)
'quit'
EOF
grads -blc 'run 1981-2010_fixed_1850-2100.gs'
done
