#!/usr/bin/env bash
set -o nounset -o errexit
export PATH=/usr/sbin:/usr/bin:$PATH
IFNAME=$(ip route ls | grep -e 'default via' | awk '{ print $5 }')
echo $(ip addr show ${IFNAME} | grep -Eo '[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}' | head -1)


