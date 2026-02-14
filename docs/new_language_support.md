# Supporting a New Language

This guide serves as a sort of "note-to-self" for properly supporting new languages in my editor, complete with syntax highlighting, LSP support, etc.

## Treesitter

Add the parser name to the `non_core_parsers` list in `/lua/plugins/treesitter.lua`:

```lua
local non_core_parsers = {
    "bash",
    "elixir",
    "python",
    ...
}
```

The parser will be installed on next startup. Manual install: `:TSInstall <parser>`.

Note: Lua and Markdown parsers are bundled with Neovim and don't need to be installed.

## LSP

Adding LSP support requires two steps:

1. Add the LSP to Mason's `ensure_installed` in `/lua/plugins/mason.lua`:

```lua
ensure_installed = {
    "pyright",
    "terraformls",
    ...
},
```

2. Add the LSP name to the servers list in `/lua/plugins/lsp.lua`:

```lua
local servers = { "elixirls", "lua_ls", "pyright", "rust_analyzer", "terraformls" }
```

On startup, missing LSPs will be installed via Mason. Manual install: `:MasonInstall` or `:LspInstall`.

### LSP Auto-complete

LSP completion is configured in `/lua/plugins/cmp.lua` and works automatically for all enabled language servers.

### LSP Naming Differences

On Mason, some packages show two names:

```
terraform-ls terraformls
```

Use the first name for Mason commands, the second name for `mason-lspconfig` and the `servers` list in `lsp.lua`.
