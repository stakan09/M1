#!/bin/bash

modelname="MIROC5"
#'colormaps l 265 350 1 map grayscale'
month=("Jan" "Feb" "Mar" "Apr" "May" "Jun" "Jul" "Aug" "Sep" "Oct" "Nov" "Dec")
for i in `seq 1 12`
do
filename=`printf %02d $i`
name=${month[$i-1]}
rm pdf.gs
cat > pdf.gs <<EOF
'open /Workspace/intr_hdd0/CMIP5/miroc.1850-2100.bin.ctl'
'set display white'
'set x 1 144'
'set y 1 73'
'set z 1'
'set grid off'
'set ccolor 1'
'set cint 1'
'set time jan1981 dec1981'
'define tsave = ave(tos,t+0,time=dec2010,1yr)'
'modify tsave seasonal'
'set time ${name}1981'
'd tsave'
'draw title ${modelname}_1981-2010_Fixed_Monthly_Average_${name}'
'gxprint mclim${filename}.pdf'
'quit'
EOF
grads -blc 'run /Workspace/intr_hdd0/CMIP5/pdf.gs'
done

