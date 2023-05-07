local telescope = require('telescope')

telescope.setup {
    defaults = {
      scroll_strategy = "limit";
      file_ignore_patterns = { ".git/[^h]", "__pycache__/*" };
    },
    pickers = {
        find_files = {
            hidden = false
        }
    }
}

-- To get fzf loaded and working with telescope,
-- you need to call load_extension, somewhere after
-- the setup function.
telescope.load_extension('fzf')
