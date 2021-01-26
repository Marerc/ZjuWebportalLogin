#!/bin/bash


# author: lfe
# mail: kyui#zju.edu.cn 请替换#为@


# <-------------------用户需要修改的参数在这里------------------------------------->
# 请修改python3 bin文件路径，如果发生错误程序将无法运行
# python3 bin文件路径
python3_exec_path="/home/lfe/usr/bin/miniconda3/envs/onlineKeeping/bin/python3"
# 登录的域名或者ip，请注意，不需要填写路径，只需要填写ip或者域名，舟山校区：10.92.110.107，紫金港校区： 其余校区按照提示找到后填写
doi="10.92.110.107"
# 用户名
username="222222"
# 密码
password="333333"
# <--------------------修改结束--------------------->











# 需要的变量
SOURCE="$0"
while [ -h "$SOURCE"  ]; do # resolve $SOURCE until the file is no longer a symlink
    DIR="$( cd -P "$( dirname "$SOURCE"  )" && pwd  )"
    SOURCE="$(readlink "$SOURCE")"
    [[ $SOURCE != /*  ]] && SOURCE="$DIR/$SOURCE" # if $SOURCE was a relative symlink, we need to resolve it relative to the path where the symlink file was located
done
DIR="$( cd -P "$( dirname "$SOURCE"  )" && pwd  )"

echo 日志保存路径：${DIR}/keepConnected.log


# 检测日志文件是否大于500kb
# fileSize 单位是KB，大于这个体积的会被删除，小于或等于这个体积的日志不会被删除

fileSize=1024
logSize=`du -ha keepConnected.log | awk '{print $1}'`
echo "日志文件大小：${logSize}，文件 > ${fileSize}KB 会被删除。"
find ${DIR} -name 'keepConnected*' -size +${fileSize}k -exec rm {} \;


# 检测网络状态
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


# 重新登录，并检测是否上线，如果不在线就重连，否则退出
if [ $tries -gt 0 ] 
then
    echo network is on connecting....
    echo -e datetime: ${DATE} 网络不正常 >> ${DIR}/keepConnected.log
    echo -e network is on connecting.... datetime: ${DATE} >> ${DIR}/keepConnected.log
    tries=0
    while [[ $tries -lt 5 ]] ; do 
        echo `${python3_exec_path} ${DIR}/login.py -doi ${doi} -u ${username} -p ${password}` | sed -e 's/- /-\n/g' | sed -e 's/ -/\n/g' | sed -e 's/\./\n/g' >> ${DIR}/keepConnected.log
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

