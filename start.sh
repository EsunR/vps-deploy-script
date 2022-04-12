#!/bin/bash

# 读取配置
rootPath=$(dirname $0)
configFile="$rootPath/config.ini"
function ReadINIfile() {
    Section=$1
    Key=$2
    Configfile=$3
    ReadINI=$(awk -F '=' '/\['$Section'\]/{a=1}a==1&&$1~/'$Key'/{print $2;exit}' $Configfile)
    echo "$ReadINI"
}

v2rayHost=$(ReadINIfile "v2ray" "host" "$configFile")
v2rayPort=$(ReadINIfile "v2ray" "port" "$configFile")
caddyfilePath="${rootPath}/Caddyfile"

$rootPath/shell/caddy_deploy.sh -h $v2rayHost -p $v2rayPort -t $caddyfilePath
$rootPath/shell/v2ray_deploy.sh $v2rayPort $v2rayHost