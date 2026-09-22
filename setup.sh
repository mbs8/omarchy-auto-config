#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)"

PACMAN_LIST="$SCRIPT_DIR/packages/pacman_list.txt"
AUR_LIST="$SCRIPT_DIR/packages/aur_list.txt"
ZSHRC_SRC="$SCRIPT_DIR/zsh/.zshrc"
HYPR_SRC="$SCRIPT_DIR/.config/hypr"
BRANDING_SRC="$SCRIPT_DIR/.config/omarchy/branding"

echo "==> Instalando pacotes pacman"
xargs omarchy pkg add < "$PACMAN_LIST"

echo "==> Instalando pacotes AUR"
xargs omarchy pkg aur add < "$AUR_LIST"

echo "==> Copiando .zshrc para $HOME/"
cp "$ZSHRC_SRC" "$HOME/"

echo "==> Copiando configs do Hyprland para ~/.config/hypr/"
mkdir -p "$HOME/.config/hypr"
cp -r "$HYPR_SRC"/. "$HOME/.config/hypr/"

echo "==> Copiando branding do Omarchy para ~/.config/omarchy/branding/"
mkdir -p "$HOME/.config/omarchy/branding"
cp -r "$BRANDING_SRC"/. "$HOME/.config/omarchy/branding/"

echo "==> Alterando shell padrão para zsh"
chsh -s "$(which zsh)"

echo "==> Configuração concluída."

read -r -p "Reiniciar a máquina agora? [Y/n] " REBOOT_ANSWER
REBOOT_ANSWER=${REBOOT_ANSWER:-Y}
if [[ "$REBOOT_ANSWER" =~ ^[Yy]$ ]]; then
  reboot
else
  echo "Reinício cancelado. Lembre-se de reiniciar manualmente depois."
fi
