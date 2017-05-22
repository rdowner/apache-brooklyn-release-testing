#!/usr/bin/env bash

# A blatantly selfish attempt by Richard for his own convenience by configuring for his own HTTP proxy server.
# If Richard's proxy server is not detected (`ping` with a 1-second timeout) then the script does nothing.

possible_proxy=172.25.50.5
ping -c 1 -W 1 $possible_proxy > /dev/null 2> /dev/null || {
    exit
}
proxy=http://$possible_proxy:3128/

echo http_proxy=$proxy >> /etc/environment
echo https_proxy=$proxy >> /etc/environment

if [ -d /etc/apt/apt.conf.d ]; then
    echo "Acquire::http::Proxy \"$proxy\";" > /etc/apt/apt.conf.d/proxy
    echo "Acquire::https::Proxy \"$proxy\";" >> /etc/apt/apt.conf.d/proxy
fi

[ -f /etc/yum.conf ] && echo "proxy \"$proxy\"" >> /etc/yum.conf

[ -f ~vagrant/.m2/settings.xml ] && sed -i.bak '/<\/settings>/ i <proxies> <proxy> <id>http-proxy</id> <protocol>http</protocol> <host>'$possible_proxy'</host> <port>3128</port> </proxy> </proxies>' ~vagrant/.m2/settings.xml

echo export http_proxy=$proxy
echo export https_proxy=$proxy

