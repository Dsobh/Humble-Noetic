#!/bin/bash

source /opt/ros/humble/setup.bash
source /root/ros2_ws/install/setup.bash
source /root/catkin_ws/devel/setup.bash

ros2 launch ros1_bridges_launch.py
