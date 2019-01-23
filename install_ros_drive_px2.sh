#!/bin/bash
sudo apt-add-repository universe
sudo apt-add-repository multiverse
sudo apt-add-repository restricted
sudo apt-get update

sudo sh -c 'echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list'

sudo apt-key adv --keyserver hkp://ha.pool.sks-keyservers.net:80 --recv-key 0xB01FA116

sudo apt-get install libssl1.0.0/xenial libssl-doc/xenial libssl-dev/xenial

sudo apt-get update
sudo apt-get install ros-kinetic-desktop-full
sudo apt-get install python-rosdep -y

sudo c_rehash /etc/ssl/certs

sudo rosdep init

rosdep update
echo "source /opt/ros/kinetic/setup.bash" >> ~/.bashrc
source ~/.bashrc

sudo apt-get install python-rosinstall -y

DEFAULTDIR=~/catkin_ws
CLDIR="$1"
if [ ! -z "$CLDIR" ]; then 
 DEFAULTDIR=~/"$CLDIR"
fi
if [ -e "$DEFAULTDIR" ] ; then
  echo "$DEFAULTDIR already exists; no action taken" 
  exit 1
else 
  echo "Creating Catkin Workspace: $DEFAULTDIR"
fi

mkdir -p "$DEFAULTDIR"/src 
cd "$DEFAULTDIR"
source /opt/ros/kinetic/setup.bash
catkin_make

echo "export LD_LIBRARY_PATH=/usr/local/lib:/usr/lib:/usr/lib/aarch64-linux-gnu:$LD_LIBRARY_PATH" >> ~/.bashrc

echo "source ~/catkin_ws/devel/setup.bash" >> ~/.bashrc

echo "#export ROS_MASTER_URI=http://192.168.1.1:11311" >> ~/.bashrc
echo "#export ROS_HOSTNAME=192.168.1.1" >> ~/.bashrc

echo "export ROS_MASTER_URI=http://localhost:11311" >> ~/.bashrc
echo "export ROS_HOSTNAME=localhost" >> ~/.bashrc
