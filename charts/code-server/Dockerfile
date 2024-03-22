FROM ubuntu:focal
LABEL maintainer="pypeaday"

ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get upgrade -y && \
  apt-get install -y \
  gnupg curl software-properties-common
#pkg-config libx11-dev

RUN echo "**** add repos ****" && \
  curl -s https://deb.nodesource.com/gpgkey/nodesource.gpg.key | apt-key add - && \
  add-apt-repository "deb [arch=amd64] https://deb.nodesource.com/node_14.x $(lsb_release -cs) main" && \
  curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add - && \
  add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"

RUN echo "**** install dependencies ****" && \
  add-apt-repository universe && \
  apt-get update && apt-get upgrade -y && \
  apt-get install -y \
  make \
  nodejs \
  git \
  jq \
  nano \
  vim \
  wget \
  postgresql-client \
  libgeos-dev \
  libssl-dev \
  libedit-dev \
  libncursesw5 \
  docker-ce-cli \
  python3 \
  python3-apt \
  python3-pip \
  python3-setuptools \
  python3-distlib \
  python3-distutils \
  python3-distutils-extra


RUN echo "**** install code-server ****" && \
  curl -fsSL https://code-server.dev/install.sh | sh -s -- --method=standalone --prefix=/usr/local

RUN echo "**** add codeuser ****" && \
  groupadd -r codeuser -g 1000 && \
  useradd --no-log-init -s /bin/bash -d /home/codeuser -m -u 1000 -g codeuser codeuser && \
  # TODO: make this safe
  echo codeuser:U6aMy0wojraho | chpasswd -e && \
  chown -R codeuser:codeuser \
  /home/codeuser

RUN echo "**** install k3d ****" && \
  wget -q -O - https://raw.githubusercontent.com/rancher/k3d/main/install.sh -O /tmp/k3d_install.sh && \
  bash /tmp/k3d_install.sh --no-sudo

RUN echo "**** install pyenv ****" && \
  git clone https://github.com/pyenv/pyenv.git /home/codeuser/.pyenv
ENV PYENV_ROOT /home/codeuser/.pyenv
RUN /home/codeuser/.pyenv/bin/pyenv install 3.10.12
RUN echo 'eval "$(pyenv init -)"' >> /home/codeuser/.bashrc

RUN echo "**** install jupyter ****" && \
  pip3 install jupyter jupyter-server


RUN echo "**** clean up ****" \
  #&& apt-get --purge remove pkg-config libx11-dev \
  && apt-get clean \
  && rm -rf \
  /tmp/* \
  /var/lib/apt/lists/* \
  /var/tmp/*

# ENV Setup
ENV SERVICE_URL https://open-vsx.org/vscode/gallery
ENV ITEM_URL https://open-vsx.org/vscode/item
ENV HOME /home/codeuser
ENV PATH ${HOME}/.local/bin:${PATH}
ENV PATH ${HOME}/.env/bin:${PATH}
ENV PATH ${PYENV_ROOT}:${PATH}
ENV SHELL /bin/bash
ENV DOCKER_HOST tcp://localhost:2375
WORKDIR /home/codeuser
EXPOSE 8443
USER codeuser
CMD [   "code-server", \
  "--bind-addr", "127.0.0.1:8443", \
  "--disable-telemetry", \
  "--auth", "none" \
  ]
