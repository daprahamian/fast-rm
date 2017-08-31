#!/bin/bash

rmf_single_dir() {
    if [ ! -d "$1" ]
    then
      echo "Directory '$1' does not exist"
      exit 1
    fi
    
    
    newFile=`echo "$1" | sed -e 's#/#_#g'`
    newFile=".__$newFile"
    
    while [ -e "$newFile" ]
    do
      newFile="${newFile}_"
    done
    
    echo "Moving $1 to $newFile so it can be deleted"
    
    mv -f $1 $newFile
    rm -rf $newFile &
}

if [ -z "$1" ]
then
  echo "Error: Need to provide a directory"
  exit 1
fi

for var in $@
do
  rmf_single_dir $var
done