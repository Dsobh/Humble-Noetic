# Humble-Noetic_Docker


**Humble-Noetic_Docker** is a dockerfile that allows execute Ros1 (Noetic) with Ros2 (Humble) over a Ubuntu 22 image.
The images are installed as follows:

- Ros Humble is installed from package.
- Ros Noetic is installed from source.

**Content**:

- */src/others/noetic-desktop.rosinstall* contains the packages needed for noetic installation
- */src/others/rosconsole_log4cxx.cpp* is a modification of the source code of log4cxx to make it functional in ubuntu 22.
- */src/others/docker-entrypoint.sh* is the entrypoint for the docker that is responsible for making sources for Ros1 and Ros2 and launch the launch.py file.

- */src/install/system-utils.sh* contains installations of utilities for ubuntu 22
- */src/install/ros-packages.sh* contains installation of packages needed for ros
- */src/install/cloneGit.sh* is a script that download and unzip all of these packages.
- */src/install/ros1.sh* contains the installation of ros1 (noetic)
- */src/install/ros2.sh* contains the installation of ros2 (humble)
- */src/install/bridges-install.sh* contains the installation of ros1_bridges (https://github.com/Dsobh/ros1_bridge)


**List of Bridges**

| Bridge | Topic |
| ------ | ----- |
| simple_bridge_1_to_2_tf | /tf |
| simple_bridge_1_to_2_scan | /scan |
| simple_bridge_1_to_2_odom | /mobile_base_controller/odom |
| simple_bridge_1_to_2_image | /xtion/rgb/image_raw |
| simple_bridge_2_to_1_twist | /mobile_base_controller/cmd_vel |
| simple_bridge_1_to_2_imu | /base_imu |


## Instructions

- Build the docker image. In folder root:

	```bash
	$ docker build -t <imageName>:<imageTag> .
	```
- Is also possible to pull the docker image from docker hub: https://hub.docker.com/repository/docker/dsobh/ros4ubuntu22/general

- Run docker image: 

	```bash
	$ docker run -it <imageName>:<imageTag> /bin/bash
	```

### Execute ros1_bridge

- 1º Terminal (ROS1):

	```bash
	$ source /root/catkin_ws/devel/setup.bash #Source Noetic
	$ roscore
	```
	
- 2º Terminal (ROS1 + ROS2). *In most cases, this will not be necessary, since docker starts with the execution of a roslaunch file that deploys the bridges.*

	```bash
	#Source humble
	$ source /opt/ros/humble/setup.bash 
	$ source /root/ros2_ws/install/setup.bash
	
	#Source noetic
	$source /root/catkin_ws/devel/setup
	
	#Launch bridge 
	$ ros2 run ros1_bridge <bridge_name> --ros-args -p topic_name:=<topic_name>
	```
	
### Bridge configuration

This image uses one yaml file to set which bridges to display. This file is named conf.yaml and it contains information about the Ip. This information is used as follows:

```
$ exports ROS_MASTER_URI=http://IP_number:11311
$ exports ROS_URI=Ip_number

```

The roslaunch file used will create the necessary nodes from conf.yaml
An example of this configuration file is show below:

```
bridges:
  - bridge1:
    - msg_type: /msg/Twist
    - topic_name: /mobile_base_controller/cmd_vel
  - bridge2:
    - msg_type: /geometry_msgs/msg/odom
    - topic_name: /mobile_base_controller/odom
    
```

	
