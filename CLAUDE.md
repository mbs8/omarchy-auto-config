# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What this repo is

A personal dotfiles/setup repo for a fresh [Omarchy](https://omarchy.org) (Hyprland-based Arch Linux) install. It is not a software project with a build/test/lint pipeline — it's a shell script plus a set of config files that the script copies into `$HOME` on a target machine.

## Running the setup

```bash
./setup.sh
```

There is no build, lint, or test tooling in this repo. When editing `setup.sh`, validate it with `bash -n setup.sh` (syntax check) and `shellcheck setup.sh` if available, since there's no test suite to catch mistakes.

## Architecture

`setup.sh` is the single entry point. It resolves its own directory (`SCRIPT_DIR`) so it can be run from anywhere, then performs these steps in order, each depending on files elsewhere in the repo:

1. Installs official packages from `packages/pacman_list.txt` via `omarchy pkg add` (requires the `omarchy` CLI to be present — this script only runs on an Omarchy system).
2. Installs AUR packages from `packages/aur_list.txt` via `omarchy pkg aur add`.
3. Copies `zsh/.zshrc` to `$HOME/.zshrc` (Oh My Zsh + Powerlevel10k config).
4. Copies `.config/hypr/` to `~/.config/hypr/` — these are personal overrides loaded *after* Omarchy's own defaults (see the `require(...)` calls in `.config/hypr/hyprland.lua`), so they extend rather than replace the base Hyprland config.
5. Copies `.config/omarchy/branding/` to `~/.config/omarchy/branding/`.
6. Changes the user's login shell to zsh via `chsh`.
7. Prompts to reboot.

Because the script mutates the running system (`omarchy pkg add`, `chsh`, `reboot`), it assumes an already-configured Omarchy install as its target and is meant to be run interactively, not in CI.

When adding a new package, config file, or dotfile to this setup, it needs two changes: the file itself added under the matching directory (`packages/`, `zsh/`, `.config/...`), and a corresponding copy/install step added to `setup.sh` if it's a new category not already handled by an existing step.
