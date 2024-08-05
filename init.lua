vim.g.base46_cache = vim.fn.stdpath "data" .. "/nvchad/base46/"
vim.g.mapleader = " "

-- bootstrap lazy and all plugins
local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(lazypath) then
  local repo = "https://github.com/folke/lazy.nvim.git"
  vim.fn.system { "git", "clone", "--filter=blob:none", repo, "--branch=stable", lazypath }
end

vim.opt.rtp:prepend(lazypath)

local lazy_config = require "configs.lazy"

-- load plugins
require("lazy").setup({
  {
    "NvChad/NvChad",
    lazy = false,
    branch = "v2.5",
    import = "nvchad.plugins",
    config = function()
      require "options"
    end,
  },

  { import = "plugins" },
}, lazy_config)

-- require("nvim-tree").setup {
--   diagnostics = {
--     enable = true
--   },
--   view = {
--     -- side = 'right',
--     side = "left",
--     width = 45,
--   },
-- }

-- require("smartcolumn").setup()
require("Comment").setup()

-- load theme
dofile(vim.g.base46_cache .. "defaults")
dofile(vim.g.base46_cache .. "statusline")

require "nvchad.autocmds"


vim.schedule(function()
  require "mappings"
  require "options"
end)


-- override color of inactive relative line numbers
-- https://www.color-hex.com/color/d5c4a1
vim.cmd([[highlight LineNr guifg=#958970 gui=NONE]])

-- Function to get the RGB color of a highlight group
local function get_font_color(highlight_group)
  local hl = vim.api.nvim_get_hl_by_name(highlight_group, true)
  local fg = hl.fg or hl.foreground
  if fg then
    -- Convert from hex to RGB
    return string.format("#%06x", fg)
  else
    return nil
  end
end

-- Example usage to get the font color for 'Normal'
local font_color = get_font_color('Normal')
print("Font color for 'Normal': " .. font_color)


--[[ load custom plugins and configuration ]]

require("custom-config.gen-nvim")
require("custom-plugins.clemens-tree")
require("custom-config.oil-config")
require("custom-config.folding")
require("custom-config.scrolling")

-- load snippets from path/of/your/nvim/config/my-cool-snippets
require("luasnip.loaders.from_vscode").lazy_load({ paths = { "./lua/my-cool-snippets" } })
require("custom-config.luasnip")

--[[ misc config ]]

vim.api.nvim_command('Oil')                                            -- Open Oil file tree on startup
vim.api.nvim_command('autocmd FileType * setlocal formatoptions-=cro') -- prevent from proceeding with comment

require("neotest").setup({
  adapters = {
    require("neotest-dotnet")
  }
})

-- -- yeeeeah
--
-- local cmd = vim.cmd  -- For executing Vim commands
-- local fn = vim.fn    -- The nvim function API
-- local api = vim.api  -- The nvim api
--
-- -- Function to execute the Bash script and capture its output
-- local function get_commit()
--   local handle = io.popen("get-commit")
--   if not handle then
--     print("Failed to run get-commit script")
--     return ""
--   end
--   local result = handle:read("*a")
--   handle:close()
--   return result
-- end
--
-- -- Function to create a floating window and display the output
-- local function show_output_in_float_window(output)
--   -- Create a new float win with some dimensions and position
--   local width = fn.winwidth(0) - 2
--   local height = 10
--   local row = (fn.winheight(0) - height) / 2
--   local col = (fn.winwidth(0) - width) / 2
--
--   -- Create the float window
--   api.nvim_command('botright new')
--   api.nvim_buf_set_option(0, 'filetype', 'markdown')
--  api.nvim_win_set_config(0, { relative: 'editor', row = row, col = col, width = width, height = height })
--
--   -- Set the content of the float window
--   vim.api.nvim_buf_set_lines(0, 0, -1, false, { output })
-- end
--
-- -- Main function to execute and display the commit message
-- local function show_commit()
--   local output = get_commit()
--   if output ~= "" then
--     show_output_in_float_window(output)
--   else
--     print("No output from get-commit script")
--   end
-- end
--
-- -- Command to call the main function when executed in Neovim
-- cmd('command! ShowCommit lua require"user.get_commit".show_commit()')



-- Load the commit viewer module
local commit_viewer = require('commit_viewer')

-- Create a command to show the commit in a floating window
vim.api.nvim_create_user_command('ShowCommit', commit_viewer.show_commit, {})



-- using the command
vim.api.nvim_set_keymap('n', '<leader>z', '<cmd>Centerpad<cr>', { silent = true, noremap = true })

-- or using the lua function
vim.api.nvim_set_keymap('n', '<leader>z', "<cmd>lua require'centerpad'.toggle{ leftpad = 55, rightpad = 55 }<cr>", { silent = true, noremap = true })
