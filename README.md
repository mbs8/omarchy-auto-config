# Omarchy Auto Config

Script de setup automático para uma instalação nova do [Omarchy](https://omarchy.org), com configs pessoais de shell, Hyprland e branding.

## O que o `setup.sh` faz

1. Instala os pacotes listados em `packages/pacman_list.txt` via `omarchy pkg add`.
2. Instala os pacotes AUR listados em `packages/aur_list.txt` via `omarchy pkg aur add`.
3. Copia `zsh/.zshrc` para `$HOME/.zshrc`.
4. Copia as configs do Hyprland (`.config/hypr/`) para `~/.config/hypr/`.
5. Copia o branding do Omarchy (`.config/omarchy/branding/`) para `~/.config/omarchy/branding/`.
6. Altera o shell padrão do usuário para zsh.
7. Pergunta se deseja reiniciar a máquina ao final.

## Estrutura

```
.
├── setup.sh                       # script principal de instalação
├── packages/
│   ├── pacman_list.txt            # pacotes oficiais a instalar
│   └── aur_list.txt                # pacotes AUR a instalar
├── zsh/
│   └── .zshrc                     # config do zsh
└── .config/
    ├── hypr/                      # configs do Hyprland (input, look & feel, etc.)
    └── omarchy/branding/          # branding customizado do Omarchy
```

## Uso

```bash
git clone git@github.com:mbs8/omarchy-auto-config.git
cd omarchy-auto-config
./setup.sh
```

> O script assume uma instalação do Omarchy já configurada e faz alterações no sistema (instalação de pacotes, cópia de arquivos de configuração e troca do shell padrão). Revise o conteúdo antes de executar.
