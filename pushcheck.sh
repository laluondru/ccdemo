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
#git checkout devops-pipeline
COMMIT=(3f2bd5b042115f846022679b0d19395f9a3341e7 49e5f653052ff753ba14bb67655f74b9c85d1ec7 a7b4fc7300b778a42b1bc2c46b32a45a2d74ceeb)
#COMMMIT=(407f9f7f4269f771226fbf97ccdec5298fe191a7)
#726202b7421df797a73c0be6731bcb754684c67f
#echo ${COMMMIT}
echo "value"
#VALUE=$(git cherry-pick {COMMMIT[@]} | grep -i "conflict")
echo ${COMMIT[@]}
if VALUE=$(git cherry-pick ${COMMIT[@]} | grep -i "nothing to commit")
then
   MESSAGE=$(cat .git/CHERRY_PICK_HEAD)
   echo "${MESSAGE} has conflicts"
   ACTUALCOMM=$(echo ${COMMIT[@]} | sed -E 's/'${MESSAGE}'//' | sed -e 's/\ *$//g')
   echo ${ACTUALCOMM}
   n=${#ACTUALCOMM}
   echo "The lenth of the strig is :" $n
   git cherry-pick --abort
   #if [[ ! -z "${ACTUALCOMM}" && "${ACTUALCOMM}" != " " ]]
       if [[ $n -ne 0 ]]
       echo "AAAAA: " ${ACTUALCOMM}
       then
          for EACH_COMMIT in ${ACTUALCOMM[@]}
          do
            echo $EACH_COMMIT
                if PUSHED=$(git cherry-pick ${EACH_COMMIT} | grep 'nothing to commit' 2>&1)
                then
                	   echo "${EACH_COMMIT} : is not Pushed"
                     git cherry-pick --abort

                elif [[ ABORT=$(git cherry-pick --abort) && PUSHED=$(git cherry-pick ${EACH_COMMIT} | grep 'Merge conflict' 2>&1) ]]
                then
                    echo ${EACH_COMMIT} have conflicts
                    git cherry-pick --abort

                else
                    echo "${EACH_COMMIT} pushing the changes"
                    git push origin devops_pipeline
                fi

              contiune
          done
       elif [[ $n -eq 0 ]]
       then
          	echo "stopping the script"
        	 exit 1
       else
         echo "Abort not happened, Please use git cherry-pick --abort"
       fi
elif [[ ABORT=$(git cherry-pick --abort) && VALUE=$(git cherry-pick ${COMMIT[@]} | grep -i "Merge conflict") ]]
then
    echo "it has merge conflicts"
    git cherry-pick --abort
    exit
elif [[ ABORT=$(git cherry-pick --abort) && VALUE=$(git cherry-pick ${COMMIT[@]} | grep -i "no changes added to commit") ]]
then
    echo "${VALUE} -- no changes added to commit"
else
    git push origin devops-pipeline
    echo "All commit are pushed"
    echo "do nothing"
fi
