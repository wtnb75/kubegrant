#! /bin/sh

cd $(dirname $0)
vagrant ssh-config > ssh_config

joincmd="$(ssh -F ssh_config master kubeadm token create --print-join-command)"

for w in $(grep '^Host worker' ssh_config | cut -f2 -d' '); do
  echo $w
  ssh -F ssh_config $w sudo ${joincmd}
done
