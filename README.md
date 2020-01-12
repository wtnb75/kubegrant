# Usage

- proxy setting
  - export http_proxy=...
  - export https_proxy=...
  - export no_proxy=...
- vagrant up
- sh host-init-workers.sh
- (master) helm init

## verify

- vagrant ssh master
   - kubectl get nodes -o wide

```
vagrant@master:~$ kubectl get node -o wide
NAME            STATUS   ROLES    AGE   VERSION   INTERNAL-IP    EXTERNAL-IP   OS-IMAGE                KERNEL-VERSION               CONTAINER-RUNTIME
master          Ready    master   20m   v1.14.6   192.168.3.10   <none>        Ubuntu 18.04.3 LTS      4.15.0-64-generic            docker://18.9.9
worker1         Ready    <none>   84s   v1.14.6   192.168.3.20   <none>        Ubuntu 16.04.6 LTS      4.4.0-164-generic            docker://18.3.1
worker2         Ready    <none>   82s   v1.14.6   192.168.3.21   <none>        Ubuntu 18.04.3 LTS      4.15.0-64-generic            docker://19.3.2
worker3.local   Ready    <none>   79s   v1.14.6   192.168.3.22   <none>        CentOS Linux 7 (Core)   3.10.0-957.12.2.el7.x86_64   docker://19.3.2
worker4.local   Ready    <none>   73s   v1.14.6   192.168.3.23   <none>        CentOS Linux 8 (Core)   4.18.0-80.7.1.el8_0.x86_64   docker://18.9.1
```

# OpenEBS storage

#- kubectl apply -f https://openebs.github.io/charts/openebs-operator.yaml
- kubectl apply -f https://raw.githubusercontent.com/openebs/openebs/master/k8s/openebs-operator.yaml
- helm repo update
- helm install --namespace openebs --name openebs stable/openebs

## verify

- kubectl get pods -n openebs
- kubectl get sc
- kubectl get blockdevice -n openebs
- kubectl get sp

# S3 storage

create secret

- kubectl create -f csi-s3/01-secret.yaml

install

- kubectl create -f csi-s3/02_1-provisioner.yaml
- kubectl create -f csi-s3/02_2-attacher.yaml
- kubectl create -f csi-s3/02_3-csi-s3.yaml

create storage class, pvc
- kubectl create -f csi-s3/03-storageclass.yaml
- kubectl create -f csi-s3/04-pvc.yaml

## verify

- kubectl get pvc

boot pod

- kubectl create -f csi-s3/99-pod.yaml
- kubectl exec -ti csi-s3-test-nginx bash
  - mount | grep fuse

# Links

- [nomadgrant](https://github.com/wtnb75/nomadgrant): you need hashicopr nomad?
