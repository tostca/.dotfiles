# User-Installed Packages

This document lists packages explicitly installed by the user on top of the base Omarchy
installation. Anything in Omarchy's
[`install/omarchy-base.packages`](https://github.com/basecamp/omarchy/blob/main/install/omarchy-base.packages)
or
[`install/omarchy-other.packages`](https://github.com/basecamp/omarchy/blob/main/install/omarchy-other.packages)
is intentionally excluded.

## Pacman (Official Repositories)

### System / Hardware
```
amd-ucode
efibootmgr
inotify-tools
squashfs-tools
usbutils
wget
```

### Dev tooling
```
aws-cli-v2
azure-cli
boost
cloc
github-copilot-cli
hurl
libappindicator
libvips
openai-codex
terraform
tokei
yq
```

### Shell / TUI
```
direnv
git-delta
jnv
stow
television
xan
```

### Desktop / Theming
```
elephant
elephant-bluetooth
elephant-calc
elephant-clipboard
elephant-desktopapplications
elephant-files
elephant-menus
elephant-providerlist
elephant-runner
elephant-symbols
elephant-todo
elephant-unicode
elephant-websearch
hyprshot
noto-fonts-extra
ttf-cascadia-mono-nerd
walker
wl-clip-persist
```

### Apps
```
discord
filezilla
gopass
jemalloc          # pulled in by elephant; keep explicit
minecraft-launcher
neovim
ollama
remmina
solaar
```

### Other
```
microsoft-edge-stable-bin   # see AUR section — this is actually AUR; remove if regenerated
```

## Yay (AUR Packages)

```
brave-bin
crush-bin
doggo-bin
google-chrome
hpuld
lazysql
lazyssh-bin
lmstudio-bin
microsoft-edge-stable-bin
opencode
postman-bin
powershell-bin
remmina-plugin-rdesktop
soapui
typtea
worktrunk-bin
```

> ⚠ `microsoft-edge-stable-bin` is an AUR package — it is listed under **Yay** above. The
> stray entry under the Pacman block is a documentation artifact and should be removed when
> this file is regenerated (see the regeneration snippet at the bottom).

---

*Originally generated on: 2026-02-10*  
*Last updated: 2026-06-05*

## Notes

- These packages were installed via `post-install.sh` (see
  `~/.dotfiles/post-install-omarchy.sh`) or manually added on top of Omarchy.
- The set above is the diff between `pacman -Qe` on this machine and the union of Omarchy's
  two `.packages` files in `basecamp/omarchy/install/`.
- Packages pulled in by Omarchy's own `omarchy-install-*` helper scripts (e.g. `alacritty`,
  `firefox`, `flatpak`, `fprintd`, `ghostty`, `steam`, `tailscale`, `omarchy-keyring`) are
  intentionally excluded even though they show up as explicit in `pacman -Qe`.

### Verifying against Omarchy upstream

```bash
# Pull Omarchy's package lists directly from GitHub
curl -sL https://raw.githubusercontent.com/basecamp/omarchy/main/install/omarchy-base.packages \
  | sort -u > /tmp/omarchy-base.packages
curl -sL https://raw.githubusercontent.com/basecamp/omarchy/main/install/omarchy-other.packages \
  | sort -u > /tmp/omarchy-other.packages
sort -u /tmp/omarchy-base.packages /tmp/omarchy-other.packages > /tmp/omarchy-all.packages

# Packages installed on this machine that are NOT in Omarchy
comm -23 <(pacman -Qqe | sort) /tmp/omarchy-all.packages
```

### Regenerating this file

```bash
# Cloned Omarchy repo path
OMARCHY_REPO=~/code/omarchy

sort -u "$OMARCHY_REPO/install/omarchy-base.packages" \
        "$OMARCHY_REPO/install/omarchy-other.packages" \
  | grep -vE '^\s*(#|$)' \
  | sort -u > /tmp/omarchy-all.packages

# Pacman (official) user extras
comm -23 <(pacman -Qqe | sort) /tmp/omarchy-all.packages | grep -v -- '-bin$' > /tmp/user-pacman.txt

# AUR user extras
comm -23 <(pacman -Qqm | sort) /tmp/omarchy-all.packages > /tmp/user-aur.txt
```
