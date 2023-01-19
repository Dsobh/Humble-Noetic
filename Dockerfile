FROM ubuntu:latest
USER root
ARG DEBIAN_FRONTEND=noninteractive

#Imports of files needed for installation
COPY ./src/install/cloneGit.sh /home/cloneGit.sh
COPY ./src/install/system-utils.sh /home/system-utils.sh
COPY ./src/install/ros-packages.sh /home/ros-packages.sh
COPY ./src/install/ros1.sh /home/ros1.sh
COPY ./src/install/ros2.sh /home/ros2.sh
COPY ./src/install/bridges-install.sh /home/bridges-install.sh

COPY ./src/others/noetic-desktop.rosinstall /home/noetic-desktop.rosinstall
COPY ./src/others/rosconsole_log4cxx.cpp /home/rosconsole_log4cxx.cpp


RUN chmod +x /home/system-utils.sh && ./home/system-utils.sh
RUN chmod +x /home/ros-packages.sh && ./home/ros-packages.sh

#ROS2 (Humble) from packet installation
RUN chmod +x /home/ros2.sh && ./home/ros2.sh

#Noetic from source installation
RUN chmod +x /home/ros1.sh && ./home/ros1.sh

#Bridges installation
RUN chmod +x /home/bridges-install.sh && ./home/bridges-install.sh

WORKDIR /root


