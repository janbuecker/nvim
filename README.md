# Neovim Configuration

A minimal, fast Neovim configuration built for Neovim ≥0.12 using `vim.pack` for plugin management.

## Overview

This config uses Neovim's built-in package manager (`vim.pack`) instead of an external plugin manager, and the
native `lsp/` config layout (`vim.lsp.enable` / `vim.lsp.config`), native treesitter (`main` branch), and native
diagnostics. It provides a complete development environment with LSP, fuzzy finding, testing/debugging,
formatting and linting.

## Repository Structure

```
~/.config/nvim/
├── init.lua             # Options, plugin list (vim.pack), colorscheme, lualine, copilot, flash, keymaps
├── plugin/              # Auto-loaded plugin configurations
│   ├── +treesitter.lua  # Treesitter parsers + highlighting (main branch API)
│   ├── autocmds.lua     # Autocommands, format-on-save toggle commands
│   ├── cmp.lua          # Completion (nvim-cmp) setup
│   ├── dap.lua          # Debugging (DAP) setup
│   ├── formatting.lua   # Code formatting (conform.nvim)
│   ├── keymaps.lua      # Global keybindings + pack_clean helper
│   ├── linting.lua      # Linting (nvim-lint, debounced)
│   ├── lsp.lua          # LSP enable list, diagnostics, LspAttach keymaps, terragrunt-ls
│   ├── mini.lua         # mini.nvim modules setup
│   ├── snacks.lua       # snacks.nvim picker + utilities
│   └── test.lua         # Testing (vim-test + vim-dispatch)
├── lsp/                 # Per-server LSP configs (others come from nvim-lspconfig)
│   ├── gopls.lua
│   ├── intelephense.lua # PHP (enabled)
│   ├── jsonls.lua
│   ├── lua_ls.lua
│   ├── phptools.lua     # devsense-php-ls (reference, not enabled)
│   ├── shopware_lsp.lua # (reference, not enabled)
│   └── yamlls.lua
└── nvim-pack-lock.json  # vim.pack lock file
```

## Packages

### Core & UI

| Package | Description |
|---------|-------------|
| **catppuccin** | Color scheme (`catppuccin-mocha`) with snacks integration |
| **lualine.nvim** | Statusline |

### Picking, Navigation & Files

| Package | Description |
|---------|-------------|
| **snacks.nvim** | Picker (files, grep, LSP symbols, diagnostics), lazygit, notifier, input, rename, words |
| **mini.files** | File explorer with split/grep/find/diff integration |
| **neotrees.nvim** | Git worktree picker (`<leader>gw`) |
| **flash.nvim** | Motion plugin (`s` jump, `S` treesitter) |

### Editing & Code Manipulation

| Package | Description |
|---------|-------------|
| **mini.nvim** | comment, move, trailspace, bufremove, splitjoin, indentscope, diff, git, tabline, icons, ai (textobjects), clue (keymap hints), extra, misc (auto-root) |
| **vim-abolish** | Case-aware substitution and abbreviations |
| **nvim-rip-substitute** | Interactive find & replace with live preview |
| **quicker.nvim** | Enhanced quickfix/location list |
| **undotree** | Visual undo history browser |
| **ts-comments.nvim** | Treesitter-aware comment strings |
| **visual-whitespace.nvim** | Show whitespace in visual selections |

### LSP & Completion

| Package | Description |
|---------|-------------|
| **nvim-lspconfig** | Bundled `lsp/` configs for servers not configured locally |
| **nvim-cmp** | Completion engine |
| **cmp-nvim-lsp** | LSP completion source |
| **cmp-cmdline** | Command-line completion source |
| **cmp-path** | Path completion source (`path`) |
| **schemastore.nvim** | JSON/YAML schemas |
| **terragrunt-ls** | Terragrunt language server wrapper (LSP started natively via `vim.lsp.start`) |
| **copilot.lua** | GitHub Copilot (auto-trigger, `<C-y>` accept) |

### Formatting & Linting

| Package | Description |
|---------|-------------|
| **conform.nvim** | Formatter with format-on-save |
| **nvim-lint** | Async linter runner (debounced) |
| **vim-varnish** | Varnish VCL syntax |

### Debugging

| Package | Description |
|---------|-------------|
| **nvim-dap** | Debug Adapter Protocol client |
| **nvim-dap-ui** | DAP UI |
| **nvim-dap-virtual-text** | Inline variable values |
| **nvim-dap-go** | Go DAP adapter |
| **nvim-nio**, **plenary.nvim** | Async / utility libraries |

### Testing

| Package | Description |
|---------|-------------|
| **vim-test** | Run tests (`TestNearest`/`TestFile`/`TestSuite`/`TestLast`/`TestVisit`) |
| **vim-dispatch** | Async test strategy backend |

### Syntax & Parsing

| Package | Description |
|---------|-------------|
| **nvim-treesitter** (`main`) | Parsers + highlighting |
| **nvim-treesitter-textobjects** | Treesitter-aware textobjects (via mini.ai) |

### Tooling

| Package | Description |
|---------|-------------|
| **vim-startuptime** | Startup profiling (`:StartupTime`) |

### LSP Servers (`vim.lsp.enable`)

| Server | Language | Config source |
|--------|----------|---------------|
| `gopls` | Go | `lsp/gopls.lua` |
| `golangci_lint_ls` | Go | lspconfig |
| `dockerls` | Docker | lspconfig |
| `buf_ls` | Protocol Buffers | lspconfig |
| `lua_ls` | Lua | `lsp/lua_ls.lua` |
| `yamlls` | YAML | `lsp/yamlls.lua` |
| `jsonls` | JSON | `lsp/jsonls.lua` |
| `html` | HTML | lspconfig |
| `templ` | Templ | lspconfig |
| `terraformls` | Terraform | lspconfig |
| `intelephense` | PHP | `lsp/intelephense.lua` |
| `terragrunt-ls` | Terragrunt (HCL) | started in `plugin/lsp.lua` on `FileType hcl` |

`lsp/phptools.lua` (devsense) and `lsp/shopware_lsp.lua` are present as reference but not enabled.

## Keybindings

Leader key: **Space**.

### Picker / Search (snacks.nvim)

| Keybind | Action |
|---------|--------|
| `<leader>f` | Find files (incl. hidden) |
| `<leader>/`, `<leader>sg` | Grep project |
| `<leader>:`, `<leader>sc` | Command history |
| `<leader>sC` | Commands |
| `<leader><space>` | Switch buffers (exclude current) |
| `<leader>qc` | Find config file |
| `<leader>qp` | Project picker |
| `<leader>sd` | Buffer diagnostics |
| `<leader>sh` | Help pages |
| `<leader>sk` | Keymaps |
| `<leader>sl`, `<leader>sR` | Resume last picker |
| `<leader>s/` | Search lines in buffer |

### Git

| Keybind | Action |
|---------|--------|
| `<leader>gg` | Lazygit |
| `<leader>gl` | Lazygit log (cwd) |
| `<leader>gf` | Lazygit current file history |
| `<leader>gc` | Git log picker |
| `<leader>gO` | Toggle mini.diff overlay |
| `<leader>gw` | Worktree picker (neotrees) |

### LSP

| Keybind | Action |
|---------|--------|
| `gd` | Goto definition |
| `grr` | Goto references |
| `gri` | Goto implementation |
| `gO` | Document symbols |
| `gD` | Goto declaration |
| `gl` | Diagnostic float |
| `<leader>ws` | Workspace symbols |
| `<leader>wd` | Workspace diagnostics |
| `:Format` | Format buffer with LSP |

### Motion & Editing

| Keybind | Action |
|---------|--------|
| `s` / `S` | Flash jump / treesitter jump |
| `<leader>sr`, `<A-r>`, `<C-r>` (visual) | Rip substitute |
| `;` | Alias for `:` |
| `<C-c>` (insert) | Exit insert mode |
| `k` / `j` | Smart wrapped-line navigation |
| `n` / `N`, `<C-d>` / `<C-u>` | Center on scroll/search |
| `<` / `>` (visual) | Indent keeping selection |
| `<leader>p` (visual) | Paste without overwriting register |

### Files & Buffers

| Keybind | Action |
|---------|--------|
| `<leader>e` | Toggle mini.files explorer |
| `<leader>bd` | Delete buffer |
| `<leader>u` | Toggle undotree |
| `<C-q>` | Toggle quickfix (quicker.nvim) |
| `q` (qf/help/man/…) | Close window |

Inside mini.files: `gs`/`gv` split, `gg` grep dir, `f` find in dir, `gf` find in project, `dv` diff with buffer,
`l`/`h` go in/out.

### Debugging (DAP)

`<leader>d` prefix — `db` toggle breakpoint, `dB` conditional, `dc` continue, `dC` run-to-cursor, `di`/`do`/`dO`
step into/out/over, `dj`/`dk` stack down/up, `dl` run last, `dP` pause, `dr` REPL, `ds` session, `dt` terminate,
`dw` hover, `du` toggle UI, `de` eval (normal/visual).

### Testing

`<leader>tt` nearest, `<leader>tl` last, `<leader>tf` file, `<leader>ta` suite, `gt` visit last test.
Strategy: `dispatch`; Go runs with `-v`.

### Plugin Management

| Keybind | Action |
|---------|--------|
| `<leader>ps` | `vim.pack.update()` |
| `<leader>pc` | Remove unused plugins (prompts) |

### mini.clue triggers

`<Space>` (leader), `g`, `<C-w>`, `[` / `]`, and `<C-x>` (insert completion).

## Autocommands

- **LspAttach**: LSP keymaps + buffer-local `:Format`; strips terraformls semantic tokens.
- **LspProgress**: spinner notifications during indexing.
- **TextYankPost**: highlight on yank.
- **BufReadPost**: restore last cursor position.
- **BufEnter**: disable auto-commenting continuation.
- **FocusGained/TermClose/TermLeave**: `checktime` for external changes.
- **FileType** (qf/help/man/…): close with `q`; **qf**: detach LSP clients (avoids a copilot/quickfix crash).
- **BufWritePre** (`*.go`): gopls `organizeImports`, then `conform.format` (golangci-lint) — single pass.
- **PackChanged**: run `TSUpdate` when treesitter updates.
- **FileType** (treesitter langs): enable highlighting + treesitter indent.
- `:FormatDisable` / `:FormatDisable!` / `:FormatEnable`: toggle format-on-save (global / buffer).

## Formatting (conform.nvim)

| Language | Formatter |
|----------|-----------|
| Go | `golangci-lint` (after gopls organizeImports) |
| Terraform / HCL | `terraform_fmt`, `terragrunt_hclfmt` |
| JSON | `jq` |
| Lua | `stylua` |
| PHP | `php_cs_fixer` |
| Protocol Buffers | `buf` |
| SQL | `sqlfmt` |
| Bash/Shell | `shfmt` (2-space) |
| Twig | `ludtwig` |
| Templ | `templ` |

Format-on-save is enabled (disable with `:FormatDisable` / `:FormatDisable!`).

## Linting (nvim-lint)

Debounced on `BufWritePost`, `BufReadPost`, `InsertLeave`.

| Language | Linters |
|----------|---------|
| Docker | `hadolint` |
| Go | `golangcilint` |
| JSON | `jsonlint` |
| PHP | `php`, `phpstan` |
| Protocol Buffers | `buf_lint` |
| Bash/Shell | `shellcheck` |
| Twig | `twig-cs-fixer` |

## Completion (nvim-cmp)

- Sources: `nvim_lsp` (excludes plain `Text` items) + `path`; `:` cmdline uses `path` + `cmdline`.
- `<C-Space>` complete, `<CR>` confirm (selects first item if none selected). `<C-y>` is left to Copilot.
- Bordered windows; `completeopt` includes `fuzzy,nosort`.

## Notes

- Native LSP client, no external plugin manager.
- `:PackUpdate` / `<leader>ps` to update; `<leader>pc` to prune unused plugins.
- `:StartupTime` to profile startup.
