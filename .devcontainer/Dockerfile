FROM ghcr.io/feelpp/feelpp-toolboxes:feature-toolboxes-v0.110.0-alpha.3-ubuntu-20.04
# OR if toolboxes are required
# FROM feelpp/feelpp-toolboxes:latest

USER root

# Avoid warnings by switching to noninteractive
ENV DEBIAN_FRONTEND=noninteractive

ARG USERNAME=feelpp
ARG USER_UID=999
ARG USER_GID=1000

RUN apt update \
    && apt -y install npm

# Setup demo environment variables
ENV LANG=en_US.UTF-8 \
    LANGUAGE=en_US.UTF-8 \
    LC_ALL=C.UTF-8 \
    OMPI_MCA_btl_vader_single_copy_mechanism=none

