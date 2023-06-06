#!/bin/bash

cd /root/ros2_ws/src
git clone https://github.com/Dsobh/ros1_bridge.git
git clone https://github.com/ros-controls/control_msgs.git

cd control_msgs/
git checkout humble

cd /root/ros2_ws

source /opt/ros/humble/setup.bash
source /root/catkin_ws/devel/setup.bash

colcon build
