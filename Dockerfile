FROM ubuntu:24.04 AS builder

ARG USERNAME=thecmdrunner
ENV DEBIAN_FRONTEND=noninteractive

# Base tools
RUN apt-get update && apt-get install -y \
    git \
    curl \
    sudo \
    wget \
    unzip \
    ripgrep \
    ca-certificates \
    build-essential \
    # Dev deps
    postgresql-client \
    neofetch \
    tmux \
    zsh \
    # Misc
    btop \
    htop \
    neovim \
    nano \
    tree

# Create user with sudo
RUN useradd -m -s /bin/bash ${USERNAME} \
    && echo "${USERNAME} ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

# nvm (installs as user)
USER ${USERNAME}
WORKDIR /home/${USERNAME}
RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.3/install.sh | bash

# Bun
RUN curl -fsSL https://bun.sh/install | bash
ENV PATH="/home/${USERNAME}/.bun/bin:${PATH}"

WORKDIR /home/${USERNAME}/Developer
