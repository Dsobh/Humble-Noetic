FROM ubuntu:latest
USER root
ARG DEBIAN_FRONTEND=noninteractive

#Imports of files needed for installation
COPY ./src/install/cloneGit.sh /home/cloneGit.sh
COPY ./src/others/noetic-desktop.rosinstall /home/noetic-desktop.rosinstall
COPY ./src/others/rosconsole_log4cxx.cpp /home/rosconsole_log4cxx.cpp

COPY ./src/install/system-utils.sh /home/system-utils.sh
RUN chmod +x /home/system-utils.sh && ./home/system-utils.sh

COPY ./src/install/ros-packages.sh /home/ros-packages.sh
RUN chmod +x /home/ros-packages.sh && ./home/ros-packages.sh

#ROS2 (Humble) from packet installation
COPY ./src/install/ros2.sh /home/ros2.sh
RUN chmod +x /home/ros2.sh && ./home/ros2.sh

#Noetic from source installation
COPY ./src/install/ros1.sh /home/ros1.sh
RUN chmod +x /home/ros1.sh && ./home/ros1.sh

#Bridges installation
COPY ./src/install/bridges-install.sh /home/bridges-install.sh
RUN chmod +x /home/bridges-install.sh && ./home/bridges-install.sh

WORKDIR /root

COPY ./src/others/docker-entrypoint.sh /root/docker-entrypoint.sh
RUN chmod +x /root/docker-entrypoint.sh
ENTRYPOINT ["/root/docker-entrypoint.sh"]
