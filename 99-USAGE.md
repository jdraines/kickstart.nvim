# 99 AI Agent Usage Guide

## Overview

The 99 plugin by ThePrimeagen is now installed and configured in your Neovim setup. It provides AI-powered code assistance directly in your editor using OpenCode.

## Prerequisites ✓

- [x] Neovim with modular configuration
- [x] OpenCode CLI installed (v1.1.47)
- [x] nvim-cmp completion engine (switched from blink.cmp)

## Quick Start

### Basic Commands

1. **Fill Function Bodies** (`<Space>9f`)
   - Place your cursor inside a function definition
   - Press `<Space>9f`
   - The AI will generate the function body based on context

2. **AI Assistance on Selection** (`<Space>9v` in Visual mode)
   - Select code in visual mode
   - Press `<Space>9v`
   - Provide a prompt for what you want to do with the selection
   - AI will modify or generate code based on your request

3. **Stop AI Requests** (`<Space>9s`)
   - Use this to cancel any running AI requests if needed

4. **View Logs** (`<Space>9l`)
   - See detailed logs of the last AI request
   - Useful for debugging or understanding what happened

5. **Navigate Logs** (`<Space>9n` / `<Space>9p`)
   - Browse through previous AI request logs

## Advanced Features

### @ Skill Completion

When prompting the AI, you can use `@` to access skill-based completions:

1. Type `@` at the start of your prompt
2. nvim-cmp will show available skills
3. Select a skill to apply specific AI behaviors

**Creating Custom Skills:**

1. Create a directory structure:
   ```
   ~/.config/nvim/skills/
   ├── debug/
   │   └── SKILL.md
   ├── refactor/
   │   └── SKILL.md
   └── test/
       └── SKILL.md
   ```

2. Update `lua/plugins/ai.lua`:
   ```lua
   custom_rules = {
     "~/.config/nvim/skills/",
   },
   ```

3. Each SKILL.md defines the AI behavior for that skill

### Project-Specific Context with AGENT.md

The 99 plugin automatically looks for `AGENT.md` files in your project:

```
/your-project/
├── AGENT.md          # Project-level context
├── src/
│   ├── AGENT.md      # Directory-specific context
│   └── module.lua
```

When working on `src/module.lua`, the AI will automatically include:
- `/your-project/src/AGENT.md`
- `/your-project/AGENT.md`

This allows you to provide project-specific instructions without modifying your Neovim config.

## Typical Workflows

### 1. Implementing a New Function

```lua
-- Write the function signature
function calculate_fibonacci(n)
  -- Place cursor here, press <Space>9f
end
```

The AI will fill in the implementation based on:
- The function name and parameters
- Surrounding code context
- Any AGENT.md files in your project

### 2. Refactoring Code

1. Select the code block in visual mode
2. Press `<Space>9v`
3. Enter a prompt like: "Refactor this to use async/await"
4. Review and accept the AI's suggestion

### 3. Adding Documentation

1. Select a function in visual mode
2. Press `<Space>9v`
3. Enter: "Add detailed JSDoc comments"
4. AI generates appropriate documentation

## Configuration Files

- **Main plugin config**: `lua/plugins/ai.lua`
- **Keymaps**: Defined in `lua/plugins/ai.lua` (lines 58-89)
- **Completion engine**: `lua/plugins/completion.lua` (nvim-cmp)

## Troubleshooting

### Plugin Not Loading

```vim
:Lazy
```

Check if ThePrimeagen/99 is installed and loaded.

### Completion Not Working

1. Verify nvim-cmp is active:
   ```vim
   :lua print(vim.inspect(require('cmp')))
   ```

2. Check completion sources:
   ```vim
   :lua print(vim.inspect(require('cmp').get_config().sources))
   ```

### OpenCode Issues

1. Verify OpenCode is working:
   ```bash
   opencode --version
   ```

2. Check OpenCode configuration:
   ```bash
   opencode config
   ```

### View Debug Logs

The plugin logs to `/tmp/<project-name>.99.debug`. View logs:

```vim
:lua require("99").view_logs()
```

Or from the terminal:
```bash
tail -f /tmp/$(basename $(pwd)).99.debug
```

## Known Limitations

1. **Language Support**: Currently optimized for TypeScript and Lua
2. **Alpha Software**: The plugin is still in alpha, expect occasional issues
3. **Visual Selection**: Sends the whole file, not just selection
4. **Long Functions**: Virtual text positioning may be off with long function signatures

## Resources

- [99 GitHub Repository](https://github.com/ThePrimeagen/99)
- [OpenCode Documentation](https://opencode.ai/)
- Your config: `~/.config/nvim/lua/plugins/ai.lua`

## Next Steps

1. Start Neovim: `nvim`
2. Wait for plugins to install (Lazy will run automatically)
3. Try the basic commands on some code
4. Create AGENT.md files for your projects
5. Experiment with custom skills (optional)

Happy coding with AI assistance!
