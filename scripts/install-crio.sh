#! /bin/sh

apt update
apt install -y software-properties-common
add-apt-repository ppa:projectatomic/ppa
apt update
apt install -y cri-o-1.15

mkdir -p /etc/systemd/system/crio.service.d
cat <<EOF > /etc/systemd/system/crio.service.d/proxy.conf
[Service]
EnvironmentFile=-/etc/proxy.conf
EOF

systemctl enable --now crio
