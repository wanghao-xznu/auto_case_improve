#!/bin/sh -x
###########file name : compare.sh########################################
#########################################################################

CASE_ID=$1
TABLEFILE_NAME=$2
COMPARE_PATH=`dirname $0`
TABLEFILE=${COMPARE_PATH}/../../runtest/${TABLEFILE_NAME}
if [ ! -f $TABLEFILE ];then
    exit 0
fi

#if test -z "$TABLEFILE"
#then
#    exit 0
#fi

echo "=========='\$1=$1'=============="
echo "=========='\$2=$2'=============="
current_kernel=`/mnt/nfs/tools/printenv uimage`
current_fdt=`/mnt/nfs/tools/printenv fdt_file`
current_rootfs=`/mnt/nfs/tools/printenv nfsroot`
current_moreargs=`/mnt/nfs/tools/printenv more_args`
ct=0

case_kernel=`cat $TABLEFILE | grep "$1" | awk -F "kernel=" '{print $2}' | awk '{print $1}'`; echo case_kernel=$case_kernel
case_fdt=`cat $TABLEFILE | grep "$1" | awk -F "fdt_file=" '{print $2}' | awk '{print $1}'`   ; echo case_fdt=$case_fdt
case_rootfs=`cat $TABLEFILE | grep "$1" | awk -F "rootfs=" '{print $2}' | awk '{print $1}'`; echo case_rootf=$case_rootfs

case_moreargs=`cat $TABLEFILE | grep "$1" | awk -F "more_args=" '{print $2}'`;echo case_moreargs=$case_moreargs

##############################in case there is no case id in table sheet##########################################
case_id=`cat $TABLEFILE | grep "$1" | awk '{print $1}'`
echo "========================the current case=$1========================================="
if test -z "$case_id"
then
    case_kernel=`cat $TABLEFILE | grep "TGE-LV-DEFAULT-CASE" | awk '{print $2}'`; echo case_kernel=$case_kernel
    case_fdt=`cat $TABLEFILE | grep "TGE-LV-DEFAULT-CASE" | awk '{print $3}'`   ; echo case_fdt=$case_fdt
    case_rootfs=`cat $TABLEFILE | grep "TGE-LV-DEFAULT-CASE" | awk '{print $4}'`; echo case_rootfs=$case_rootfs
    case_moreargs=`cat $TABLEFILE | grep "TGE-LV-DEFAULT-CASE" | awk '{print $5}'`; echo case_moreargs=$case_moreargs
else
    echo "case_id=$case_id"
fi
####################for protect there is no config information in table sheet #############################
if test -z "$case_kernel"
then
    case_kernel=`cat $TABLEFILE | grep "TGE-LV-DEFAULT-CASE" | awk '{print $2}'`; echo case_kernel=$case_kernel
else
    echo "case_id=$case_id"
fi

if test -z "$case_fdt"
then
    case_fdt=`cat $TABLEFILE | grep "TGE-LV-DEFAULT-CASE" | awk '{print $3}'`   ; echo case_fdt=$case_fdt
else
    echo "case_id=$case_id"
fi

if test -z "$case_rootfs"
then
    case_rootfs=`cat $TABLEFILE | grep "TGE-LV-DEFAULT-CASE" | awk '{print $4}'`; echo case_rootfs=$case_rootfs
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
#    exit -1 
    reboot
    sleep 300
fi
exit 0
