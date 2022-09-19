#!/bin/sh
main=407f9f7f4269f771226fbf97ccdec5298fe191a7
#devops-pipeline=e4367ca03783eec21adba7f53fb9d2b6aee0b321


#main_index="$(git log -p -1 "$main" | grep -i index)"
#echo ${main_index}

#devops_pipeline="$(git log -p devops-pipeline > devops-out.txt )"
#echo "AAAA: ${devops_pipeline}"
#echo "-------------"
#cat devops-out.txt
#echo "=========="
#>>EOF
#if INDEX=$(cat devops-out.txt | grep -i "${main_index}")
#then
 #   echo ${main_index}
  #  #echo ${devops_pipeline}
   # echo ${INDEX}
   # echo "commit is already pushed "
#else
 #   git cherry-pick $main
 #3   echo $main is pushed
#fi
#EOF

#COMMMIT=(3f2bd5b042115f846022679b0d19395f9a3341e7 49e5f653052ff753ba14bb67655f74b9c85d1ec7)
COMMMIT=(407f9f7f4269f771226fbf97ccdec5298fe191a7)
#echo ${COMMMIT}
echo "value"
#VALUE=$(git cherry-pick {COMMMIT[@]} | grep -i "conflict")
if VALUE=$(git cherry-pick ${COMMMIT[@]} | grep -i "conflict")
then
   MESSAGE=$(cat .git/CHERRY_PICK_HEAD)
   echo "${MESSAGE} has conflicts"
   ACTUALCOMM=$(echo ${COMMMIT[@]} | sed -E 's/'${MESSAGE}'//' | sed -e 's/\ *$//g')
   echo ${ACTUALCOMM}
   n=${#ACTUALCOMM}
   echo "The lenth of the strig is :" $n
   git cherry-pick --abort
   #if [[ ! -z "${ACTUALCOMM}" && "${ACTUALCOMM}" != " " ]]
   if [[ $n -ne 0 ]]
   #echo "AAAAA: " ${ACTUALCOMM}
   then
      if PUSHED=$(git cherry-pick ${ACTUALCOMM} | grep -i 'insertion' 2>&1)
      then
      	   echo "BBBBBB: pushed " ${PUSHED}
           git push origin devops-pipeline
      else
          echo ${ACTUALCOMM} and {MESSAGE} both have conflicts
      fi
   elif [[ $n -eq 0 ]]
   then
      	echo "stopping the script"
    	exit 1
   else
     echo "Abort not happened, Please use git cherry-pick --abort"
   fi
else
    git push origin devops-pipeline
    echo "All commit are pushed"
    echo "do nothing"
fi
