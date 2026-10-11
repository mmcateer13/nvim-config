# New Machine Setup

This guide covers everything needed to get this Neovim config fully working on
a fresh macOS machine.

## System Dependencies

### Homebrew

Install Homebrew if not already present:

```sh
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

Then install all Homebrew dependencies from the root of this repo:

```sh
brew bundle
```

See `Brewfile` for the full list and rationale.

### Rust

Rust is managed via `rustup` rather than Homebrew:

```sh
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
```

Follow the prompts and restart your shell afterwards.

### Node.js

Node is required by Mason to install certain LSP servers (e.g. `pyright`).
Install it via `nvm`:

```sh
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/HEAD/install.sh | bash
nvm install --lts
```

## Editor Setup

### Clone the config

```sh
git clone https://github.com/mmcateer13/nvim-config.git ~/.config/nvim
```

### Set up git hooks

```sh
cd ~/.config/nvim
./hooks/setup_hooks.sh
```

### Set up direnv

Add the following to your shell rc file (`~/.zshrc` or `~/.bashrc`):

```sh
eval "$(direnv hook zsh)"   # or bash
```

Then copy the example env file and fill in any values you want set:

```sh
cp ~/.config/nvim/.envrc.example ~/.config/nvim/.envrc.local
```

See `docs/environment_variables.md` for a full description of each variable.

### Install plugins and parsers

Install vim-plug plugins, Treesitter parsers, and trigger Mason's LSP
auto-install — all without opening Neovim:

```sh
nvim --headless +PlugInstall +qa
nvim --headless +"lua require('nvim-treesitter').install(require('plugins.treesitter').non_core_parsers)" +qa
```

Mason will auto-install LSP servers on first launch. To monitor progress,
open Neovim and run `:Mason`.

## Language-Specific Notes

### C# (.NET)

Ensure the .NET version targeted by your project matches an installed SDK.
Check with:

```sh
dotnet --list-sdks
```

If they don't match, update `<TargetFramework>` in your `.csproj` accordingly.

#### netcoredbg (C# debugger) — manual upgrade

Mason installs `netcoredbg` automatically, but its registry may lag behind the
latest release. If you encounter issues debugging .NET projects (e.g.
breakpoints being rejected), check the installed version with `:Mason`.

If it is below 3.2.0, manually upgrade it:

```sh
# macOS ARM
curl -sL https://github.com/Samsung/netcoredbg/releases/latest/download/netcoredbg-osx-arm64.zip -o /tmp/netcoredbg.zip
unzip -o /tmp/netcoredbg.zip -d /tmp/netcoredbg_new
cp -r /tmp/netcoredbg_new/netcoredbg/* ~/.local/share/nvim/mason/packages/netcoredbg/
chmod +x ~/.local/share/nvim/mason/packages/netcoredbg/netcoredbg
```

This issue exists because netcoredbg 3.1.x does not support .NET 10+. Once
Mason's registry catches up, `:MasonUpdate` will handle this automatically.

### Python

The Python DAP integration (`nvim-dap-python`) expects a virtualenv at
`.venv/bin/python` relative to your project root. Create one with:

```sh
python3 -m venv .venv
```

## Per-Project Configuration

For per-project debug paths and other settings, create a `.envrc.local` in the
project directory (not the Neovim config directory) and set the relevant
variables. See `docs/environment_variables.md` for available options.
