# Dev Container PRD

## Goal

Single persistent container for all Node.js development, mounting `~/Developer` so Claude Code can work across projects freely.

## Requirements

- Mount `~/Developer` as workspace
- Git works (push/pull via SSH)
- Common tools pre-installed: Node.js, Bun, psql client, ripgrep
- Claude Code installed manually (not via postCreateCommand)
- Persists installs/downloads across container rebuilds

## Setup

### File Structure

```
~/Developer/
├── Dockerfile
└── docker-compose.yml
```

### Dockerfile

```dockerfile
FROM ubuntu:24.04

ARG USERNAME=thecmdrunner
ENV DEBIAN_FRONTEND=noninteractive

# Base tools
RUN apt-get update && apt-get install -y \
    git \
    curl \
    wget \
    unzip \
    ripgrep \
    postgresql-client \
    build-essential \
    ca-certificates \
    sudo

# Create user with sudo
RUN useradd -m -s /bin/bash ${USERNAME} \
    && echo "${USERNAME} ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

# nvm (installs as user)
USER ${USERNAME}
WORKDIR /home/${U curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.3/install.sh | bash

# Bun
RUN curl -fsSL https://bun.sh/install | bash
ENV PATH="/home/${USERNAME}/.bun/bin:${PATH}"

WORKDIR /workspace
```

### docker-compose.yml

```yaml
services:
  dev:
    build:
      context: .
      args:
        USERNAME: ${USERNAME:-thecmdrunner}
    container_name: dev-sandbox
    volumes:
      - ~/Developer:/workspace
      - ~/.ssh:/home/${USERNAME:-thecmdrunner}/.ssh:ro
      - ~/.gitconfig:/home/${USERNAME:-thecmdrunner}/.gitconfig:ro
      - ~/.claude:/home/${USERNAME:-thecmdrunner}/.claude
      - ${SSH_AUTH_SOCK}:/ssh-agent
    environment:
      - SSH_AUTH_SOCK=/ssh-agent
    working_dir: /workspace
    user: ${USERNAME:-thecmdrunner}
    stdin_open: true
    tty: true
    command: /bin/bash
```

### .env (optional)

```
USERNAME=thecmdrunner
```

## Usage

```bash
# Build and start
cd ~/Developer
docker compose up -d --build

# Attach
docker exec -it dev-sandbox bash

# Stop
docker compose down
```

## Post-Setup (Manual)

Inside container:

```bash
npm install -g @anthropic-ai/claude-code
claude  # authenticate
```
