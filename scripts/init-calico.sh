#! /bin/sh

while true; do
  kubectl get node && break
  sleep 5
done

kubectl apply -f /vagrant/calico.yaml
