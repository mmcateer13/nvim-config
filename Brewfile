# Covers system-level dependencies required for the editor config and its
# language support to work. Does NOT include LSP servers, DAP adapters, or
# other tooling managed by Mason (see :Mason inside Neovim).
#
# Install everything here with: brew bundle

# Editor
brew "neovim"

# Required for .envrc support
brew "direnv"

# Telescope dependencies (live grep and file finding)
brew "ripgrep"
brew "fd"

# Git tooling
brew "git"
brew "gh"

# Lua formatting (used by the pre-commit hook)
brew "stylua"

# Language runtimes/CLIs
# Note: Rust is managed via rustup, not Homebrew. See docs/SETUP.md.
# Note: Node.js is managed via nvm, not Homebrew. See docs/SETUP.md.
brew "dotnet"     # C#
brew "elixir"     # Elixir (elixir-ls requires the runtime to be present)
brew "terraform"  # Terraform (terraform-ls wraps the CLI)
