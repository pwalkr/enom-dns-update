#!/bin/sh

passwd="$1"

if [ -z "$2" ]; then
    echo "Usage: $(basename "$0") <passwd> [host[, host]]"
    echo "    (use domain password for access.enom.com)"
    exit
fi
shift

ip="$(curl --silent https://ipinfo.io/ip)"
echo "Pointing DNS records to IP $ip"

for host in "$@"; do
    echo "Updating $host"
    curl --get \
        -d command=setdnshost \
        -d zone="$host" \
        -d address="$ip" \
        -d domainpassword=IZpH5x6uDTW4ZngnfSZ6ccenbio8I7 \
        "https://reseller.enom.com/interface.asp"
    sleep 1
done
