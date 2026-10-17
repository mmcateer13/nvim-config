# New Machine Setup

This guide covers everything needed to get this Neovim config fully working on
a fresh macOS machine.

## System Dependencies

### Homebrew

Install Homebrew if not already present — see the [Homebrew installation instructions](https://brew.sh).

### Clone the config

Check whether `git` is installed:

```sh
git --version
```

If it is not, install it:

```sh
brew install git
```

Then clone the repo:

```sh
git clone git@github.com:mmcateer13/nvim-config.git ~/.config/nvim
```

### Install Homebrew dependencies

Install all remaining Homebrew dependencies from the root of the cloned repo:

```sh
cd ~/.config/nvim
brew bundle
```

See `Brewfile` for the full list and rationale.

### Rust

Rust is managed via `rustup` rather than Homebrew — see the [rustup installation instructions](https://rustup.rs).

### Node.js

Node is required by Mason to install certain LSP servers (e.g. `pyright`).
Install it via `nvm` — see the [nvm installation instructions](https://github.com/nvm-sh/nvm).
Once installed, run:

```sh
nvm install --lts
```

## Editor Setup

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

Restart your shell now so the direnv hook and any installed runtimes (Rust, Node) are available for the steps below.

### Set up git hooks

```sh
cd ~/.config/nvim
./hooks/setup_hooks.sh
```

### Install plugins and parsers

Install vim-plug plugins without opening Neovim:

```sh
nvim --headless +PlugInstall +qa
```

On first launch, Mason will automatically install all LSP servers and DAP
adapters, and Treesitter parsers will install when you first open a file of
each supported type. You can monitor Mason's progress with `:Mason`.

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
`.venv/bin/python` relative to your project root. Create one in each project
where you intend to use the editor — see the [venv documentation](https://docs.python.org/3/library/venv.html) for instructions.

## Per-Project Configuration

For per-project debug paths and other settings, create a `.envrc.local` in the
project directory (not the Neovim config directory) and set the relevant
variables. See `docs/environment_variables.md` for available options.
