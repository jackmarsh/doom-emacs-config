# Doom Emacs Configuration

My personal Doom Emacs configuration with optimized settings for development in multiple languages.

## Repository

This configuration is hosted at: https://github.com/jackmarsh/doom-emacs-config

## Fresh Installation Instructions

Follow these steps to set up Doom Emacs with this configuration on a fresh system (tested on Ubuntu 24.04):

### Prerequisites

#### 1. Install Emacs and Dependencies

```bash
sudo apt update
sudo apt install -y emacs-gtk git ripgrep fd-find
```

If you encounter package download errors, use:
```bash
sudo apt install --fix-missing emacs-gtk git ripgrep fd-find
```

For a newer version of Emacs, you can alternatively install via snap:
```bash
sudo snap install emacs --classic
```

#### 2. Clone This Configuration

If setting up from scratch:
```bash
git clone git@github.com:jackmarsh/doom-emacs-config.git ~/.config/doom
```

Or if you've already cloned it elsewhere:
```bash
ln -s /path/to/your/doom-emacs-config ~/.config/doom
```

#### 3. Install Doom Emacs

Clone the Doom Emacs framework:
```bash
git clone --depth 1 https://github.com/doomemacs/doomemacs ~/.config/emacs
```

Run the Doom installer (it will use the configuration from ~/.config/doom automatically):
```bash
yes | ~/.config/emacs/bin/doom install
```

#### 4. Sync Packages

After installation, sync all packages defined in packages.el:
```bash
~/.config/emacs/bin/doom sync
```

#### 5. Add Doom to PATH

Add this line to your `~/.bashrc` (or `~/.zshrc` if using zsh):
```bash
export PATH="$HOME/.config/emacs/bin:$PATH"
```

Then reload your shell configuration:
```bash
source ~/.bashrc  # or source ~/.zshrc
```

Now you can use `doom` commands directly without the full path.

#### 6. Launch Emacs

```bash
emacs
```

## Essential Doom Commands

### Daily Usage
- `doom sync` - Sync packages after modifying init.el or packages.el
- `doom upgrade` - Update Doom Emacs framework and all packages
- `doom doctor` - Diagnose common issues with your environment
- `doom env` - Regenerate environment variables file

### Maintenance
- `doom clean` - Remove orphaned packages and repos
- `doom build` - Rebuild all packages from scratch
- `doom purge` - Remove all packages and reinstall from scratch

## Configuration Overview

### Enabled Modules

This configuration includes the following key modules:

**Completion:**
- Vertico (modern completion interface)

**UI Enhancements:**
- doom (the signature Doom look)
- doom-dashboard (startup screen)
- modeline (Atom-inspired modeline)
- hl-todo (highlight TODO/FIXME comments)
- vc-gutter (git diff indicators)
- workspaces (tab emulation)

**Editor Features:**
- file-templates (auto-snippets for new files)
- fold (code folding)
- snippets (yasnippet integration)
- multiple undo modes

**Programming Languages:**
- C/C++ (`cc`)
- Go (`go`)
- Python (`python`)
- Rust (`rust`)
- JavaScript/TypeScript (`javascript`)
- Emacs Lisp (`emacs-lisp`)
- LaTeX (`latex`)
- Markdown (`markdown`)
- JSON (`json`)
- YAML (`yaml`)
- Solidity (`solidity`)
- Shell scripting (`sh`)

**Org Mode:**
- Enhanced org-mode with Hugo export support
- org-roam for note-taking

**Tools:**
- Magit (Git integration)
- Syntax checking
- Code evaluation with overlays
- Lookup/documentation features

### Custom Packages

Additional packages installed via packages.el:
- `emacsql-sqlite3` - SQLite backend for org-roam
- `org-roam-ui` - Web UI for org-roam
- `protobuf-mode` - Protocol buffer file support
- `typescript-mode` - TypeScript language support
- `web-mode` - Web development mode

### Configuration Files

- `init.el` - Doom modules declaration and configuration
- `config.el` - Personal settings and customizations
- `packages.el` - Additional package installations

## Troubleshooting

### Common Issues

#### emacsql-sqlite3 Repository
If you encounter errors about `org-roam/emacsql-sqlite3`:
- The repository has moved from `org-roam/emacsql-sqlite3` to `cireu/emacsql-sqlite3`
- This configuration already includes the fix in packages.el

#### PATH Issues
If `doom` command is not found:
- Ensure you've added `~/.config/emacs/bin` to your PATH
- Try using the full path: `~/.config/emacs/bin/doom`
- Restart your terminal or run `source ~/.bashrc`

#### Package Installation Failures
If packages fail to install:
1. Run `doom doctor` to check for missing dependencies
2. Try `doom purge` followed by `doom sync`
3. Check network connectivity to GitHub

#### Performance Issues
For better performance:
1. Run `doom build` to native-compile packages
2. Consider enabling native compilation in Emacs 28+
3. Use `doom gc` to run garbage collection

## Keybindings

Core keybindings (using default Doom conventions):
- `SPC` - Leader key (main command prefix)
- `SPC f f` - Find file
- `SPC p p` - Switch project
- `SPC g g` - Open Magit status
- `SPC h d h` - Access Doom documentation
- `C-h d h` - Alternative way to access Doom docs

## Updating

To keep everything up to date:
1. Pull latest config changes: `cd ~/.config/doom && git pull`
2. Update Doom: `doom upgrade`
3. Sync packages: `doom sync`
4. Restart Emacs

## Contributing

Feel free to fork this configuration and customize it for your needs. Submit issues or pull requests at:
https://github.com/jackmarsh/doom-emacs-config
