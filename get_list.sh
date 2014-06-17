#!/bin/sh
##################imx63_AI_auto##################

EXT_CMD="compare.sh"
TABLEFILE="real_table"

total_tc=`cat real_table | grep "T..-LV" | wc -l `
echo "=============total_tc=$total_tc=========="
j=0
for i in `seq $total_tc` ; do
    AFTER_CASE_ID=`cat real_table | grep "T..-LV" | head -n $i | tail -n 1 | awk '{print $2}'`
    if [ -n "$AFTER_CASE_ID" ]
    then
        j=`expr $j + 1`
        case_list="${case_list} `cat real_table | grep "T..-LV" | head -n $i | tail -n 1 | awk '{print $1}'`"
    fi
done


for k in $case_list ; do
    sed -i 's/'"$k"'/'"$k $EXT_CMD $k $TABLEFILE;"'/g' imx63_AI_auto
done


echo "==============j=$j==============="
echo $case_list

