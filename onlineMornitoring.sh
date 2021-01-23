#!/bin/bash
#sleep 100

SOURCE="$0"
while [ -h "$SOURCE"  ]; do # resolve $SOURCE until the file is no longer a symlink
    DIR="$( cd -P "$( dirname "$SOURCE"  )" && pwd  )"
    SOURCE="$(readlink "$SOURCE")"
    [[ $SOURCE != /*  ]] && SOURCE="$DIR/$SOURCE" # if $SOURCE was a relative symlink, we need to resolve it relative to the path where the symlink file was located
done
DIR="$( cd -P "$( dirname "$SOURCE"  )" && pwd  )"

echo 日志保存路径：${DIR}/keepConnected.log

DATE=`date +%Y-%m-%d-%H:%M:%S`
tries=0
echo --- my_watchdog start: ${DATE} ---
while [[ $tries -lt 2 ]]
do
    if /bin/ping -c 1 -W 1 114.114.114.114 > /dev/null
    then
        echo --- network is OK, exit ---
        echo $DATE 网络正常，OK >> ${DIR}/keepConnected.log
        exit 0
    fi
    tries=$((tries+1))
    sleep 5
#       echo $DATE tries: $tries >>my_watchdog.log
done


if [ $tries -gt 0 ] 
then
    echo network is on connecting....
    echo -e datetime: ${DATE} 网络不正常 >> ${DIR}/keepConnected.log
    echo -e network is on connecting.... datetime: ${DATE} >> ${DIR}/keepConnected.log
    tries=0
    while [[ $tries -lt 5 ]] ; do 
        echo `/usr/local/miniconda3/envs/smsEnv/bin/python3 ${DIR}/demo.py` | sed -e 's/- /-\n/g' | sed -e 's/ -/\n/g' | sed -e 's/\./\n/g' >> ${DIR}/keepConnected.log
        echo ' ' >> ${DIR}/keepConnected.log

        if /bin/ping -c 1 -W 1 114.114.114.114 > /dev/null
        then
            echo --- network is OK, exit ---
            echo $DATE 网络连接成功 >> ${DIR}/keepConnected.log
            exit 0
        else
            tries=$((tries+1))
            echo $DATE 第${tries}次，尝试登录失败
            echo $DATE 第${tries}次，尝试登录失败 >> ${DIR}/keepConnected.log
            sleep 10
        fi
    done
fi

