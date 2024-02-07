#!/bin/bash

# --- Install Docker

# Add Docker's official GPG key:
sudo apt-get update -y
sudo apt-get install -y ca-certificates curl
sudo install -y -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/debian/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc

# Add the repository to Apt sources:
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/debian \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update -y
sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
sudo systemctl enable docker.service
sudo systemctl enable containerd.service
sudo usermod -aG docker $USER

# --- Configure Caddy and Teleport
mkdir -p ~/compose-teleport/teleport/{config,data}
sudo docker network create caddy --driver=bridge

cd ~/compose-teleport
curl -L -o tmp-docker-compose.yml https://gist.github.com/GridexX/429d25e54f0374a6ed2f0e3a7c99f057/raw/3f6b83459e5b4de4e5d8f70067da37e64374a68c/docker-compose.yml
curl -O https://gist.github.com/GridexX/429d25e54f0374a6ed2f0e3a7c99f057/raw/3f6b83459e5b4de4e5d8f70067da37e64374a68c/teleport.yaml
mv teleport.yaml teleport/config/teleport.yaml
