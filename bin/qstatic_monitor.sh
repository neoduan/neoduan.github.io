#!/bin/bash

echo "-----start"
#需要更改此文件夹为静床路径
STATIC="src/web_inf/fnt/statics/"

PRJ_ROOT=`dirname "$0"`"/../"
echo $PRJ_ROOT;
STATIC_ROOT=$PRJ_ROOT$STATIC
LATEST_TAG=`cat $PRJ_ROOT/version.txt`

function pub_qstatic()
{
    echo "GIT TAG success."
    echo -e "\n检测到此次提交中，有静床文件变更，请执行以下选择，是否发布静床..."
    export ENV=dev
    exec /home/q/php/qstatic_sdk/lib/pylon-qstatic.sh reload
    exit
}


FIXED_FILES=`git show $LATEST_TAG --name-only | awk '{if(NR>6){print $0}}'`
echo $FIXED_FILES;
arr=($FIXED_FILES)
for files in ${arr[@]}
do
        echo "----"$files
        echo "*****"$STATIC
        [[ $files =~ $STATIC ]] && pub_qstatic
done
