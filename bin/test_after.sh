#!/bin/bash
STATIC="src/web_inf/fnt/statics/"
PRJ_ROOT=`dirname "$0"`"/../"
STATIC_ROOT=$PRJ_ROOT$STATIC
LATEST_TAG=`cat $PRJ_ROOT/version.txt`

function pub_qstatic()
{
    echo "检测到此次提交中存在静态文件变更，是否需要执行部署静床？";
    echo "是(Yes) / 否(No)? "n
    read yes
    if test "$yes" = "y"
    then
        exec /home/q/php/qstatic_sdk/lib/pylon-qstatic.sh
    fi
    exit
}


FIXED_FILES=`git show $LATEST_TAG --name-only | awk '{if(NR>6){print $0}}'`
arr=($FIXED_FILES)
for files in ${arr[@]}
do
        [[ $files =~ $STATIC ]] && pub_qstatic
done
