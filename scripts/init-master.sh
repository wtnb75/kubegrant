#! /bin/sh

kubeadm init --apiserver-advertise-address=192.168.3.10 --pod-network-cidr=172.16.0.0/16 2>&1 | tee -a /tmp/kubeadm-init.log
# kubectl apply -f "https://cloud.weave.works/k8s/net?k8s-version=$(kubectl version | base64 | tr -d '\n')"
# kubectl apply -f https://raw.githubusercontent.com/coreos/flannel/master/Documentation/kube-flannel.yml
# kubectl apply -f https://docs.projectcalico.org/v3.9/manifests/calico.yaml
# kubectl apply -f /vagrant/calico.yaml
curl -sL https://github.com/projectcalico/calicoctl/releases/download/v3.9.0/calicoctl-linux-amd64 -o /usr/local/bin/calicoctl
chmod 755 /usr/local/bin/calicoctl

mkdir -p /home/vagrant/.kube
cp -i /etc/kubernetes/admin.conf /home/vagrant/.kube/config
chown -R vagrant:vagrant /home/vagrant/.kube

mkdir -p ${HOME}/.kube
cp -i /etc/kubernetes/admin.conf ${HOME}/.kube/config
