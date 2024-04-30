#!/bin/bash

sudo apt-get update
sudo apt-get -y install git binutils rustc cargo pkg-config libssl-dev
git clone https://github.com/aws/efs-utils
cd efs-utils
sudo chmod -Rv 700 /home/ubuntu/efs-utils/build/

sudo apt-get install -y binutils gcc make
sudo apt-get install -y libssl-dev libcurl4-openssl-dev libfuse-dev

curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
source $HOME/.cargo/env

./build-deb.sh
sudo apt-get install -y ./build/amazon-efs-utils*deb
