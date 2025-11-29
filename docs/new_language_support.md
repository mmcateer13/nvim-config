# Supporting a New Language

This guide serves as a sort of "note-to-self" for properly supporting new languages in my editor, complete with syntax highlighting, LSP support, etc.

## Treesitter

Thanks to the `ensure_installed` option that comes with `nvim-treesitter`, all that is needed is to include the name of the parser for your new language inside the call to `setup` in `/lua/plugins/treesitter.lua`:

```lua
ensure_installed = {
    "bash",
    "lua",
    "markdown",
    ...
},
```

The parser will then be installed the next time Neovim is started up. This keeps required parsers synced across different environments. It is also possible to manually install the parser by using `:TSInstall <parser>`.

## LSP

Much like Treesitter, all that is needed for supporting an LSP is to once again include the name of the LSP inside of `ensure_installed`, this time inside `/lua/plugins/mason.lua`:

```lua
ensure_installed = {
    "pyright",
    "terraformls",
    ...
},
```

The behaviour is the exact same — on startup, any missing LSPs will be installed. There are also manual install commands: either `:MasonInstall` or `:LspInstall`.

### LSP Auto-complete

Since `mason-lspconfig` automatically enables LSPs and LSP completion is already configured inside of `/lua/plugins/cmp.lua`, nothing should need done to begin using auto-completion when a new LSP is installed.

### LSP Naming Differences

On Mason, some packages will have two names side-by-side, e.g:

```
terraform-ls terraformls
```

When installing/uninstalling LSPs via Mason, use the first name. When installing/uninstalling via `mason-lspconfig`, however, use the second name. The second name is also the one used when specifying LSPs inside `ensure_installed`.
