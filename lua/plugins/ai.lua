-- AI assistance plugins
-- Provides AI-powered code completion and assistance tools

return {
  -- 99: Neovim AI agent by ThePrimeagen
  -- Requires opencode CLI to be installed and configured
  -- https://github.com/ThePrimeagen/99
  {
    'ThePrimeagen/99',
    dependencies = {
      'hrsh7th/nvim-cmp', -- Required for @ completion feature
    },
    config = function()
      local _99 = require '99'

      -- Get current working directory info for logging
      local cwd = vim.uv.cwd()
      local basename = vim.fs.basename(cwd)

      _99.setup {
        logger = {
          level = _99.DEBUG,
          path = '/tmp/' .. basename .. '.99.debug',
          print_on_error = true,
        },

        -- Completion configuration for @ skill tags
        completion = {
          -- Defaults to .cursor/rules
          -- cursor_rules = "<custom path to cursor rules>"

          -- A list of folders where you have your own SKILL.md files
          -- Expected format: /path/to/dir/<skill_name>/SKILL.md
          --
          -- Example:
          -- Input Path: "scratch/custom_rules/"
          -- Output Rules:
          -- {path = "scratch/custom_rules/vim/SKILL.md", name = "vim"},
          -- ... other rules in that dir ...
          --
          -- Uncomment and customize as needed:
          -- custom_rules = {
          --   "~/.config/nvim/skills/",
          -- },

          -- What autocomplete source to use (currently only supports cmp)
          source = 'cmp',
        },

        -- Automatically include markdown files based on file location
        -- When editing /foo/bar/baz.lua, the system will look for:
        -- /foo/bar/AGENT.md
        -- /foo/AGENT.md
        -- (assuming /foo is project root based on cwd)
        md_files = {
          'AGENT.md',
        },
      }

      -- Keymaps for 99 AI agent
      -- Leader key is <Space> by default

      -- Fill in function body with AI assistance
      -- Use when your cursor is inside a function definition
      vim.keymap.set('n', '<leader>9f', function()
        _99.fill_in_function()
      end, { desc = '[9]9: [F]ill function' })

      -- AI assistance for visual selection
      -- Select code in visual mode, then use this keymap
      -- Note: Uses your last visual selection, so keep it in visual mode
      vim.keymap.set('v', '<leader>9v', function()
        _99.visual()
      end, { desc = '[9]9: [V]isual mode AI' })

      -- Stop all running AI requests
      -- Useful if you want to cancel changes before they're applied
      vim.keymap.set('n', '<leader>9s', function()
        _99.stop_all_requests()
      end, { desc = '[9]9: [S]top requests' })

      -- View logs from the last AI request
      -- Useful for debugging or understanding what happened
      vim.keymap.set('n', '<leader>9l', function()
        _99.view_logs()
      end, { desc = '[9]9: View [L]ogs' })

      -- Navigate request logs
      vim.keymap.set('n', '<leader>9n', function()
        _99.next_request_logs()
      end, { desc = '[9]9: [N]ext request logs' })

      vim.keymap.set('n', '<leader>9p', function()
        _99.prev_request_logs()
      end, { desc = '[9]9: [P]revious request logs' })

      -- Example: Custom keymap with specific behavior
      -- You can create rule files like ~/.config/nvim/skills/debug/SKILL.md
      -- that define custom AI behaviors for specific tasks
      --
      -- vim.keymap.set("n", "<leader>9d", function()
      --   _99.fill_in_function()
      -- end, { desc = '[9]9: [D]ebug function' })
    end,
  },
}
