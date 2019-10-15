#! /bin/sh

sed -e 's,^export ,,g;' /etc/profile.d/proxy.sh > /etc/proxy.conf
