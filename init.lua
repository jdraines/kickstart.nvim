-- Neovim Configuration Entry Point
-- This file loads all configuration modules from lua/config/
-- which in turn loads all plugins from lua/plugins/

-- Load all configuration
require 'config'

-- Late-stage configuration (things that must run after plugins load)
-- These are kept here per user preference

-- Auto-open neo-tree on startup
vim.cmd 'Neotree filesystem reveal left'

-- vim: ts=2 sts=2 sw=2 et
