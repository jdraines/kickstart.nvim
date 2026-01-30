-- Load configuration modules in the correct order
-- Options must be loaded first (sets leader keys, etc.)
require 'config.options'

-- Load keymaps (basic, non-plugin keymaps)
require 'config.keymaps'

-- Load autocommands and custom commands
require 'config.autocmds'

-- Load lazy.nvim plugin manager
-- This will automatically load all plugins from lua/plugins/
require 'config.lazy'
