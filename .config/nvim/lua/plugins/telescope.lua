return {
    "nvim-telescope/telescope.nvim",
    tag = '0.1.5',
    dependencies = {
        'nvim-lua/plenary.nvim'
    },
    config = function()

require('telescope').setup{
  defaults = {
    -- Default configuration for telescope goes here:
    -- config_key = value,
    mappings = {
      n = {
        -- map actions.which_key to <C-h> (default: <C-/>)
        -- actions.which_key shows the mappings for your picker,
        -- e.g. git_{create, delete, ...}_branch for the git_branches picker
        ["q"] = require('telescope.actions').close
      },
      i = {
          ["<ESC>"] = require('telescope.actions').close 
      }
    }
  },
  pickers = {
    -- Default configuration for builtin pickers goes here:
    -- picker_name = {
    --   picker_config_key = value,
    --   ...
    -- }
    -- Now the picker_config_key will be applied every time you call this
    -- builtin picker
  },
  extensions = {
    -- Your extension configuration goes here:
    -- extension_name = {
    --   extension_config_key = value,
    -- }
    -- please take a look at the readme of the extension you want to configure
  }
}

local builtin = require("telescope.builtin")
        vim.keymap.set('n', '<C-p>', builtin.find_files, {})
        vim.keymap.set('n', '<C-l>', builtin.live_grep, {})
        vim.keymap.set('n', '<leader>b', builtin.buffers, {})
    end
}
