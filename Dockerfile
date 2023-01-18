FROM ubuntu:latest
ARG DEBIAN_FRONTEND=noninteractive

#Copiamos el script para descargarse noetic y descomprimirlo
COPY ./files/cloneGit.sh /home/cloneGit.sh
COPY ./files/noetic-desktop.rosinstall /home/noetic-desktop.rosinstall

RUN apt update && apt upgrade
RUN apt-get install -y wget
RUN apt install -y sudo
RUN apt-get install -y python3-pip
RUN pip3 install -U catkin_tools
RUN sudo pip3 install -U rosdep
RUN sudo apt install -y zip
RUN sudo apt install -y vim
RUN apt-get install -y git
RUN pip3 install defusedxml
RUN pip install -y python3-colcon-common-extensions 

#
#Humble from packet instalation
#

RUN apt update && apt install -y curl
RUN curl -sSL https://raw.githubusercontent.com/ros/rosdistro/master/ros.key -o /usr/share/keyrings/ros-archive-keyring.gpg
RUN echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/ros-archive-keyring.gpg] http://packages.ros.org/ros2/ubuntu $(. /etc/os-release && echo $UBUNTU_CODENAME) main" | tee /etc/apt/sources.list.d/ros2.list > /dev/null
RUN apt update
RUN apt install -y ros-humble-ros-base

#
#Noetic from source instalation
#

RUN rosdep init
RUN rosdep update
RUN sudo apt-get update -y
RUN sudo apt-get install -y libboost-all-dev
RUN sudo apt-get install -y libpoco-dev
RUN sudo apt-get install -y liblz4-dev
RUN sudo apt-get install -y liblog4cxx-dev
RUN sudo apt-get install -y libbz2-dev
RUN sudo apt-get install -y libgpgme-dev

RUN ./home/cloneGit.sh /home/noetic-desktop.rosinstall

RUN wget  https://github.com/ros/std_msgs/archive/refs/heads/kinetic-devel.zip -O /root/catkin_ws/src/kinetic-devel.zip
RUN unzip /root/catkin_ws/src/kinetic-devel.zip -d /root/catkin_ws/src/
RUN rm /root/catkin_ws/src/kinetic-devel.zip

COPY ./files/rosconsole_log4cxx.cpp /root/catkin_ws/src/rosconsole-release-release-noetic-rosconsole-1.14.3-1/src/rosconsole/impl/rosconsole_log4cxx.cpp
	
WORKDIR /root/catkin_ws/src
RUN git clone https://github.com/ros/geometry2.git

WORKDIR /root/catkin_ws

RUN sudo apt update -y
RUN sudo apt upgrade -y
RUN catkin build

WORKDIR /root/ros2_ws/src
RUN git clone https://github.com/Dsobh/ros1_bridge.git

WORKDIR /root/ros2_ws
RUN /home/ros_source.sh

RUN echo "source /opt/ros/humble/setup.bash" >> ~/.bashrc
RUN echo "source /root/ros2_ws/install/setup.bash" >> ~/.bashrc
RUN echo "source /root/catkin_ws/devel/setup.bash" >> ~/.bashrc




