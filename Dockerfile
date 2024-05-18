FROM nvidia/cuda:11.6.2-cudnn8-runtime-ubuntu20.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt update && \
    apt install -y bash \
        build-essential \
        vim \
        wget \
        screen \
        git \
        git-lfs \
        curl \
        ca-certificates \
        libsndfile1-dev \
        python3.8 \
        python3-pip \
        python3.8-venv \
        libgl1-mesa-glx && \
    rm -rf /var/lib/apt/lists

# Set the working directory in the container
WORKDIR /app

# Clone the ComfyUI repository
RUN git clone https://github.com/comfyanonymous/ComfyUI

# Set the working directory to the cloned repository
WORKDIR /app/ComfyUI

# Create and activate a virtual environment
RUN python3 -m venv venv

# Install dependencies
RUN . venv/bin/activate 
RUN pip install -r requirements.txt

# Install ComfyUI Manager
WORKDIR /app/ComfyUI/custom_nodes
RUN git clone https://github.com/ltdrdata/ComfyUI-Manager.git

# Make sure the virtual environment is activated and the dependencies are installed
# when the container is run by default.
CMD ["python3", "main.py", "--listen", "0.0.0.0", "--port", "8080"]
