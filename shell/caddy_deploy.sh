#!/bin/bash
# -h v2ray host
# -p v2ray port
# -t Caddyfile template path

# install
sudo apt install -y debian-keyring debian-archive-keyring apt-transport-https
curl -1sLf 'https://dl.cloudsmith.io/public/caddy/stable/gpg.key' | sudo tee /etc/apt/trusted.gpg.d/caddy-stable.asc
curl -1sLf 'https://dl.cloudsmith.io/public/caddy/stable/debian.deb.txt' | sudo tee /etc/apt/sources.list.d/caddy-stable.list
sudo apt update
sudo apt install caddy

# write Caddyfile
while getopts "h:p:t:" opt; do
    case $opt in
    h)
        v2rayHost=$OPTARG
        ;;
    p)
        v2rayPort=$OPTARG
        ;;
    t)
        caddyfileTplPath=$OPTARG
        ;;
    ?)
        echo "未知参数"
        exit 1
        ;;
    esac
done

cat $caddyfileTplPath | sed "s/{v2rayHost}/${v2rayHost}/" | sed "s/{v2rayPort}/${v2rayPort}/" > /etc/caddy/Caddyfile