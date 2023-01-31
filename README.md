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
- Is also possible to pull the docker image from docker hub: https://hub.docker.com/layers/dsobh/ros4ubuntu22/latest/images/sha256-5c2c280689caef8ecd7f5bab52004bbff86dfeca440577b6fc5d22610cdc7cd6?context=repo

- Run docker image:

We need to keep in mind a few things when launching the container. First of all is setting environment variables (ROS_MASTER_URI and ROS_IP) with the *--env* flag. Secondly we will use the *--network* flag to start the container as host.
We also need to pass the conf.yaml file to the docker when we run it.

	```bash
	$ docker run --rm --env ROS_MASTER_URI='http://10.68.0.1:11311' --env ROS_IP='10.68.0.129' --network host -v /<AbsolutePath>/conf.yaml:/root/conf.yaml -it rep:tag
	```
	
If the previous command dont launch the ros bridges we can force the docker to start using the entrypoint script:

```bash
	$ docker run --rm --env ROS_MASTER_URI='http://10.68.0.1:11311' --env ROS_IP='10.68.0.129' --network host -v /<AbsolutePath>/conf.yaml:/root/conf.yaml -it rep:tag /root/docker-entrypoint.sh
	```

### Execute ros1_bridge
The image automatically starts the bridges, but in case the user wants to start it manually :

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

This image uses one yaml file to set which bridges to display. This file is named conf.yaml and it contains information about the bridges.
The roslaunch file used will create the necessary nodes from this conf.yaml
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

	
