#!/bin/sh
##############################################################################
#Copyright (C) 2014 Freescale Semiconductor, Inc.
#All Rights Reserved.
#
#The code contained herein is licensed under the GNU General Public
#License. You may obtain a copy of the GNU General Public License
#Version 2 or later at the following locations:
#
#http://www.opensource.org/licenses/gpl-license.html
#http://www.gnu.org/copyleft/gpl.html
##############################################################################
#
# Revision History:
# Author                   Date     Description of Changes
#-------------------   ------------ -----------------------
# WangHao         16/06/2014  Initial ver.

# Description:  - this script set orign table file(generate from XT) 
#               - the generate table is true file, put inder runtest 
#
# Return        - zero on success
#               - non zero on failure.

usage()
{
    echo "============================please input below parameters================================"
    echo "============================'\$1' = release name=======or daily=========================="
    echo "============================'\$2' = soc id==============================================="
    echo "============================'\$3' = board ==============================================="
    echo "============================'\$4' = GEN_FILE_NAME ======================================="
    echo "============================'\$5' = REL_TABLE_NAME ======================================"
    echo "+++++++example: ./magic.sh L3.10.31_1.1.0_alpha_RC1 mx63 ard input_f output_f++++++++++++"
}

if [ $# -ne 5 ];then
    usage
    exit 1
fi

GENERATE_FILE_NAME=$4
REAL_TABLE_FILE_NAME=$5
release_id=$1
platform=$2

#replace_list=uImage ecspi gpmi_weim rootfs_r_fb rootfs_ra_wld rootfs_r_dfb and usb
if [ x"$1"x != x"daily"x ]; then
    cat $4 | sed 's/uImage/'"uImage_$2_$1"'/g' | tee temp_table.txt
    sleep 1
    cat temp_table.txt | sed 's/dtb_default/'"dtb_$2$3_$1"'/g' | tee temp_table.txt
    sleep 1
    cat temp_table.txt | sed 's/ecspi/'"dtb_$2$3_ecspi_$1"'/g' | tee temp_table.txt
    cat temp_table.txt | sed 's/gpmi_weim/'"dtb_$2$3_gpmi_weim_$1"'/g' | tee temp_table.txt
    cat temp_table.txt | sed 's/rootfs=_x/'"rootfs=\/rootfs\/i$2_rootfs_r"'/g' | tee temp_table.txt
    cat temp_table.txt | sed 's/rootfs=_fb/'"rootfs=\/rootfs\/i$2_rootfs_r_fb"'/g' | tee temp_table.txt
    cat temp_table.txt | sed 's/rootfs=_dfb/'"rootfs=\/rootfs\/i$2_rootfs_r_dfb"'/g' | tee temp_table.txt
    cat temp_table.txt | sed 's/rootfs=_wld/'"rootfs=\/rootfs\/i$2_rootfs_r_wld"'/g' | tee temp_table.txt
    ####################################usb automation case############################
    usb_case_kernel_count=`cat temp_table.txt | grep "kernel=usb-" | wc -l`
    for i in $(seq $usb_case_kernel_count)
    do
        usb_case_kernel_keyword=`cat temp_table.txt | grep "kernel=usb-" | tail -n $i | head -n 1 | awk -F "kernel=usb-" '{print $2}' | awk '{print $1}'`
        cat temp_table.txt | sed 's/'"kernel=usb-$usb_case_kernel_keyword"'/'"kernel=uImage_$2_usb-$usb_case_kernel_keyword"'/g' | tee temp_table.txt
    done
    usb_case_dtb_count=`cat temp_table.txt | grep "fdt_file=usb-" | wc -l`
    for j in $(seq $usb_case_dtb_count)
    do
        usb_case_dtb_keyword=`cat temp_table.txt | grep "fdt_file=usb-" | tail -n $j | head -n 1| awk -F "fdt_file=usb-" '{print $2}' | awk '{print $1}' `
        cat temp_table.txt | sed 's/'"fdt_file=usb-$usb_case_dtb_keyword"'/'"fdt_file=dtb_$2$3_usb-$usb_case_dtb_keyword"'/g' | tee temp_table.txt
    done
    #############last define the default###################
    echo " " >> temp_table.txt 
    echo "TGE-LV-DEFAULT-CASE uImage_$2_$1 dtb_$2$3_$1 /rootfs/i$2_rootfs_r" >> temp_table.txt
    sleep 1
    cp ./temp_table.txt ./$5
    exit 0
fi
########################release####################################################
    cat $4 | sed 's/uImage/'"uImage_$2_d"'/g' | tee temp_table.txt
    sleep 1
    cat temp_table.txt | sed 's/dtb_default/'"dtb_$2$3_d"'/g' | tee temp_table.txt
    sleep 1
    cat temp_table.txt | sed 's/ecspi/'"dtb_$2$3_ecspi_d"'/g' | tee temp_table.txt
    cat temp_table.txt | sed 's/gpmi_weim/'"dtb_$2$3_gpmi_weim_d"'/g' | tee temp_table.txt
    cat temp_table.txt | sed 's/rootfs=_x/'"rootfs=\/rootfs\/hf\/i$2_rootfs"'/g' | tee temp_table.txt
    cat temp_table.txt | sed 's/rootfs=_fb/'"rootfs=\/rootfs\/hf\/i$2_rootfs_fb"'/g' | tee temp_table.txt
    cat temp_table.txt | sed 's/rootfs=_dfb/'"rootfs=\/rootfs\/hf\/i$2_rootfs_dfb"'/g' | tee temp_table.txt
    cat temp_table.txt | sed 's/rootfs=_wld/'"rootfs=\/rootfs\/hf\/i$2_rootfs_wld"'/g' | tee temp_table.txt
    ####################################usb automation case############################
    usb_case_kernel_count=`cat temp_table.txt | grep "kernel=usb-" | wc -l`
    for i in $(seq $usb_case_kernel_count)
    do
        usb_case_kernel_keyword=`cat temp_table.txt | grep "kernel=usb-" | tail -n $i | head -n 1 | awk -F "kernel=usb-" '{print $2}' | awk '{print $1}'`
        cat temp_table.txt | sed 's/'"kernel=usb-$usb_case_kernel_keyword"'/'"kernel=uImage_$2_usb-$usb_case_kernel_keyword"'/g' | tee temp_table.txt
    done
    usb_case_dtb_count=`cat temp_table.txt | grep "fdt_file=usb-" | wc -l`
    for j in $(seq $usb_case_dtb_count)
    do
        usb_case_dtb_keyword=`cat temp_table.txt | grep "fdt_file=usb-" | tail -n $j | head -n 1| awk -F "fdt_file=usb-" '{print $2}' | awk '{print $1}' `
        cat temp_table.txt | sed 's/'"fdt_file=usb-$usb_case_dtb_keyword"'/'"fdt_file=dtb_$2$3_usb-$usb_case_dtb_keyword"'/g' | tee temp_table.txt
    done

#############last define the default###################
    echo " " >> temp_table.txt 
    echo "TGE-LV-DEFAULT-CASE uImage_$2_d dtb_$2$3_d /rootfs/hf/i$2_rootfs" >> temp_table.txt
    sleep 1
    cp ./temp_table.txt ./$5
    exit 0
