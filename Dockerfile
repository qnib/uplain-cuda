ARG DOCKER_REGISTRY=docker.io
ARG FROM_IMG_REPO=qnib
ARG FROM_IMG_NAME="uplain-init"
ARG FROM_IMG_TAG="bionic-2018-12-23.1"
ARG FROM_IMG_HASH=""
FROM ${DOCKER_REGISTRY}/${FROM_IMG_REPO}/${FROM_IMG_NAME}:${FROM_IMG_TAG}${DOCKER_IMG_HASH}

ENV DEBIAN_FRONTEND=noninteractive \
    DEBCONF_NONINTERACTIVE_SEEN=true

ENV CUDA_VER=10.0
ENV CUDA_PATCH_VER=130-1
ARG UBUNTU_VER=1804


RUN apt-get update \
 && apt-get install -y --no-install-recommends wget gnupg2 \
 && rm -rf /var/lib/apt/lists/* \
 && wget --no-check-certificate -c -v -nc https://developer.download.nvidia.com/compute/cuda/repos/ubuntu${UBUNTU_VER}/x86_64/cuda-repo-ubuntu${UBUNTU_VER}_${CUDA_VER}.${CUDA_PATCH_VER}_amd64.deb \
 && dpkg -i cuda-repo-ubuntu${UBUNTU_VER}_${CUDA_VER}.${CUDA_PATCH_VER}_amd64.deb \
 && apt-key adv --fetch-keys http://developer.download.nvidia.com/compute/cuda/repos/ubuntu1604/x86_64/7fa2af80.pub \
 && apt-get update \
 && apt-get install -y --no-install-recommends cuda-10-0=${CUDA_VER}.${CUDA_PATCH_VER} \
 && rm -rf /var/lib/apt/lists/*
CMD ["/usr/lib/nvidia/bin/nvidia-smi", "-L"]
