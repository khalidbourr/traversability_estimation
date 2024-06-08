# Docker Environment for Traversability Estimation

This directory contains the Docker setup for the Traversability Estimation project, which simplifies the setup process for development and testing by encapsulating all dependencies and configurations.

## Overview
The provided Docker configuration ensures a consistent development environment, avoiding the "works on my machine" problem, and allows for easy setup of complex dependencies involved in the project.

## Getting Started

### Prerequisites
- **Docker Engine**: Install Docker on your machine. See [Docker documentation](https://docs.docker.com/get-docker/) for installation instructions.
- **NVIDIA GPU Drivers**: If you are planning to use GPU capabilities, ensure that you have the appropriate NVIDIA drivers installed. Additionally, install the [NVIDIA Container Toolkit](https://github.com/NVIDIA/nvidia-docker) for Docker to utilize GPU acceleration.

### Building the Docker Image
Navigate to the directory containing the Dockerfile and run the following command to build the Docker image. This process can take several minutes as it installs all required dependencies and sets up the environment.

```bash
docker build -t ros-traversability .```

### Running the Docker Container

Before you can run the Docker container with GUI support, you need to ensure the environment is configured correctly for displaying GUIs from Docker to your host machine. Start by making sure the `ros_traversability_estimation.sh` script is executable:

```bash
chmod +x ros_traversability_estimation.sh```

Then, execute the container using the script, which handles the necessary configurations for GPU usage and X server permissions:

```bash
./ros_traversability_estimation.sh```


