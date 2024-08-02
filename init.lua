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

-- load snippets from path/of/your/nvim/config/my-cool-snippets
require("luasnip.loaders.from_vscode").lazy_load({ paths = { "./lua/my-cool-snippets" } })
require("custom-config.luasnip")

--[[ misc config ]]

vim.api.nvim_command('Oil')                                            -- Open Oil file tree on startup
vim.api.nvim_command('autocmd FileType * setlocal formatoptions-=cro') -- prevent from proceeding with comment
