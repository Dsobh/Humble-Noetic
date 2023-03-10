#!/bin/bash

curl -sSL https://raw.githubusercontent.com/ros/rosdistro/master/ros.key -o /usr/share/keyrings/ros-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/ros-archive-keyring.gpg] http://packages.ros.org/ros2/ubuntu $(. /etc/os-release && echo $UBUNTU_CODENAME) main" | tee /etc/apt/sources.list.d/ros2.list > /dev/null
apt update
apt install -y ros-humble-ros-base

apt install -y ros-humble-rmw-cyclonedds-cpp ros-humble-rmw-fastrtps-cpp ros-humble-cyclonedds ros-humble-fastrtps

rosdep init
rosdep update

source /opt/ros/humble/setup.bash
mkdir -p ~/ros2_ws/src
cd ~/ros2_ws
rosdep install -i --from-path src --rosdistro humble -y
