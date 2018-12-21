ARG DOCKER_REGISTRY=docker.io
ARG FROM_IMG_REPO=qnib
ARG FROM_IMG_NAME="uplain-bazel"
ARG FROM_IMG_TAG="2018-12-21.1"
ARG FROM_IMG_HASH=""
FROM ${DOCKER_REGISTRY}/${FROM_IMG_REPO}/${FROM_IMG_NAME}:${FROM_IMG_TAG}${DOCKER_IMG_HASH}

ENV DEBIAN_FRONTEND=noninteractive \
    DEBCONF_NONINTERACTIVE_SEEN=true

#ARG CUDA_VER=9.2.88-1
ARG CUDA_VER=9.2.148-1


RUN apt-get update \
 && apt-get install -y --no-install-recommends wget=1.17.1-1ubuntu1.4 \
 && rm -rf /var/lib/apt/lists/* \
 && wget -c -v -nc https://developer.download.nvidia.com/compute/cuda/repos/ubuntu1604/x86_64/cuda-repo-ubuntu1604_${CUDA_VER}_amd64.deb \
 && dpkg -i cuda-repo-ubuntu1604_${CUDA_VER}_amd64.deb \
 && apt-key adv --fetch-keys http://developer.download.nvidia.com/compute/cuda/repos/ubuntu1604/x86_64/7fa2af80.pub \
 && apt-get update \
 && apt-get install -y --no-install-recommends cuda-9-2=${CUDA_VER} \
 && rm -rf /var/lib/apt/lists/*
CMD ["/usr/lib/nvidia/bin/nvidia-smi", "-L"]
