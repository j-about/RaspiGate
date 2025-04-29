#!/bin/bash
while true; do
    CONFIG_FILE=$(find ./configs -type f -name '*.ovpn' | shuf -n 1)

    AUTH_USER_PASS_FILE=$(mktemp)
    echo -e "${VPN_USERNAME}\n${VPN_PASSWORD}" > "$AUTH_USER_PASS_FILE"
    chmod 600 "$AUTH_USER_PASS_FILE"

    openvpn --config "$CONFIG_FILE" --auth-user-pass "$AUTH_USER_PASS_FILE" --resolv-retry 60 --script-security 2 --up "./up.sh" --ping 10 --ping-exit 60 --down "./down.sh"

    rm -f "$AUTH_USER_PASS_FILE"

    sleep 10
done