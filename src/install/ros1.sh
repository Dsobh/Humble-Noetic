#!/bin/bash

rosdep init
rosdep update

./home/cloneGit.sh /home/noetic-desktop.rosinstall

wget  https://github.com/ros/std_msgs/archive/refs/heads/kinetic-devel.zip -O /root/catkin_ws/src/kinetic-devel.zip
unzip /root/catkin_ws/src/kinetic-devel.zip -d /root/catkin_ws/src/
rm /root/catkin_ws/src/kinetic-devel.zip

mv /home/rosconsole_log4cxx.cpp /root/catkin_ws/src/rosconsole-release-release-noetic-rosconsole-1.14.3-1/src/rosconsole/impl/rosconsole_log4cxx.cpp

cd /root/catkin_ws/src
git clone https://github.com/ros/geometry2.git

git clone https://github.com/ros-controls/control_msgs.git
cd control_msgs/
git checkout kinetic-devel

cd /root/catkin_ws

sudo apt update -y
sudo apt upgrade -y

catkin build
