# Neovim Configuration

A minimal, fast neovim configuration built for Neovim ≥0.12 (currently nightly) using `vim.pack` for plugin management.

## Overview

This config uses Neovim's built-in package manager (`vim.pack`) instead of external plugin managers. It provides a complete development environment with LSP support, fuzzy finding, terminal integration, testing/debugging, and formatting capabilities.

## Repository Structure

```
~/.config/nvim/
├── init.lua             # Main configuration: options, colorscheme, lualine, copilot, keymaps
├── plugin/              # Plugin configurations
│   ├── +treesitter.lua  # TreeSitter configuration and parsers
│   ├── autocmds.lua     # Autocommands and hooks
│   ├── cmp.lua          # Completion (nvim-cmp) setup
│   ├── dap.lua          # Debugging (DAP) setup
│   ├── formatting.lua   # Code formatting (conform.nvim)
│   ├── keymaps.lua      # Global keybindings
│   ├── linting.lua      # Linting configuration
│   ├── lsp.lua          # LSP configuration
│   ├── mini.lua         # Mini.nvim modules setup
│   ├── neotest.lua      # Testing framework (currently disabled)
│   └── snacks.lua       # Snacks.nvim picker and utilities
├── lsp/                 # LSP server configurations
│   ├── gopls.lua
│   ├── intelephense.lua (PHP)
│   ├── jsonls.lua
│   ├── lua_ls.lua
│   ├── phptools.lua
│   ├── shopware_lsp.lua
│   ├── terraformls.lua
│   └── yamlls.lua
└── nvim-pack-lock.json  # Package lock file
```

## Packages

### Core & Utilities

| Package | Description |
|---------|-------------|
| **catppuccin** | Beautiful pastel color scheme with mocha variant (transparent background) |
| **lualine.nvim** | Fast and easy to configure statusline |
| **nvim-pack** | Neovim's built-in package manager |

### Picking & Navigation

| Package | Description |
|---------|-------------|
| **snacks.nvim** | Feature-rich picker with file search, grep, git integration, and LSP symbol lookup |
| **mini.files** | Lightweight file explorer with split/diff integration |
| **flash.nvim** | Smart motion/search plugin (`s` for jump, `S` for treesitter search) |

### Editing & Code Manipulation

| Package | Description |
|---------|-------------|
| **mini.nvim** (collection) | Mini plugins including: comment, move, trailspace, bufremove, splitjoin, indentscope, diff, git, tabline, ai (textobjects), clue (keymap hints) |
| **vim-abolish** | Smart case-aware substitution and abbreviations |
| **vim-rip-substitute** | Interactive find & replace with live preview |
| **quicker.nvim** | Enhanced quickfix/location list with context expansion |
| **undotree** | Visual undo history browser |
| **ts-comments.nvim** | Treesitter-aware comment syntax detection |

### LSP & Completion

| Package | Description |
|---------|-------------|
| **nvim-lspconfig** | Preconfigured LSP server configurations |
| **nvim-cmp** | Completion engine with floating windows |
| **cmp-nvim-lsp** | LSP completion source |
| **cmp-buffer** | Buffer word completion source |
| **cmp-cmdline** | Command line completion source |
| **cmp-async-path** | Async file path completion |
| **schemastore.nvim** | JSON/YAML schema store for validation |

### Formatting & Linting

| Package | Description |
|---------|-------------|
| **conform.nvim** | Formatter with format-on-save support |
| **nvim-lint** | Linter runner with async execution |

### Debugging

| Package | Description |
|---------|-------------|
| **nvim-dap** | Debug Adapter Protocol client |
| **nvim-dap-ui** | DAP UI with variable inspection |
| **nvim-dap-virtual-text** | Virtual text display of variables |
| **nvim-dap-go** | Go-specific DAP adapter |

### Syntax & Parsing

| Package | Description |
|---------|-------------|
| **nvim-treesitter** | Incremental parser for syntax highlighting and textobjects |
| **nvim-treesitter-textobjects** | Treesitter-aware text motions/selections |

### Utilities & Tools

| Package | Description |
|---------|-------------|
| **copilot.lua** | GitHub Copilot integration (auto-trigger with `<C-y>` accept) |
| **vim-startuptime** | Startup time profiling utility |
| **vim-varnish** | Varnish VCL syntax support |
| **visual-whitespace.nvim** | Visual whitespace highlighting |
| **plenary.nvim** | Common utility library for lua |
| **nvim-nio** | Async I/O library |

### LSP Servers

| Server | Language | Status |
|--------|----------|--------|
| `gopls` | Go | Enabled |
| `dockerls` | Docker | Enabled |
| `buf_ls` | Protocol Buffers | Enabled |
| `lua_ls` | Lua | Enabled |
| `yamlls` | YAML | Enabled |
| `jsonls` | JSON | Enabled |
| `html` | HTML | Enabled |
| `terraformls` | Terraform | Enabled |
| `intelephense` | PHP | Enabled |
| `phptools` | PHP | Disabled (use intelephense) |

## Keybindings

Leader key: **Space** (`<Space>`)

### Navigation & Picker (snacks.nvim)

| Keybind | Action |
|---------|--------|
| `<leader>f` | Find files (including hidden) |
| `<leader>/` | Grep in project |
| `<leader>:` | Command history |
| `<leader><space>` | Switch buffers (exclude current) |
| `<leader>qc` | Find config file |
| `<leader>qp` | Project picker |

### Search & Diagnostics

| Keybind | Action |
|---------|--------|
| `<leader>sg` | Grep workspace |
| `<leader>sc` | Command history |
| `<leader>sC` | Commands |
| `<leader>sd` | Document diagnostics |
| `<leader>sh` | Help pages |
| `<leader>sk` | Keymaps |
| `<leader>sl` / `<leader>sR` | Resume last picker |
| `<leader>s/` | Search lines in current buffer |

### Git Integration (snacks + mini.git)

| Keybind | Action |
|---------|--------|
| `<leader>gg` | Open lazygit |
| `<leader>gl` | Git log (cwd) |
| `<leader>gf` | Git file history |
| `<leader>gc` | Git commit log |
| `<leader>gO` | Toggle git diff overlay |

### LSP (Language Server Protocol)

| Keybind | Action |
|---------|--------|
| `gd` | Goto definition |
| `grr` | Goto references |
| `gri` | Goto implementation |
| `gO` | Document symbols |
| `gD` | Goto declaration |
| `gl` | Open diagnostic in float |
| `<leader>sd` | Buffer diagnostics |
| `<leader>ws` | Workspace symbols |
| `<leader>wd` | Workspace diagnostics |

### Motion & Editing

| Keybind | Action |
|---------|--------|
| `s` | Flash jump (any word) |
| `S` | Flash treesitter jump |
| `<leader>sr` / `<A-r>` | Rip substitute (interactive find & replace) |
| `<C-r>` (visual) | Rip substitute |
| `;` | Alias for `:` (command mode) |
| `<C-c>` (insert) | Exit insert mode |
| `k` / `j` | Smart line navigation (respects wrapped lines) |
| `n` / `N` | Center search result |
| `<C-d>` / `<C-u>` | Center page on scroll |
| `<` / `>` (visual) | Indent with selection retained |
| `<leader>p` (visual) | Paste without overwriting clipboard |

### Files & Buffers

| Keybind | Action |
|---------|--------|
| `<leader>e` | Toggle file explorer (mini.files) |
| `<leader>bd` | Delete buffer |
| `<leader>u` | Toggle undo tree |
| `<C-q>` | Toggle quickfix |
| `>` (quickfix) | Expand context (quicker.nvim) |
| `<` (quickfix) | Collapse context (quicker.nvim) |
| `q` (quickfix, help, etc) | Close window |

### Debugging (DAP)

| Keybind | Action |
|---------|--------|
| `<leader>db` | Toggle breakpoint |
| `<leader>dB` | Conditional breakpoint |
| `<leader>dc` | Run/continue |
| `<leader>dC` | Run to cursor |
| `<leader>dg` | Go to line (no execute) |
| `<leader>di` | Step into |
| `<leader>do` | Step out |
| `<leader>dO` | Step over |
| `<leader>dj` | Down (stack) |
| `<leader>dk` | Up (stack) |
| `<leader>dl` | Run last |
| `<leader>dP` | Pause |
| `<leader>dr` | Toggle REPL |
| `<leader>ds` | View session |
| `<leader>dt` | Terminate |
| `<leader>dw` | Variables hover |
| `<leader>du` | Toggle DAP UI |
| `<leader>de` (normal/visual) | Evaluate expression |

### Plugin Management

| Keybind | Action |
|---------|--------|
| `<leader>ps` | Update plugins |
| `<leader>pc` | Clean unused plugins |

### Mini.clue (Keymap Hints)

Show hint when pressing:
- `<Space>` (leader in normal/visual mode)
- `g` (goto prefix)
- `<C-w>` (window commands)
- `[` / `]` (bracketed movements)

## Autocommands

### LSP Features

- **LspAttach**: Enables LSP keybindings and `:Format` command when LSP attaches
- **LspProgress**: Shows spinner notifications during LSP indexing
- **TextYankPost**: Highlights text on yank for visual feedback

### File Handling

- **BufReadPost**: Returns to last cursor position when reopening files
- **BufEnter**: Disables auto-commenting on new lines
- **FocusGained/TermClose/TermLeave**: Auto-checks if file changed externally
- **FileType**: Closes certain windows (qf, help, man, etc) with `q` key

### Formatting

- **BufWritePre** (Go): Auto-organizes imports and formats on save
- `:FormatDisable` / `:FormatEnable`: Toggle format-on-save globally or per-buffer

### Tree-sitter

- **PackChanged**: Auto-runs `TSUpdate` when treesitter is updated
- **FileType**: Enables treesitter highlighting for supported languages

### Mini.files

- **MiniFilesBufferCreate**: Sets up extra keybinds in file explorer
  - `gs` / `gv`: Open in horizontal/vertical split
  - `gg`: Grep in directory
  - `f`: Find files in directory
  - `gf`: Find files in project
  - `dv`: Diff with buffer
- **MiniFilesActionRename**: Syncs file renames with snacks picker

## Editor Settings

### Visual

- Line numbers enabled
- Cursor line highlighted
- Color column at 120 characters
- Window border: single line
- Transparent background enabled (catppuccin mocha)
- Statusline: lualine with single global line
- Mouse support enabled

### Navigation

- Smooth scrolling: 8 lines above/below cursor
- Sidescroll margin: 8 columns
- Smart case-sensitive search
- Search highlighting enabled
- Center splits on cursor position

### Editing

- Expand tabs to spaces (4 spaces)
- Auto-save enabled
- Undo history persisted to disk
- No swap files
- Soft wrap disabled

### Performance

- Update time: 100ms (for plugin feedback)
- Timeout: 300ms (for key sequences)
- Completion triggers at 1 character

## Formatters

| Language | Formatters |
|----------|-----------|
| Go | gci, golines (with gofumpt base) |
| Terraform / HCL | terraform_fmt, terragrunt_hclfmt |
| JSON | jq |
| Lua | stylua |
| PHP | php_cs_fixer |
| Protocol Buffers | buf |
| Bash/Shell | shfmt (2-space indent) |
| SQL | sqlfmt |
| Twig | ludtwig |

**Format-on-save**: Enabled (disable with `:FormatDisable` or `:FormatDisable!` for current buffer)

## Linters

| Language | Linters |
|----------|---------|
| Go | golangcilint |
| Docker | hadolint |
| JSON | jsonlint |
| PHP | php, phpstan |
| Protocol Buffers | buf_lint |
| Bash/Shell | shellcheck |
| Twig | twig-cs-fixer |

**Lint triggers**: On save, on read, after insert mode exit

## Special Tweaks & Features

### Smart Navigation

- **Line wrapping**: `j`/`k` navigate wrapped lines naturally (with count they jump lines)
- **Search centering**: `n`/`N` and page scroll (`<C-d>`/`<C-u>`) center the screen
- **Indentation memory**: `<`/`>` in visual mode retain selection after indent

### Completion

- LSP priority: LSP suggestions exclude plain "Text" entries
- Path completion: Async path completion in all modes
- Keyword length: Completion triggers at 1 character
- Window style: Bordered floating windows for completion and docs

### Git Integration

- **Mini.git**: Status display and file operations
- **Mini.diff**: Sign-based diff view with overlay toggle
- **Snacks integration**: Lazygit, log, and file history pickers

### File Management

- **Mini.files explorer**: Tree-based navigation with split/diff capabilities
- **Auto-root detection**: Automatically finds project root (via mini.misc)
- **Buffer management**: Easy delete with `<leader>bd`

### Diagnostic Display

- Custom icons for Error/Warn/Hint/Info
- Virtual text with source info (shown when multiple diagnostics)
- Severity-sorted display
- Underline on hover

### Helper Commands

- **:CopyRelativeFilename**: Copy current file path to clipboard
- **:Format**: Format buffer with LSP
- **:FormatDisable** / **:FormatEnable**: Toggle auto-format

### Copilot Integration

- Auto-trigger suggestions (can be toggled per filetype)
- Suggestion accept: `<C-y>`
- Enabled for: YAML, Terraform
- Disabled for: Rip-substitute buffers

### Syntax & Parsing

Treesitter parsers installed for:
- Go (go, gomod, gosum, gowork, gotmpl)
- Terraform (terraform, hcl)
- Languages: Lua, PHP, HTML, JSON, YAML, Bash, Docker, Protocol Buffers
- Templating: Templ, Twig, GoTmpl
- Utilities: Regex, LuaDoc, PhpDoc

Custom filetype detection:
- `.tf` → terraform
- `.templ` → templ
- `.gotmpl` → gotmpl

### Testing (Disabled)

Neotest configuration exists but is commented out. Can be enabled for Go testing with gotestsum runner and coverage tracking.

## Updating Plugins

```vim
:PackUpdate          " Update all plugins
```

Or via keybind: `<leader>ps`

## Plugin Management

Clean unused plugins: `<leader>pc` (prompts for confirmation)

## Notes

- Uses Neovim's native LSP client (no packer/lazy.nvim)
- Minimal dependencies (plenary.nvim for JSON handling)
- Fast startup time (built-in plugins only)
- Modular configuration (separate files per feature)
