#!/bin/bash

if pgrep -f goxray-cli > /dev/null; then
    echo '{"text": "vpn: goxray", "class": "vpn-on"}'
elif pgrep -f openfortivpn > /dev/null; then
    echo '{"text": "vpn: forti", "class": "vpn-on"}'
else
    echo '{"text": "vpn: off", "class": "vpn-off"}'
fi
