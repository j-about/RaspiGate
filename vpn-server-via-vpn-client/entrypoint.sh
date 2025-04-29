#!/bin/bash
export EASYRSA_BATCH=1

cd conf

if [ -z "$(find . -maxdepth 1 -mindepth 1 -not -name '.*' -print -quit)" ]; then

    make-cadir easy-rsa
    cd easy-rsa

    echo "set_var EASYRSA_KEY_SIZE 4096
set_var EASYRSA_CA_EXPIRE 5475
set_var EASYRSA_CERT_EXPIRE 1825
set_var EASYRSA_CRL_DAYS 180
set_var EASYRSA_CERT_RENEW 60
set_var EASYRSA_DIGEST \"sha512\"" > vars
    ./easyrsa init-pki
    ./easyrsa build-ca nopass
    ./easyrsa gen-req $VPN_SERVER_VVC_EASYRSA_SERVER_NAME nopass
    yes yes | ./easyrsa sign-req server $VPN_SERVER_VVC_EASYRSA_SERVER_NAME 
    ./easyrsa gen-dh
    openvpn --genkey secret pki/ta.key
    ./easyrsa gen-req $EASYRSA_CLIENT_NAME nopass
    yes yes | ./easyrsa sign-req client $EASYRSA_CLIENT_NAME
    cd ../

    echo "local $VPN_SERVER_VVC_STATIC_IP
port $VPN_SERVER_VVC_PORT
proto $VPN_SERVER_VVC_PROTOCOL
dev tun
ca /etc/openvpn/pki/ca.crt
cert /etc/openvpn/pki/issued/$VPN_SERVER_VVC_EASYRSA_SERVER_NAME.crt
key /etc/openvpn/pki/private/$VPN_SERVER_VVC_EASYRSA_SERVER_NAME.key
dh /etc/openvpn/pki/dh.pem
tls-auth /etc/openvpn/pki/ta.key 0
server $VPN_SERVER_VVC_NETWORK $VPN_SERVER_VVC_NETMASK
push \"redirect-gateway def1\"
push \"route $NETWORK $NETMASK\"
push \"dhcp-option DNS $VPN_CLIENT_DNS_1\"
push \"dhcp-option DNS $VPN_CLIENT_DNS_2\"
keepalive 10 120
cipher AES-256-GCM
auth SHA512
user nobody
group nogroup
persist-key
persist-tun
verb 3
explicit-exit-notify 1
duplicate-cn
setenv VPN_CLIENT_STATIC_IP $VPN_CLIENT_STATIC_IP" > server.conf

    echo "client
dev tun
proto $VPN_SERVER_VVC_PROTOCOL
remote $VPN_SERVER_VVC_HOST $VPN_SERVER_VVC_PORT
resolv-retry infinite
nobind
persist-tun
persist-key
cipher AES-256-GCM
auth SHA512
remote-cert-tls server
<tls-auth>" > $EASYRSA_CLIENT_NAME.ovpn

    cat ./easy-rsa/pki/ta.key >> $EASYRSA_CLIENT_NAME.ovpn
    echo -e "</tls-auth>" >> $EASYRSA_CLIENT_NAME.ovpn

    echo -e "key-direction 1" >> $EASYRSA_CLIENT_NAME.ovpn

    echo -e "<ca>" >> $EASYRSA_CLIENT_NAME.ovpn
    cat ./easy-rsa/pki/ca.crt >> $EASYRSA_CLIENT_NAME.ovpn
    echo -e "</ca>" >> $EASYRSA_CLIENT_NAME.ovpn

    echo -e "<key>" >> $EASYRSA_CLIENT_NAME.ovpn
    cat ./easy-rsa/pki/private/$EASYRSA_CLIENT_NAME.key >> $EASYRSA_CLIENT_NAME.ovpn
    echo -e "</key>" >> $EASYRSA_CLIENT_NAME.ovpn

    echo -e "<cert>" >> $EASYRSA_CLIENT_NAME.ovpn
    cat ./easy-rsa/pki/issued/$EASYRSA_CLIENT_NAME.crt >> $EASYRSA_CLIENT_NAME.ovpn
    echo -e "</cert>" >> $EASYRSA_CLIENT_NAME.ovpn

    echo -e "verb 3" >> $EASYRSA_CLIENT_NAME.ovpn

fi

cp ./easy-rsa/pki /etc/openvpn/pki -r
cp ./server.conf /etc/openvpn/server.conf

cd ..

openvpn --config "/etc/openvpn/server.conf" --script-security 2 --up "./up.sh" --down "./down.sh"