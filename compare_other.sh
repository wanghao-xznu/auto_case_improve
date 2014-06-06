#!/bin/sh -x
<<<<<<< HEAD
=======
###########file name : compare.sh########################################
#          because compare.sh was called by ltp-pan
#########################################################################
>>>>>>> f51b1cfa0cf6d9127e8a433fb51ce177ab1f6596
current_kernel=`/mnt/nfs/tools/printenv uimage`
current_fdt=`/mnt/nfs/tools/printenv fdt_file`
current_rootfs=`/mnt/nfs/tools/printenv nfsroot`
current_moreargs=`/mnt/nfs/tools/printenv more_args`
<<<<<<< HEAD
#case_kernel=`cat auto_case_table.txt | grep "TGE-LV-NAND-1101" | awk '{print $2}'`
#case_fdt=`cat auto_case_table.txt | grep "TGE-LV-NAND-1101" | awk '{print $3}'`
#case_rootfs=`cat auto_case_table.txt | grep "TGE-LV-NAND-1101" | awk '{print $4}'`
=======
>>>>>>> f51b1cfa0cf6d9127e8a433fb51ce177ab1f6596
ct=0

case_kernel=`cat /mnt/nfs/tools/auto_case_table.txt | grep "$1" | awk -F "kernel=" '{print $2}' | awk '{print $1}'`; echo case_kernel=$case_kernel
case_fdt=`cat /mnt/nfs/tools/auto_case_table.txt | grep "$1" | awk -F "fdt_file=" '{print $2}' | awk '{print $1}'`   ; echo case_fdt=$case_fdt
case_rootfs=`cat /mnt/nfs/tools/auto_case_table.txt | grep "$1" | awk -F "rootfs=" '{print $2}' | awk '{print $1}'`; echo case_rootf=$case_rootfs

case_moreargs=`cat /mnt/nfs/tools/auto_case_table.txt | grep "$1" | awk -F "more_args=" '{print $2}'`;echo case_moreargs=$case_moreargs

##############################in case there is no case id in table sheet##########################################
case_id=`cat /mnt/nfs/tools/auto_case_table.txt | grep "$1" | awk '{print $1}'`
echo "========================the current case=$1========================================="
if test -z "$case_id"
then
    ############here need use default kernel dtb rootfs##############
    #exit -1                   ####can't return zero,because ltp-pan check the exit vaule and have a reboot#####
    case_kernel=`cat /mnt/nfs/tools/auto_case_table.txt | grep "TGE-LV-DEFAULT-CASE" | awk '{print $2}'`; echo case_kernel=$case_kernel
    case_fdt=`cat /mnt/nfs/tools/auto_case_table.txt | grep "TGE-LV-DEFAULT-CASE" | awk '{print $3}'`   ; echo case_fdt=$case_fdt
<<<<<<< HEAD
    case_rootfs=`cat /mnt/nfs/tools/auto_case_table.txt | grep "TGE-LV-DEFAULT-CASE" | awk '{print $4}'`; echo case_rootf=$case_rootfs
=======
    case_rootfs=`cat /mnt/nfs/tools/auto_case_table.txt | grep "TGE-LV-DEFAULT-CASE" | awk '{print $4}'`; echo case_rootfs=$case_rootfs
>>>>>>> f51b1cfa0cf6d9127e8a433fb51ce177ab1f6596
    case_moreargs=`cat /mnt/nfs/tools/auto_case_table.txt | grep "TGE-LV-DEFAULT-CASE" | awk '{print $5}'`; echo case_moreargs=$case_moreargs
else
    echo "case_id=$case_id"
fi
##############################in case there is no case id in table sheet##########################################


if [ x"$current_kernel"x != x"$case_kernel"x ]; then
    /mnt/nfs/tools/setenv uimage "$case_kernel"
    ct=$(expr $ct + 1)
fi
if [ x"$current_fdt"x != x"$case_fdt"x ]; then
    /mnt/nfs/tools/setenv fdt_file "$case_fdt"
    ct=$(expr $ct + 1)
fi
if [ x"$current_rootfs"x != x"$case_rootfs"x ]; then
    /mnt/nfs/tools/setenv nfsroot "$case_rootfs"
    ct=$(expr $ct + 1)
fi
if [ x"$current_moreargs"x != x"$case_moreargs"x ]; then
    /mnt/nfs/tools/setenv more_args "$case_moreargs"
    ct=$(expr $ct + 1)
fi

if [ $ct -ne 0 ];then
    exit -1 
fi
exit 0
