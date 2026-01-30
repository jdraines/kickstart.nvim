-- Neovim Configuration Entry Point
-- This file loads all configuration modules from lua/config/
-- which in turn loads all plugins from lua/plugins/

-- Load all configuration
require 'config'

-- Late-stage configuration (things that must run after plugins load)
-- These are kept here per user preference

-- Configure telescope to show hidden files and ignore .gitignore
require('telescope.builtin').find_files { hidden = true, additional_args = { '--no-ignore' } }
require('telescope.builtin').live_grep { hidden = true, additional_args = { '--no-ignore' } }

-- Auto-open neo-tree on startup
vim.cmd 'Neotree filesystem reveal left'

-- vim: ts=2 sts=2 sw=2 et
