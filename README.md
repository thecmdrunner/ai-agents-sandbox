# Dev Container

Single persistent container for Node.js development. Mounts `~/Developer` so Claude Code can work across projects.

## What's Included

- Ubuntu 24.04
- Node.js, Bun

## Usage

### Docker Compose (CLI)

```bash
# Build and start
docker compose up -d --build

# Attach
docker exec -it dev-sandbox bash

# Stop
docker compose down
```

### VS Code Dev Container

1. Install the [Dev Containers extension](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-containers)
2. Open this folder in VS Code
3. Click "Reopen in Container" when prompted

## Post-Setup

Inside the container:

```bash
npm install -g @anthropic-ai/claude-code
claude  # authenticate
```

## File Structure

```
.
├── .devcontainer/
│   └── devcontainer.json
├── Dockerfile
├── docker-compose.yml
└── README.md
```

## Volume Mounts

| Host | Container | Notes |
|------|-----------|-------|
| `~/Developer` | `~/Developer` | Your projects |
| `~/.gitconfig` | `~/.gitconfig` | Git config (read-only) |
| `~/.claude` | `~/.claude` | Claude Code config |
| `~/.config` | `~/.config` | App configs |
