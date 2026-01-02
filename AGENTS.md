# WARP.md

This file provides guidance to WARP (warp.dev) when working with code in this repository.

## Repository Purpose

This is a personal dot-files repository containing configuration files for shell environments (bash/zsh), vim/neovim, and git. The configurations are designed to work across multiple systems (primarily macOS and Linux).

## Repository Structure

- **Root level**: Shell configurations (bashrc, zshrc, profile) and tool-specific configs (gitconfig, vimrc, psqlrc, tigrc, cgdbrc)
- **nvim/**: Neovim configuration using lazy.nvim plugin manager
  - `nvim/init.vim`: Main Neovim configuration file (VimScript)
  - `nvim/lua/init.lua`: Lua-based configuration entry point
  - `nvim/lua/config/lazy.lua`: Lazy.nvim plugin manager bootstrap
  - `nvim/lua/plugins/`: Individual plugin configurations (codecompanion, ale, fzf)
  - `nvim/after/ftplugin/`: Language-specific settings (go.vim, typescript.vim)
  - `nvim/plugin/terminal.lua`: Terminal customizations
- **vim/**: Classic Vim configuration using pathogen
  - `vim/bundle/`: Git submodules for vim plugins
  - `vim/autoload/`: Pathogen plugin manager
  - `vim/after/`: Language-specific overrides

## Key Design Patterns

### Dual Editor Setup
The repository maintains parallel configurations for both Vim and Neovim:
- **Vim**: Uses pathogen for plugin management with git submodules
- **Neovim**: Uses lazy.nvim for plugin management with modern Lua configuration
- Shared keybindings and behavior across both editors where possible

### Editor Philosophy
- **Leader key**: Space bar (`<Space>`)
- **Standard keyboard shortcuts**: Ctrl+C (copy), Ctrl+V (paste), Ctrl+S (save), Ctrl+Q (quit)
- **Visual block mode**: Remapped to Ctrl+B (freeing Ctrl+V for paste)
- **Tab-based workflow**: Heavy use of tabs with shortcuts for navigation and management
- **Minimal mouse interaction**: Mouse disabled in Neovim (`vim.opt.mouse = ""`)

### Shell Environment
- Sources `.local.bashrc` for machine-specific configurations not tracked in git
- Uses RVM for Ruby version management
- Configures common aliases for docker, kubernetes, and flux
- Safety aliases for destructive operations (rm, cp, mv with -i flag)
- Custom prompt with git branch display (bash only)

### Git Submodules
Vim plugins are managed as git submodules in `vim/bundle/`:
- dracula (color scheme)
- ale (linter)
- fzf and fzf.vim (fuzzy finder)
- kotlin-vim, typescript-vim, vim-go (language support)

## Common Tasks

### Installing/Updating Configurations

Link configuration files to home directory:
```bash
# Link shell configs
ln -sf ~/dot-files/bashrc ~/.bashrc
ln -sf ~/dot-files/zshrc ~/.zshrc
ln -sf ~/dot-files/gitconfig ~/.gitconfig
ln -sf ~/dot-files/vimrc ~/.vimrc

# Link vim/nvim directories
ln -sf ~/dot-files/vim ~/.vim
ln -sf ~/dot-files/nvim ~/.config/nvim
```

Initialize git submodules for vim plugins:
```bash
git submodule update --init --recursive
```

### Neovim Plugin Management

Install/update lazy.nvim plugins:
```bash
nvim +Lazy
```

Lazy.nvim will automatically bootstrap itself on first run and install all plugins defined in `nvim/lua/plugins/`.

### Adding New Vim Plugins (Pathogen)

```bash
cd ~/dot-files
git submodule add <plugin-repo-url> vim/bundle/<plugin-name>
git commit -m "Add vim plugin: <plugin-name>"
```

### Adding New Neovim Plugins (Lazy)

Create a new file in `nvim/lua/plugins/` or add to existing plugin configuration file following lazy.nvim spec format.

## Important Configuration Details

### Editor Keybindings

Custom navigation and workflow shortcuts:
- `<Space>h` / `<Space>l`: Previous/next tab
- `<Space><C-h>` / `<Space><C-l>`: Move tab left/right
- `>` / `<`: Open new tab and optionally move it
- `<Space>,` / `<Space>.`: Toggle tab size between 2 and 4 spaces
- `<C-d>`: Drop to bash shell
- `<Space>s`: Force save with sudo
- `<C-h/j/k/l>`: Navigate between split panes
- `<Space><Space>p`: FZF file search
- `<Space><Space>b`: Tig blame at current line
- `<Space><Space>n`: ALE next error

### CodeCompanion (Neovim AI Assistant)

Configured with Anthropic Claude as default adapter:
- `<Space>a`: Toggle CodeCompanion chat
- `<Space>i`: Show CodeCompanion actions
- `ga` (visual mode): Add selection to chat
- `<M-h>`: Quick inline prompt with buffer context
- Enter key submits messages in chat window
- Shift+Enter for new line in chat

### ALE Linter Configuration

Configured linters:
- **Go**: gobuild, golangci-lint
- **Lua**: lua_language_server

Navigate errors with `<Space><Space>n`

### Shell Aliases

Important aliases defined in bashrc:
- `neo` → `nvim`
- `k` → `kubectl` (with bash completion)
- `dc` → `docker-compose`
- `f` / `of` → `flux` / `flux -n ops`
- Standard safety aliases: `rm -i`, `cp -i`, `mv -i`

## Machine-Specific Configuration

Create `~/.local.bashrc` for configurations that should not be committed to the repository (API keys, work-specific paths, machine-specific environment variables). This file is sourced by bashrc but not tracked by git.

## Editor Behavior

### Automatic Actions
- **Trailing whitespace**: Automatically removed on save
- **Tab settings**: Default 2 spaces (toggle to 4 with `<Space>.`)
- **Search highlighting**: Disabled by default (use `:set hlsearch` to enable temporarily)

### Visual Indicators
- Tabs shown as `ˑ `
- Trailing spaces shown as `«`
- End of line shown as space character

### Git Integration
- Editor set to vim in gitconfig
- Custom git aliases: `cleanup`, `edit-unmerged`, `add-unmerged`, `permission-reset`
- Default branch: master
- ISO date format for git log
