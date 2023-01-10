# Humble-Noetic_Docker


**Humble-Noetic_Docker** is a dockerfile that allows execute Ros1 (Noetic) with Ros2 (Humble) over a Ubuntu 22 image.
The images are installed as follows:

- Ros Humble is installed from package.
- Ros Noetic is installed from source.
- */files/noetic-desktop.rosinstall* contains the packages needed for noetic installation
- */files/cloneGit.sh* is a script that download and unzip all of these packages.
- *rosconsole_log4cxx.cpp* is a modification of the source code of log4cxx to make it functional in ubuntu 22.

## Instructions

- Build docker image: In folder root -> docker build -t <imageName>:<imageTag> .
- Run docker image: docker run -it <imageName>:<imageTag> /bin/bash