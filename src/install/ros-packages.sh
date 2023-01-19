#!/bin/bash

apt update && apt upgrade

pip3 install -U catkin_tools
pip3 install -U rosdep
pip3 install defusedxml
pip install -U colcon-common-extensions

apt-get install -y libboost-all-dev
apt-get install -y libpoco-dev
apt-get install -y liblz4-dev
apt-get install -y liblog4cxx-dev
apt-get install -y libbz2-dev
apt-get install -y libgpgme-dev