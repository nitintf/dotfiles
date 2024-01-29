local g = vim.g
local km = vim.keymap 

-- leader
g.mapleader =  " "
g.maplocalleader = " "

-- insert mode
local insert_mode_mappings = {
    {  "jj", "<ESC>" },
}

-- normal mode
local normal_mode_mappings = {
  { "<leader>ch", ":nohl<CR>" }, -- clear search highlight
  { "<leader>+", "<C-a>" }, -- increment number
  { "<leader>-", "<C-x>" }, -- direment number


  -- Split windows
  { "<leader>sv", "<C-w>v" }, -- split window vertically
  { "<leader>sh", "<C-w>s" }, -- split window horizontally
  { "<leader>se", "<C-w>=" }, -- make split windows equally width
  { "<leader>sx", ":close<CR>" }, -- close surrent split window
  -- vim-maximizer
  { "<leader>sm", ":MaximizerToggle<CR>" },

  -- Tabs
  { "<leader>to", ":tabnew<CR>" }, -- opens new tab
  { "<leader>tx", ":tabclose<CR>" }, -- close new tab
  { "<leader>tn", ":tabn<CR>" }, -- go to next tab
  { "<leader>tp", ":tabp<CR>" }, -- go to previous tab

  -- Neotree
    { "<leader>e",  ":Neotree source=filesystem position=float toggle=true reveal=true<CR>" },
    { "<leader>ge", ":Neotree source=git_status position=float toggle=true reveal=true<CR>" },

--   { "<leader>ff", ":Telescope find_files<CR>" },
--   { "<leader>fs", ":Telescope live_grep<CR>" },
--   { "<leader>fc", ":Telescope grep_string<CR>" },
--   { "<leader>fb", ":Telescope buffers<CR>" },
--   { "<leader>fh", ":Telescope help_tags<CR>" },

}

-- function to set key mappings from a list
local function set_key_mappings(mode, mappings)
    for _, mapping in ipairs(mappings) do
        km.set(mode, mapping[1], mapping[2], { noremap = true, silent = true })
    end
end

set_key_mappings("i", insert_mode_mappings)

set_key_mappings("n", normal_mode_mappings)
