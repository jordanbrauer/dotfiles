local telescope = require("telescope.actions")

require('telescope').setup{
  defaults = {
    file_ignore_patterns = {"node_modules", "vendor", ".git"},
    file_previewer = require("telescope.previewers").vim_buffer_cat.new,
    grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
    qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,
    mappings = {
       i = {
         ["<esc>"] = telescope.close
       }
     },
    selection_strategy = "reset",
    sorting_strategy = "descending",
    layout_strategy = "horizontal",
    layout_config = {
      horizontal = {
        mirror = false,
      },
      vertical = {
        mirror = false,
      },
    },
  },
  extensions = {
    ["ui-select"] = {
      require("telescope.themes").get_dropdown { }
    }
  },
  pickers = {
    find_files = {
      theme = "dropdown",
      hidden = true,
    },
    -- lsp_references = {
    --     theme = "dropdown",
    -- }
  },
}

require("telescope").load_extension("ui-select")
