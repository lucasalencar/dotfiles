return {
  {
    -- Close brackets, quotes, etc. automatically
    'jiangmiao/auto-pairs',
    -- event = 'InsertEnter', -- Commented because it is having issues lazy loading it
  },
  {
    -- Add IA copilot to replace my job
    'github/copilot.vim',
    event = 'InsertEnter',
  },
  {
    -- Surround elements with brackets, quotes, etc.
    'tpope/vim-surround',
  },
  {
    -- Opens repeat command (`.`) to plugins
    'tpope/vim-repeat',
  },
  {
    -- Switch between representations of similar data types (e.g. switch array for a set)
    'AndrewRadev/switch.vim',
  },
}
