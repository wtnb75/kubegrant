#! /bin/sh

apt update
apt install -y docker.io

mkdir -p /etc/systemd/system/docker.service.d
cat <<EOF > /etc/systemd/system/docker.service.d/proxy.conf
[Service]
EnvironmentFile=-/etc/proxy.conf
EOF

mkdir -p /etc/docker

cat > /etc/docker/daemon.json <<EOF
{
  "exec-opts": ["native.cgroupdriver=systemd"],
  "log-driver": "json-file",
  "log-opts": {
    "max-size": "100m"
  }
}
EOF
chown root:docker /etc/docker/daemon.json
chmod 640 /etc/docker/daemon.json
usermod -aG docker vagrant
