#! /bin/sh
kubever=${1-"1.15.4-00"}
#kubever=${1-"1.16.0-00"}

myip=$(ip a | awk '/192.168/{print $2;}' | cut -f1 -d/)

cat <<EOF > /etc/default/kubelet
KUBELET_EXTRA_ARGS=--node-ip=${myip}
EOF

apt update
apt install -y apt-transport-https curl
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add -
cat <<EOF >/etc/apt/sources.list.d/kubernetes.list
deb https://apt.kubernetes.io/ kubernetes-xenial main
EOF
apt update
apt install -y kubelet=${kubever} kubeadm=${kubever} kubectl=${kubever}
apt-mark hold kubelet kubeadm kubectl

systemctl enable --now kubelet
