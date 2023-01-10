#!/bin/bash

input=$1
#output=$2
catkin_url=$HOME/catkin_ws/src

id=1;

mkdir -p "$catkin_url"

while read -r line;
do
	wget "$line" -O "$catkin_url""/paquete_$id.tar.gz"
	tar -xvf "$catkin_url""/paquete_$id.tar.gz" -C "$catkin_url" 
	rm "$catkin_url""/paquete_$id.tar.gz"
	let id=id+1
done < "$input"
