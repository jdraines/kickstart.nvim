# Modular Neovim Configuration

## Introduction

This is a **modular Neovim configuration** originally forked from [kickstart.nvim](https://github.com/nvim-lua/kickstart.nvim) and reorganized into a clear, maintainable structure.

Unlike the single-file approach of kickstart.nvim, this configuration is organized into logical modules that separate:
- Core settings (options, keymaps, autocommands)
- Plugin specifications (one file per category)
- Language-specific configurations

This makes it easy to:
- **Find** what you're looking for (all LSP stuff is in `lua/plugins/lsp.lua`)
- **Modify** specific functionality without touching everything else
- **Understand** the configuration by reading focused, well-commented files
- **Extend** with new plugins or languages in a structured way

## Configuration Structure

```
~/.config/nvim/
├── init.lua                              # Entry point - loads config
├── lua/
│   ├── config/                           # Core Neovim configuration
│   │   ├── init.lua                      # Loads modules in order
│   │   ├── options.lua                   # Vim options (tabs, UI, search, etc)
│   │   ├── keymaps.lua                   # Basic keymaps (non-plugin)
│   │   ├── autocmds.lua                  # Autocommands & custom commands
│   │   └── lazy.lua                      # Plugin manager bootstrap
│   └── plugins/                          # Plugin specifications
│       ├── completion.lua                # Completion engines (nvim-cmp, blink.cmp)
│       ├── lsp.lua                       # LSP, Mason, language servers
│       ├── telescope.lua                 # Fuzzy finder & keymaps
│       ├── treesitter.lua                # Syntax highlighting
│       ├── ui.lua                        # Colorscheme, statusline, neo-tree
│       ├── editor.lua                    # Text objects, surround, git signs
│       ├── formatting.lua                # Code formatting (conform.nvim)
│       └── lang/                         # Language-specific configs
│           └── python.lua                # Python LSP tweaks
└── lazy-lock.json                        # Plugin version lock file
```

## How to Use This Configuration

### Quick Reference: Where to Find Things

| What You Want to Change | File Location |
|-------------------------|---------------|
| Tab size, line numbers, UI settings | `lua/config/options.lua` |
| Basic keyboard shortcuts | `lua/config/keymaps.lua` |
| Colorscheme | `lua/plugins/ui.lua` |
| LSP servers (add/remove languages) | `lua/plugins/lsp.lua` |
| Telescope keymaps (search shortcuts) | `lua/plugins/telescope.lua` |
| Completion behavior | `lua/plugins/completion.lua` |
| Code formatting rules | `lua/plugins/formatting.lua` |
| Language-specific settings | `lua/plugins/lang/<language>.lua` |

### How the Config Loads

1. **init.lua** → Entry point, calls `require('config')`
2. **lua/config/init.lua** → Loads config modules in order:
   - `options.lua` - Sets up Vim options first (must run early)
   - `keymaps.lua` - Configures basic keymaps
   - `autocmds.lua` - Sets up autocommands
   - `lazy.lua` - Bootstraps plugin manager
3. **lazy.nvim** → Automatically loads ALL files in `lua/plugins/` directory
4. **Each plugin file** → Returns a table (or array of tables) with plugin specs

### Adding a New Plugin

1. Choose the appropriate file in `lua/plugins/` (or create a new one)
2. Add your plugin spec to the return table

**Example**: Adding a new UI plugin to `lua/plugins/ui.lua`:

```lua
return {
  -- ... existing plugins ...
  
  -- Add your new plugin
  {
    'author/plugin-name',
    config = function()
      require('plugin-name').setup({
        -- your config here
      })
    end,
  },
}
```

### Adding Language Support

Create a new file in `lua/plugins/lang/` for language-specific configurations:

**Example**: `lua/plugins/lang/javascript.lua`

```lua
return {
  {
    'neovim/nvim-lspconfig',
    optional = true,
    opts = function()
      -- JavaScript/TypeScript specific LSP configuration
      vim.api.nvim_create_autocmd('LspAttach', {
        callback = function(args)
          local client = vim.lsp.get_client_by_id(args.data.client_id)
          if client and client.name == 'ts_ls' then
            -- Custom keymaps or settings for TypeScript
          end
        end,
      })
    end,
  },
}
```

Then add the LSP server to `lua/plugins/lsp.lua`:

```lua
local servers = {
  -- ... existing servers ...
  ts_ls = {},  -- TypeScript/JavaScript
}
```

### Modifying Existing Functionality

**Example**: Change tab size from 4 to 2 spaces
- Edit `lua/config/options.lua`
- Find the tab settings section (around line 14-20)
- Change `tabstop` and `shiftwidth` from 4 to 2

**Example**: Add a new Telescope keybinding
- Edit `lua/plugins/telescope.lua`
- Find the keymaps section (around line 95-115)
- Add your new keymap:
```lua
vim.keymap.set('n', '<leader>sm', builtin.marks, { desc = '[S]earch [M]arks' })
```

## Key Bindings Cheat Sheet

**Leader key**: `Space`

### Essential Keymaps

| Key | Action | Notes |
|-----|--------|-------|
| `<Space>sf` | Search Files | Telescope file finder |
| `<Space>sg` | Search by Grep | Search text in files |
| `<Space>sh` | Search Help | Search Neovim help |
| `<Space>sk` | Search Keymaps | See all keybindings |
| `<Space><Space>` | Find Buffers | Switch between open files |
| `<Space>f` | Format buffer | Auto-format code |
| `\\` | Toggle Neo-tree | File explorer |
| `Ctrl+h/j/k/l` | Navigate windows | Move between splits |
| `QQQ` | Quit all | Close Neovim (saves if needed) |

### LSP Keymaps (when LSP is active)

| Key | Action |
|-----|--------|
| `grn` | Rename symbol |
| `gra` | Code action |
| `grd` | Go to definition |
| `grr` | Go to references |
| `gri` | Go to implementation |
| `gO` | Document symbols |
| `<leader>th` | Toggle inlay hints |

### Completion Keymaps

- `<C-y>` - Accept completion (blink.cmp default)
- `<C-n>/<C-p>` or `<Up>/<Down>` - Navigate completion menu
- `<C-Space>` - Open completion menu or docs
- `<C-e>` - Close completion menu
- `<Tab>/<S-Tab>` - Navigate snippet placeholders

See `:help ins-completion` for more info on completion.

## Installation

### Prerequisites

External Requirements:
- **Neovim** >= 0.9.0 (latest stable or nightly recommended)
- **Basic utils**: `git`, `make`, `unzip`, C Compiler (`gcc`)
- **Search tools**: [ripgrep](https://github.com/BurntSushi/ripgrep#installation), [fd-find](https://github.com/sharkdp/fd#installation)
- **Clipboard tool**: xclip/xsel/win32yank (depending on platform)
- **[Nerd Font](https://www.nerdfonts.com/)**: Optional, for icons
  - Set `vim.g.have_nerd_font = true` in `lua/config/options.lua` if you have one

### Install Steps

1. **Backup existing config** (if you have one):
```bash
mv ~/.config/nvim ~/.config/nvim.backup
mv ~/.local/share/nvim ~/.local/share/nvim.backup
```

2. **Clone this repository**:
```bash
git clone <your-repo-url> ~/.config/nvim
```

3. **Start Neovim**:
```bash
nvim
```

4. **Wait for plugins to install**:
   - Lazy.nvim will automatically install all plugins
   - Use `:Lazy` to check status
   - Press `q` to close the Lazy window

5. **Restart Neovim** to ensure everything loads correctly

### Post-Installation

- Run `:checkhealth` to verify everything is working
- Run `:Mason` to manage LSP servers, formatters, and linters
- Run `:TSUpdate` to update treesitter parsers if needed

## Managing Plugins

### Viewing Plugin Status
```vim
:Lazy
```

### Updating Plugins
```vim
:Lazy update
```

### Installing New Plugins
1. Add the plugin spec to the appropriate file in `lua/plugins/`
2. Restart Neovim or run `:Lazy reload`
3. Run `:Lazy install`

### Removing Plugins
1. Remove or comment out the plugin spec
2. Restart Neovim
3. Run `:Lazy clean` to remove unused plugins

## Customization Tips

### Changing the Colorscheme

Edit `lua/plugins/ui.lua`, find the tokyonight section (around line 5-22), and either:
- Change the variant: `tokyonight-night`, `tokyonight-storm`, `tokyonight-moon`, `tokyonight-day`
- Or replace with a different colorscheme plugin

### Disabling Plugins

Comment out or remove the plugin from its file in `lua/plugins/`, then restart Neovim.

### Creating Your Own Plugin Categories

Want to organize differently? Create a new file in `lua/plugins/`:

```bash
touch lua/plugins/my-custom-category.lua
```

Then add your plugin specs:

```lua
-- lua/plugins/my-custom-category.lua
return {
  {
    'author/plugin1',
    -- config here
  },
  {
    'author/plugin2',
    -- config here
  },
}
```

Lazy.nvim automatically loads ALL `.lua` files in the `lua/plugins/` directory!

## Troubleshooting

### Plugins Not Loading

1. Check `:Lazy` for errors
2. Try `:Lazy clean` then `:Lazy sync`
3. Check for syntax errors in your plugin files

### LSP Not Working

1. Run `:LspInfo` to see attached servers
2. Run `:Mason` to verify servers are installed
3. Check `lua/plugins/lsp.lua` to ensure your language is configured
4. Run `:checkhealth lsp` for diagnostics

### Treesitter Issues

1. Run `:TSInstall <language>` to install a specific parser
2. Run `:TSUpdate` to update all parsers
3. Run `:checkhealth nvim-treesitter` for diagnostics

### Neo-tree "E21: cannot make changes" Error

This is normal! Neo-tree's buffer is not meant to be edited. To fix:
- Press `\\` to close Neo-tree
- Use `Ctrl+h/j/k/l` to navigate to a different window
- Press `Esc` to cancel the operation

## Advanced Topics

### Using Multiple Neovim Configurations

You can maintain multiple configurations using `NVIM_APPNAME`:

```bash
# Create a second config
git clone <another-config> ~/.config/nvim-test

# Run with alternative config
NVIM_APPNAME=nvim-test nvim

# Or create an alias
alias nvim-test='NVIM_APPNAME=nvim-test nvim'
```

### Lazy Loading Plugins

Most plugins are already configured to lazy load (on events, commands, or keys). To customize:

```lua
{
  'author/plugin',
  lazy = true,          -- Don't load immediately
  event = 'BufEnter',   -- Load on buffer enter
  cmd = 'PluginCmd',    -- Load when command is run
  keys = '<leader>x',   -- Load when key is pressed
}
```

### Debugging Your Configuration

1. Start with verbose output: `nvim -V9`
2. Check startup time: `:Lazy profile`
3. Inspect loaded modules: `:lua print(vim.inspect(package.loaded))`

## Learning Resources

- `:help` - Neovim's built-in help (use `:h <topic>`)
- `:Tutor` - Interactive Vim tutorial
- `:help lua-guide` - Lua in Neovim guide
- `:help lazy.nvim` - Plugin manager docs
- [Neovim Documentation](https://neovim.io/doc/)

## FAQ

**Q: Why split the configuration into multiple files?**
A: It makes the config easier to navigate, understand, and maintain. Want to change LSP settings? Go to `lua/plugins/lsp.lua`. Want to add a keymap? Go to `lua/config/keymaps.lua`. You always know where to look.

**Q: Can I go back to a single-file config?**
A: Yes! Your original `init.lua` is backed up as `init.lua.backup`. Just restore it and remove the `lua/` directory.

**Q: How do I know which file to edit?**
A: Check the "Quick Reference" table at the top of this README. Each file has comments explaining what it contains.

**Q: Will this work with kickstart updates?**
A: This is no longer tracking kickstart.nvim. It's your own configuration now. You can manually port features from kickstart if desired.

**Q: How do I add support for a new language?**
A: 
1. Add the LSP server to the `servers` table in `lua/plugins/lsp.lua`
2. Optionally create `lua/plugins/lang/<language>.lua` for language-specific tweaks
3. Add the treesitter parser to `lua/plugins/treesitter.lua` if needed

**Q: Where are plugins installed?**
A: `~/.local/share/nvim/lazy/` - managed automatically by lazy.nvim

## Credits

- Original config based on [kickstart.nvim](https://github.com/nvim-lua/kickstart.nvim)
- Reorganized into modular structure for better maintainability
- Plugin manager: [lazy.nvim](https://github.com/folke/lazy.nvim)
