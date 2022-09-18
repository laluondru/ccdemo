#!/bin/sh
main=3f2bd5b042115f846022679b0d19395f9a3341e7
#devops-pipeline=e4367ca03783eec21adba7f53fb9d2b6aee0b321


main_index="$(git log -p -1 "$main" | grep -i index)"
echo ${main_index}

devops_pipeline="$(git log -p devops-pipeline > devops-out.txt )"
#echo "AAAA: ${devops_pipeline}"
echo "-------------"
#cat devops-out.txt
echo "=========="

if INDEX=$(cat devops-out.txt | grep -i "${main_index}")
then
    echo ${main_index}
    #echo ${devops_pipeline}
    echo ${INDEX}
    echo "commit is already pushed "
else
    git cherry-pick $main
    echo $main is pushed
fi   
