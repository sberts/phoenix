FROM ubuntu:24.04

RUN apt-get -y update && apt-get -y upgrade

RUN apt-get -y install tmux vim python3 python3-pip python3-venv gnupg \
  software-properties-common wget curl unzip nodejs npm

RUN wget -O- https://apt.releases.hashicorp.com/gpg | gpg --dearmor | \
  tee /usr/share/keyrings/hashicorp-archive-keyring.gpg > /dev/null

RUN echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] \
  https://apt.releases.hashicorp.com $(lsb_release -cs) main" | \
  tee /etc/apt/sources.list.d/hashicorp.list

RUN apt -y update && apt-get install -y terraform

RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-aarch64.zip" -o "awscliv2.zip" && \
  unzip awscliv2.zip && ./aws/install

RUN useradd -ms /bin/bash newuser
USER newuser
WORKDIR /home/newuser
