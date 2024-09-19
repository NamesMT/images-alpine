#!/bin/bash

set -e

## What this?
## Script to setup docker in a fresh alpine instance :D
## Credit goes to richart24se's gist: https://gist.github.com/richard24se/336cb2502400a63f4670c751eaca1929, is modified to add login script for zsh, fix usermod not found, remove build packages and fix docker-compose install (now install from registry, install from pip will error).

# change to root and install packages
su -c "apk add sudo shadow curl openrc"
# if your user doesn't exists then remove sudo passwords
USERNAME=$(whoami)
su -c "grep -qxF '${USERNAME} ALL=(ALL) NOPASSWD: ALL' /etc/sudoers || echo '${USERNAME} ALL=(ALL) NOPASSWD: ALL' |  tee -a /etc/sudoers"
# install docker, docker-compose
sudo apk add docker docker-compose
# mount cgroup
echo "cgroup /sys/fs/cgroup cgroup defaults 0 0" | sudo tee -a  /etc/fstab
# add perm docker
sudo usermod -aG docker ${USERNAME}
# get start script docker
curl https://gist.githubusercontent.com/NamesMT/0708cc223a3db878df0477159115a49b/raw/17f45c7f23d3ecd8125963d5171f046979cb8f28/alpine.docker.service.sh --output ${HOME}/alpine.docker.service.sh
# configure start docker when logging
echo "source $HOME/alpine.docker.service.sh" >> $HOME/.profile
# configure start docker for .zsh if .zshrc exists
if [ -e $HOME/.zshrc ]
then
    echo "source $HOME/alpine.docker.service.sh" >> $HOME/.zshrc
fi
# start docker
source $HOME/alpine.docker.service.sh
# verify docker note: first time with sudo
sudo docker info
# verify docker-compose
docker-compose version
# cgroup systemd
cat << EOT > $HOME/alpine.cgroup.systemd.sh
if [ ! -d /sys/fs/cgroup/systemd ]; then
  sudo mkdir /sys/fs/cgroup/systemd
  echo "creating cgroup systemd folder..."
fi
if ! grep -qs '/sys/fs/cgroup/systemd' /proc/mounts; then
  sudo mount -n -t cgroup -o none,name=systemd cgroup /sys/fs/cgroup/systemd
  echo "mounting cgroup systemd folder..."
fi
EOT
# configure start cgroup systemd
echo "source $HOME/alpine.cgroup.systemd.sh" >> $HOME/.profile
# configure start cgroup systemd for .zsh if .zshrc exists
if [ -e $HOME/.zshrc ]
then
    echo "source $HOME/alpine.cgroup.systemd.sh" >> $HOME/.zshrc
fi
# start cgroup systemd
source $HOME/alpine.cgroup.systemd.sh
