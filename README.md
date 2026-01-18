# AI Dev Sandbox

Sandbox for AI Agents to operate autonomously. Mounts `~/Developer`, `~/.config`, etc. so all code and config is shared with my Mac.

## Usage

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

## Volume Mounts

| Host | Container | Notes |
|------|-----------|-------|
| `~/Developer` | `~/Developer` | Your projects |
| `~/.gitconfig` | `~/.gitconfig` | Git config (read-only) |
| `~/.claude` | `~/.claude` | Claude Code config |
| `~/.config` | `~/.config` | App configs |
