#!/bin/bash
# Ask which Dashboard are you looking for?
while true; do
  printf "Pick which Dashboard are you looking for? \n Choose only 1. \n \n 1. Contesting Node-Red Dashboard \n 2. POTA Node-Red Dashboard\n"
  read -p "What is your choice? " flag_choice
  if  [[ ! $flag_choice -eq 1 ]] && [[ ! $flag_choice -eq 2 ]] && [[ ! $flag_choice -eq 3 ]]  ; then
    echo "You chose an incorrect number. Please choose a proper project."
      continue
  else
    break
  fi
done

cd $HOME
if [[ $flag_choice -eq 1 || $flag_choice -eq 3 ]]  && [[ ! -f qsos ]] ; then
# dashboard_name="Contesting"
bash <(curl -sL https://raw.githubusercontent.com/kd9lsv/Node-Red-AutoScripts/master/contesting_script.sh)
wait

elif  [[ $flag_choice -eq 2 || $flag_choice -eq 3 ]] && [[ ! -f pota ]] ; then
# dashboard_name="POTA"
bash <(curl -sL https://https://raw.githubusercontent.com/kd9lsv/Node-Red-AutoScripts/master/potainstall.sh)
wait
fi
