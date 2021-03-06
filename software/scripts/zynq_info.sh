#!/bin/sh
cd $(dirname $(realpath $0))    # change into script dir


. ./i2c.func

# ZTO=`cat /sys/devices/soc0/amba/*.adc/iio*/in_temp0_offset` 
# ZTR=`cat /sys/devices/soc0/amba/*.adc/iio*/in_temp0_raw` 
# ZTS=`cat /sys/devices/soc0/amba/*.adc/iio*/in_temp0_scale` 

ZTO=`cat /sys/devices/soc0/amba/f8007100.adc/iio:device0/in_temp0_offset`
ZTR=`cat /sys/devices/soc0/amba/f8007100.adc/iio:device0/in_temp0_raw`
ZTS=`cat /sys/devices/soc0/amba/f8007100.adc/iio:device0/in_temp0_scale`

ZT=`dc -e "5k $ZTR ${ZTO/-/_} + $ZTS * 1000 / p"`

printf "%-14.14s\t%6.4f °C\n" "ZYNQ Temp" $ZT

