# Doom Emacs Configuration

My personal Doom Emacs configuration.

## Fresh Installation Instructions

Follow these steps to set up Doom Emacs with this configuration on a fresh system (tested on Ubuntu 24.04):

### 1. Install Emacs

```bash
sudo apt update
sudo apt install -y emacs-gtk git ripgrep fd-find
```

If you encounter package download errors, use:
```bash
sudo apt install --fix-missing emacs-gtk git ripgrep fd-find
```

Alternatively, install via snap for a newer version:
```bash
sudo snap install emacs --classic
```

### 2. Clone This Configuration

```bash
cd ~
git clone <your-repo-url> doom-emacs-config
```

### 3. Install Doom Emacs

Clone the Doom Emacs framework:
```bash
git clone --depth 1 https://github.com/doomemacs/doomemacs ~/.config/emacs
```

Symlink this config to the Doom config location:
```bash
ln -s ~/doom-emacs-config ~/.config/doom
```

Run the Doom installer:
```bash
yes | ~/.config/emacs/bin/doom install
```

### 4. Sync Packages

```bash
~/.config/emacs/bin/doom sync
```

### 5. Add Doom to PATH (Optional)

Add this to your `~/.bashrc` or `~/.zshrc`:
```bash
export PATH="$HOME/.config/emacs/bin:$PATH"
```

Then reload your shell:
```bash
source ~/.bashrc  # or source ~/.zshrc
```

Now you can use `doom` commands directly (e.g., `doom sync`, `doom upgrade`).

### 6. Launch Emacs

```bash
emacs
```

## Common Commands

- `doom sync` - Install/update packages after changing init.el or packages.el
- `doom upgrade` - Update Doom Emacs and all packages
- `doom doctor` - Diagnose common issues
- `doom env` - Regenerate environment variables file

## Troubleshooting

### emacsql-sqlite3 Repository Issue

If you encounter errors about `org-roam/emacsql-sqlite3` not being found, the repository has moved. This config has been updated to use `cireu/emacsql-sqlite3` instead.

## Configuration Structure

- `init.el` - Doom modules configuration
- `config.el` - Personal configuration and customizations
- `packages.el` - Additional packages and package sources
