#!/bin/bash

touch areaave19.txt
touch areaave20.txt
touch areaave21.txt

for name in *.ctl
do

echo ${name%%.*} >> areaave19.txt
echo ${name%%.*} >> areaave20.txt
echo ${name%%.*} >> areaave21.txt

rm 19_20_21_clim.gs
cat > 19_20_21_clim.gs <<EOF
'reinit'
'open ${name}'

'set x 1 144'
'set y 1 73'
'set z 1'
'set time jan1870 dec1870'
'set display white'
'set grads off'
'set grid off'
'set ccolor 1'
'set cthick 4'
'set cstyle 4'
'define tsave19 = ave(tos,t+0,time=dec1899,1yr)'
'define yave19 = ave(tsave19,time=jan1870,time=dec1870)'
'define areaave19 = aave(yave19,x=1,x=144,y=1,y=73)'
'set x 1'
'set y 1'
'set z 1'
'set time jan1870'
'set gxout print'
'set prnopts %7.2f 1 1'
'd areaave19'
rc=write(areaave19.txt,result,append)
rc=close(areaave19.txt)

'set x 1 144'
'set y 1 73'
'set z 1'
'set time jan1970 dec1970'
'set display white'
'set grads off'
'set grid off'
'set ccolor 1'
'set cthick 4'
'set cstyle 4'
'define tsave20 = ave(tos,t+0,time=dec1999,1yr)'
'define yave20 = ave(tsave20,time=jan1970,time=dec1970)'
'define areaave20 = aave(yave20,x=1,x=144,y=1,y=73)'
'set x 1'
'set y 1'
'set z 1'
'set time jan1970'
'set gxout print'
'set prnopts %7.2f 1 1'
'd areaave20'
rc=write(areaave20.txt,result,append)
rc=close(areaave20.txt)

'set x 1 144'
'set y 1 73'
'set z 1'
'set time jan2070 dec2070'
'set display white'
'set grads off'
'set grid off'
'set ccolor 1'
'set cthick 4'
'set cstyle 4'
'define tsave21 = ave(tos,t+0,time=dec2099,1yr)'
'define yave21 = ave(tsave21,time=jan2070,time=dec2070)'
'define areaave21 = aave(yave21,x=1,x=144,y=1,y=73)'
'set x 1'
'set y 1'
'set z 1'
'set time jan2070'
'set gxout print'
'set prnopts %7.2f 1 1'
'd areaave21'
rc=write(areaave21.txt,result,append)
rc=close(areaave21.txt)
'quit'
EOF
grads -blc 'run 19_20_21_clim.gs'
done
