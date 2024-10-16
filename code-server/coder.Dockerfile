FROM codercom/code-server:latest
LABEL maintainer="pypeaday"

ARG DEBIAN_FRONTEND=noninteractive

# USER root
#
# RUN apt-get update && apt-get upgrade -y && \
#   apt-get install -y \
#   gnupg curl software-properties-common
# #pkg-config libx11-dev
#
#
# RUN echo "**** install dependencies ****" && \
#   add-apt-repository universe && \
#   apt-get update && apt-get upgrade -y && \
#   apt-get install -y \
#   make \
#   nodejs \
#   git \
#   jq \
#   nano \
#   vim \
#   wget \
#   postgresql-client \
#   libgeos-dev \
#   libssl-dev \
#   libedit-dev \
#   libncursesw5 \
#   # idk how docker will work on podman host...
#   # docker-ce-cli \
#   python3 \
#   python3-apt \
#   python3-pip \
#   python3-setuptools \
#   python3-distlib \
#   python3-distutils \
#   python3-distutils-extra
#
#
# # TODO: come back to this later
# # RUN echo "**** install k3d ****" && \
# #   wget -q -O - https://raw.githubusercontent.com/rancher/k3d/main/install.sh -O /tmp/k3d_install.sh && \
# #   bash /tmp/k3d_install.sh --no-sudo
#
# RUN echo "**** clean up ****" \
#   #&& apt-get --purge remove pkg-config libx11-dev \
#   && apt-get clean \
#   && rm -rf \
#   /tmp/* \
#   /var/lib/apt/lists/* \
#   /var/tmp/*

RUN echo "**** install pyenv ****" && \
  git clone https://github.com/pyenv/pyenv.git .pyenv
ENV PYENV_ROOT $PWD/.pyenv
RUN .pyenv/bin/pyenv install 3.10.12 && \
  .pyenv/bin/pyenv global 3.10.12
# RUN echo 'eval "$(pyenv init -)"' >> /home/codeuser/.bashrc

# RUN echo "**** install jupyter ****" && \
#   pip3 install jupyter jupyter-server


# ENV Setup
# ENV SERVICE_URL https://open-vsx.org/vscode/gallery
# ENV ITEM_URL https://open-vsx.org/vscode/item
# ENV HOME /home/codeuser
# ENV PATH ${HOME}/.local/bin:${PATH}
# ENV PATH ${HOME}/.env/bin:${PATH}
# ENV PATH ${PYENV_ROOT}:${PATH}
# ENV SHELL /bin/bash
# TODO: what to do about podman?
ENV DOCKER_HOST tcp://localhost:2375

RUN .pyenv/bin/pyenv init -

EXPOSE 8080

