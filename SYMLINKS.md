# Dotfiles Symlinks

This document lists all files and directories that are symlinked from this dotfiles repository to the home directory.

## Configuration Files

| Symlink | Target | Stow Command |
|---------|--------|--------------|
| `~/.config/mise/config.toml` | `~/.dotfiles/mise/.config/mise/config.toml` | `stow mise` |
| `~/.config/nvim` | `~/.dotfiles/nvim-lazy/.config/nvim` | `stow nvim-lazy` |
| `~/.config/opencode/opencode.json` | `~/.dotfiles/opencode/.config/opencode/opencode.json` | `stow opencode` |

## Tmux Configuration

| Symlink | Target | Stow Command |
|---------|--------|--------------|
| `~/.tmux-cht-command` | `~/.dotfiles/tmux/.tmux-cht-command` | `stow tmux` |
| `~/.tmux-cht-languages` | `~/.dotfiles/tmux/.tmux-cht-languages` | `stow tmux` |
| `~/.tmux.conf` | `~/.dotfiles/tmux/.tmux.conf` | `stow tmux` |

---

*Last updated: 2026-02-10*
