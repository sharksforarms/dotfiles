FROM ubuntu:20.04

RUN apt update && apt install -y sudo vim ansible
RUN useradd --create-home --shell /bin/bash --groups sudo --gid root --uid 1001 -p "$(openssl passwd -1 letmein)" sharks

USER sharks
WORKDIR /home/sharks
COPY . /home/sharks/dotfiles
