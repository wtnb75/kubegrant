#! /bin/sh

curl -sL https://get.helm.sh/helm-v2.14.3-linux-amd64.tar.gz | tar xfz - -C /tmp
mv /tmp/linux-amd64/tiller /usr/local/bin/
mv /tmp/linux-amd64/helm /usr/local/bin/
rm -fr /tmp/linux-amd64
