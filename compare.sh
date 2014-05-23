#!/bin/sh
current_kernel=`/mnt/nfs/tools/printenv uimage`
current_fdt=`/mnt/nfs/tools/printenv fdt_file`
current_rootfs=`/mnt/nfs/tools/printenv nfsroot`
#case_kernel=`cat auto_case_table.txt | grep "TGE-LV-NAND-1101" | awk '{print $2}'`
#case_fdt=`cat auto_case_table.txt | grep "TGE-LV-NAND-1101" | awk '{print $3}'`
#case_rootfs=`cat auto_case_table.txt | grep "TGE-LV-NAND-1101" | awk '{print $4}'`

case_kernel=`cat /mnt/nfs/tools/auto_case_table.txt | grep "$1" | awk '{print $2}'`; echo case_kernel=$case_kernel
case_fdt=`cat /mnt/nfs/tools/auto_case_table.txt | grep "$1" | awk '{print $3}'`   ; echo case_fdt=$case_fdt
case_rootfs=`cat /mnt/nfs/tools/auto_case_table.txt | grep "$1" | awk '{print $4}'`; echo case_rootf=s$case_rootfs

ct=0

if [ "$current_kernel" != "$case_kernel" ]; then
    /mnt/nfs/tools/setenv uimage $case_kernel
    ct=$(expr $ct + 1)
fi
if [ "$current_fdt" != "$case_fdt" ]; then
    /mnt/nfs/tools/setenv fdt_file $case_fdt
    ct=$(expr $ct + 1)
fi
if [ "$current_rootfs" != "$case_rootfs" ]; then
    /mnt/nfs/tools/setenv nfsroot $case_rootfs
    ct=$(expr $ct + 1)
fi

if [ $ct -ne 0 ];then
   # sleep 15
    echo reboot
fi
