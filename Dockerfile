# Use ROS Noetic official base image
FROM ros:noetic

# Set frontend to noninteractive in apt-get to suppress interactive dialogs
ENV DEBIAN_FRONTEND noninteractive

# Update and install necessary ROS packages and system dependencies
RUN apt-get update && apt-get install -y \
    ros-noetic-gazebo-ros-pkgs \
    ros-noetic-gazebo-ros-control \
    ros-noetic-rviz \
    ros-noetic-rqt-graph \
    ros-noetic-grid-map \
    ros-noetic-pcl-ros \
    ros-noetic-eigen-conversions \  
    ros-noetic-tf-conversions \
    libqt5widgets5 \
    libqt5gui5 \
    libqt5core5a \
    qt5-default \
    libeigen3-dev \
    git \
    cmake \
    python3-catkin-tools \
    build-essential \
    && rm -rf /var/lib/apt/lists/*

# Use bash for subsequent commands to ensure compatibility with bash-specific scripts
SHELL ["/bin/bash", "-c"]

# Set up the catkin workspace
RUN mkdir -p /catkin_ws/src && \
    source /opt/ros/noetic/setup.bash && \
    catkin init --workspace /catkin_ws && \
    cd /catkin_ws/src

# Clone the necessary repositories including traversability_estimation
RUN cd /catkin_ws/src && \
    git clone -b noetic https://github.com/leggedrobotics/kindr.git && \
    git clone https://github.com/leggedrobotics/elevation_mapping.git && \
    git clone https://github.com/anybotics/kindr_ros.git && \
    git clone https://github.com/leggedrobotics/any_node.git && \
    git clone https://github.com/ANYbotics/message_logger.git && \
    git clone https://github.com/leggedrobotics/traversability_estimation.git

# Build the workspace
RUN source /opt/ros/noetic/setup.bash && \
    cd /catkin_ws && \
    catkin config --cmake-args -DCMAKE_BUILD_TYPE=Release && \
    catkin build

# Automatically source the workspace setup file and ROS setup for every new bash session
RUN echo "source /opt/ros/noetic/setup.bash" >> ~/.bashrc && \
    echo "source /catkin_ws/devel/setup.bash" >> ~/.bashrc

# Reset the frontend variable to avoid affecting applications that expect interactive frontend
ENV DEBIAN_FRONTEND dialog

CMD ["bash"]

