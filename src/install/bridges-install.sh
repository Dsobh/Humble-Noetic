#!/bin/bash

cd /root/ros2_ws/src
git clone https://github.com/Dsobh/ros1_bridge.git

cd /root/ros2_ws

source /opt/ros/humble/setup.bash
source /root/catkin_ws/devel/setup.bash

colcon build

echo "source /opt/ros/humble/setup.bash" >> ~/.bashrc
echo "source /root/ros2_ws/install/setup.bash" >> ~/.bashrc
echo "source /root/catkin_ws/devel/setup.bash" >> ~/.bashrc
