FROM feelpp/feelpp:latest
# OR if toolboxes are required
# FROM feelpp/feelpp-toolboxes:latest

USER root

# Avoid warnings by switching to noninteractive
ENV DEBIAN_FRONTEND=noninteractive

# This Dockerfile adds a non-root user with sudo access. Use the "remoteUser"
# property in devcontainer.json to use it. On Linux, the container user's GID/UIDs
# will be updated to match your local UID/GID (when using the dockerFile property).
# See https://aka.ms/vscode-remote/containers/non-root-user for details.
ARG USERNAME=vscode
ARG USER_UID=1001
ARG USER_GID=$USER_UID


# Configure apt and install packages
RUN apt-get update \
    && apt-get -y install --no-install-recommends apt-utils dialog 2>&1 \
    # \
    # Verify git, process tools, lsb-release (useful for CLI installs) installed\
    && apt-get -y install git iproute2 procps lsb-release \
    #\
    # Install C++ tools\
        && apt-get -y install build-essential npm git-lfs\
    #\
    # Create a non-root user to use if preferred - see https://aka.ms/vscode-remote/containers/non-root-user.\
    && groupadd --gid $USER_GID $USERNAME \
    && useradd -s /bin/bash --uid $USER_UID --gid $USER_GID -m $USERNAME \
    # [Optional] Add sudo support for the non-root user
    && apt-get install -y sudo \
    && echo $USERNAME ALL=\(root\) NOPASSWD:ALL > /etc/sudoers.d/$USERNAME\
    && chmod 0440 /etc/sudoers.d/$USERNAME \
    # add github ssh key
    && mkdir ~vscode/.ssh/ \
    && ssh-keyscan github.com >> ~vscode/.ssh/known_hosts \
    && chown -R vscode.$USER_GID ~vscode/.ssh \
    #
    # Clean up
    && apt-get autoremove -y \
    && apt-get clean -y \
    && rm -rf /var/lib/apt/lists/*

# Switch back to dialog for any ad-hoc use of apt-get
ENV DEBIAN_FRONTEND=dialog

RUN npm i -g @antora/cli@2.2 @antora/site-generator-default@2.2; 
