#!/bin/sh
###############################################################################
#           How to Use this Script
#           the first parameter is CMDFILE name
#           the second parameter is TABLEFILE NAME
#
###############################################################################
usage()
{
    echo "====================please input below parameters======================"
    echo "===================='\$1' = CMDFILENAME================================"
    echo "===================='\$2' = TABLEFILENAME=============================="
}

if [ $# -ne 2 ]; then
    usage
    exit 1
fi

CMDFILE=$1
TABLEFILE=$2
EXT_CMD="compare.sh"

total_tc=`cat $TABLEFILE | grep "T..-LV" | wc -l `
echo "=============total_tc=$total_tc=========="
j=0
for i in `seq $total_tc` ; do
    AFTER_CASE_ID=`cat $TABLEFILE | grep "T..-LV" | head -n $i | tail -n 1 | awk '{print $2}'`
    if [ -n "$AFTER_CASE_ID" ]
    then
        j=`expr $j + 1`
        case_list="${case_list} `cat $TABLEFILE | grep "T..-LV" | head -n $i | tail -n 1 | awk '{print $1}'`"
    fi
done

for k in $case_list ; do
    sed -i 's/'"$k"'/'"$k $EXT_CMD $k $TABLEFILE;"'/g' $CMDFILE
done

sed -n '/compare.sh/p' $CMDFILE > temp.log
sed -i '/compare.sh/d' $CMDFILE
cat temp.log >> $CMDFILE
rm temp.log
echo "Generate the New CMDFILE , Pleae have a little time to Check !!!!"
exit 0
