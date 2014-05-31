#!/bin/sh

usage()
{
    echo "===========please input below parameters============"
    echo "==========='\$1' = release name========================"
    echo "==========='\$2' = soc id=============================="
    echo "==========='\$3' = board =============================="
    echo "==========='\$4' = fs backend=========================="
}
if [ $# -eq 0 ];then
    usage
    exit 1
fi

release_id=$1
platform=$2
#replace_list=uImage ecspi gpmi_weim rootfs_r_fb rootfs_ra_wld rootfs_r_dfb 
#replace_list=uImage

#cat generate_table.txt | grep "uImage_" | sed 's/uImage/'"uImage_$2_$1"'/g'
#cat generate_table.txt | tee temp_table.txt
#for i in $replace_list; do 
#    cat temp_table.txt | sed 's/'"$i"'/'"uImage_$2_$1"'/g' | tee temp_table.txt
#    sleep 1
#done

    cat generate_table.txt | sed 's/uImage/'"uImage_$2_$1"'/g' | tee temp_table.txt
    sleep 1
    cat temp_table.txt | sed 's/dtb_default/'"dtb_$2$3_$1"'/g' | tee temp_table.txt
    sleep 1
    cat temp_table.txt | sed 's/ecspi/'"dtb_$2$3_ecspi_$1"'/g' | tee temp_table.txt
    sleep 1
    cat temp_table.txt | sed 's/gpmi_weim/'"dtb_$2$3_gpmi_weim_$1"'/g' | tee temp_table.txt
    sleep 1
    cat temp_table.txt | sed 's/_r/'"\/rootfs\/i$2_rootfs_r"'/g' | tee temp_table.txt
    sleep 1
    cat temp_table.txt | sed 's/_fb/'"\/rootfs\/i$2_rootfs_r_fb"'/g' | tee temp_table.txt
    sleep 1
    cat temp_table.txt | sed 's/_dfb/'"\/rootfs\/i$2_rootfs_r_dfb"'/g' | tee temp_table.txt
    sleep 1
    cat temp_table.txt | sed 's/_wld/'"\/rootfs\/i$2_rootfs_r_wld"'/g' | tee temp_table.txt
    sleep 1
#############last define the default###################
    echo "TGE-LV-DEFAULT-CASE uImage_$2_$1 dtb_$2$3_$1 /rootfs/i$2_rootfs_r" >> temp_table.txt
#    cp temp_table.txt auto_case_table.txt



    exit 0
