require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set
local opts = { noremap = true, silent = true }

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")
--

-- map("n", "<leader>ff", "^vf{%j%V", { desc = "highlight function with body" })

-- Define a Lua function to highlight the C# method
function HighlightCSharpMethod()
  -- Jump to the beginning of the line
  -- vim.api.nvim_input('^vf{%j%V')
  vim.api.nvim_input "0"
  -- Enter visual mode
  vim.api.nvim_input "v"
  -- Move to the next "{" character
  vim.api.nvim_input "/{<CR>"
  -- Move to the matching "}" character
  vim.api.nvim_input "%"
  vim.api.nvim_input "V"
end

-- vim.api.nvim_set_keymap('n', '<leader>ff', ':lua HighlightCSharpMethod()<CR>', { noremap = true, silent = true })
map("n", "<leader>aa", ":lua HighlightCSharpMethod()<CR>", { noremap = true, silent = true })
-- map("n", "<leader>aa", "<cmd>Telescope find_files<cr>", { desc = "Telescope Find files" })
map("n", "<F12>", "<Cmd>lua vim.lsp.buf.definition()<CR>", opts)
map("n", "K", "<Cmd>lua vim.lsp.buf.hover()<CR>", opts)
map("n", "gr", "<cmd>Telescope lsp_references<CR>", opts)
map("n", "gR", "<cmd>Telescope lsp_references<CR>", opts)
map("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
map("n", "<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
map("n", "<leader>wa", "<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>", opts)
map("n", "<leader>wr", "<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>", opts)
map("n", "<leader>wl", "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>", opts)
map("n", "<leader>D", "<cmd>lua vim.lsp.buf.type_definition()<CR>", opts)
map("n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
map("n", "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)

-- map("n", "<leader>e", "<cmd>NvimTreeFindFile<CR>", opts)
-- map("n", "<A-^[OP>", "<cmd>NvimTreeFindFile<CR>", opts)
map("n", "<A-a>", "<cmd>NvimTreeFindFile<CR>", opts)

map("n", ";", ":", { desc = "CMD enter command mode" })

-- Add a keymap for Shift+Tab to switch to the previous buffer
map("n", "<S-Tab>", ":b#<CR>", opts)

-- Map the custom function to a key
map("n", "T", "<Cmd>Telescope buffers<CR>", { noremap = true, silent = true, desc = "open buffers" })

-- close other buffers
function CloseOtherBuffers()
  local current_buf = vim.api.nvim_get_current_buf()
  local buffers = vim.api.nvim_list_bufs()

  for _, buf in ipairs(buffers) do
    if buf ~= current_buf and vim.api.nvim_buf_is_valid(buf) then
      vim.api.nvim_buf_delete(buf, { force = true })
    end
  end
end

vim.api.nvim_create_user_command("CloseOtherBuffers", CloseOtherBuffers, {})
map('n', '<leader>co', ':CloseOtherBuffers<CR>', { noremap=true, silent=true, desc = "close other buffers" })

-- Define a function to toggle comments
function ToggleComment()
  require('Comment.api').toggle.linewise.current()
end

-- Create a command for it
vim.api.nvim_create_user_command('ToggleComment', ToggleComment, {})

-- Map Ctrl-k followed by c to toggle comments
vim.api.nvim_set_keymap('n', '<C-k>c', ':ToggleComment<CR>', { noremap=true, silent=true })
vim.api.nvim_set_keymap('n', '<C-k><C-c>', ':ToggleComment<CR>', { noremap=true, silent=true })
