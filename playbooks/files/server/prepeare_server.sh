#!/bin/bash

/usr/share/easy-rsa/3.0.8/easyrsa init-pki
echo 'rasvpn' | /usr/share/easy-rsa/3.0.8/easyrsa build-ca nopass
echo 'rasvpn' | /usr/share/easy-rsa/3.0.8/easyrsa gen-req server nopass
echo 'yes' | /usr/share/easy-rsa/3.0.8/easyrsa sign-req server server
/usr/share/easy-rsa/3.0.8/easyrsa gen-dh
openvpn --genkey --secret ta.key
echo 'client' | /usr/share/easy-rsa/3/easyrsa gen-req client nopass
echo 'yes' | /usr/share/easy-rsa/3/easyrsa sign-req client client
mkdir /root/.client
cp /etc/openvpn/pki/issued/client.crt /root/.client/client.crt
sed -i '1,64d' /root/.client/client.crt
cp /etc/openvpn/pki/ca.crt /root/.client/ca.crt
cp /etc/openvpn/pki/private/client.key /root/.client/client.key
rsync /root/.client/* root@192.168.10.20:/etc/openvpn/client/

systemctl start openvpn@server
systemctl enable openvpn@server
