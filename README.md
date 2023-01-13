# Humble-Noetic_Docker


**Humble-Noetic_Docker** is a dockerfile that allows execute Ros1 (Noetic) with Ros2 (Humble) over a Ubuntu 22 image.
The images are installed as follows:

- Ros Humble is installed from package.
- Ros Noetic is installed from source.
- */files/noetic-desktop.rosinstall* contains the packages needed for noetic installation
- */files/cloneGit.sh* is a script that download and unzip all of these packages.
- *rosconsole_log4cxx.cpp* is a modification of the source code of log4cxx to make it functional in ubuntu 22.

## Instructions

- Build docker image. In folder root:

	```bash
	$ docker build -t <imageName>:<imageTag> .
	```

- Run docker image: 

	```bash
	$ docker run -it <imageName>:<imageTag> /bin/bash
	```

## Execute ros1_bridge

- 1º Terminal (ROS1):

	```bash
	$ source /root/catkin_ws/devel/setup.bash #Source Noetic
	$ roscore
	```
	
- 2º Terminal (ROS1 + ROS2)

	```bash
	#Source humble
	$ source /opt/ros/humble/setup.bash 
	$ source /root/ros2_ws/install/setup.bash
	
	#Source noetic
	$source /root/catkin_ws/devel/setup
	
	#Launch bridge
	$ ros2 run ros1_bridge dynamic_bridge
	```
