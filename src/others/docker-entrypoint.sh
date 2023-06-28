#!/bin/bash

source /root/catkin_ws/devel/setup.bash
source /opt/ros/humble/setup.bash
source /root/ros2_ws/install/setup.bash

ros2 launch ros1_bridge ros1_bridges_launch.py &

while true
do
  ros2 run ros1_bridge moveit_2_to_1
done

