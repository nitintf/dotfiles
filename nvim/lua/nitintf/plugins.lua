return {
   -- stdlib
   {
      "nvim-lua/plenary.nvim",
      version = "*",
   },

   -- theming
   {
      "rktjmp/lush.nvim",
      branch = "main",
      lazy = false,
    },

   {
      "sainnhe/gruvbox-material",
      lazy = "false"
   },

   -- keymaps
   {
      "folke/which-key.nvim",
      version = "*",
      config = require("nitintf.plugins.which-key").setup,
   },

   -- welcome screen
   {
      "goolord/alpha-nvim",
      event = "VimEnter",
      dependencies = { "nvim-tree/nvim-web-devicons" },
      -- config = require("nitintf.plugins.alpha").setup,
   },

   -- essentials
   {
      "echasnovski/mini.trailspace",
      version = "*",
      event = "BufEnter",
      config = require("nitintf.plugins.mini-trailspace").setup,
   },

   {
      "rlane/pounce.nvim",
      version = "*",
      event = "BufEnter",
      config = require("nitintf.plugins.pounce").setup,
   },

   {
      "xiyaowong/virtcolumn.nvim",
      version = "*",
      event = "BufEnter",
      config = require("nitintf.plugins.virtcolumn").setup,
   },

   {
      "lukas-reineke/indent-blankline.nvim",
      main = "ibl",
      config = require("nitintf.plugins.indent-blankline").setup,
   },

   {
      "windwp/nvim-autopairs",
      version = "*",
      config = require("nitintf.plugins.autopairs").setup,
   },

   {
      "kylechui/nvim-surround",
      version = "*",
      config = require("nitintf.plugins.surround").setup,
   },

   {
      "nvim-tree/nvim-web-devicons",
      version = "*",
      config = require("nitintf.plugins.devicons").setup,
    },

   {
      "shortcuts/no-neck-pain.nvim",
      version = "*",
      config = require("nitintf.plugins.no-neck-pain").setup,
   },

   {
      "folke/zen-mode.nvim",
      version = "*",
      config = require("nitintf.plugins.zen-mode").setup,
    },

   -- treesitter
   {
      "nvim-treesitter/nvim-treesitter",
      version = "*",
      event = "BufEnter",
      config = require("nitintf.plugins.treesitter").setup,
      build = ":TSUpdate",
   },

   {
      "nvim-treesitter/nvim-treesitter-textobjects",
      version = "*",
      event = "BufEnter",
   },

   {
      "nkrkv/nvim-treesitter-rescript",
      version = "*",
   },

   -- lsp
   {
      "williamboman/mason.nvim",
      version = "*",
   },

   {
      "williamboman/mason-lspconfig.nvim",
      version = "*",
   },

   {
      "neovim/nvim-lspconfig",
      branch = "master",
      event = "BufEnter",
      config = require("nitintf.plugins.lspconfig").setup,
   },

   {
      "glepnir/lspsaga.nvim",
      branch = "main",   -- TODO: Go back to stable after the current version is released
      event = "BufEnter",
      config = require("nitintf.plugins.lspsaga").setup,
   },

   {
      "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
      branch = "main",
      event = "BufEnter",
      config = require("nitintf.plugins.lsp-lines").setup,
   },

   {
      "jose-elias-alvarez/null-ls.nvim",
      version = "*",
      dependencies = { "nvim-lua/plenary.nvim" },
      event = "BufEnter",
      config = require("nitintf.plugins.null-ls").setup,
   },

   {
      "folke/neodev.nvim",
      version = "*",
   },

   -- autocompletions
   {
      "hrsh7th/nvim-cmp",
      version = "*",
      event = "InsertEnter",
      dependencies = {
         "hrsh7th/cmp-nvim-lsp",
         "hrsh7th/cmp-nvim-lua",
         "hrsh7th/cmp-buffer",
         "hrsh7th/cmp-path",
         "hrsh7th/cmp-cmdline",
         "onsails/lspkind.nvim",
      },
      config = require("nitintf.plugins.cmp").setup,
   },

   {
      "L3MON4D3/LuaSnip",
      version = "*",
      event = "InsertEnter",
      config = require("nitintf.plugins.luasnip").setup,
   },

   -- file tree
   {
      "nvim-neo-tree/neo-tree.nvim",
      branch = "v3.x",
      dependencies = {
         "nvim-lua/plenary.nvim",
         "nvim-tree/nvim-web-devicons",
         "MunifTanjim/nui.nvim",
         {
            "s1n7ax/nvim-window-picker",
            event = "VeryLazy",
            version = "2.*",
            config = require("nitintf.plugins.window-picker").setup,
         },
      },
      config = require("nitintf.plugins.neo-tree").setup,
    },

   -- fuzzy finders
   {
      "nvim-telescope/telescope.nvim",
      branch = "0.1.x",
      dependencies = { "nvim-lua/plenary.nvim" },
      config = require("nitintf.plugins.telescope").setup,
   },

   {
      "nvim-telescope/telescope-file-browser.nvim",
      version = "*",
   },

   -- window management
   {
      "sindrets/winshift.nvim",
      version = "*",
      event = "VimEnter",
      config = require("nitintf.plugins.winshift").setup,
   },

   -- tab & status bar
   {
      "nvim-lualine/lualine.nvim",
      version = "*",
      event = "VimEnter",
      dependencies = { "nvim-tree/nvim-web-devicons" },
      config = require("nitintf.plugins.lualine").setup,
   },

   -- terminal
   {
      "akinsho/toggleterm.nvim",
      version = "*",
      config = require("nitintf.plugins.toggleterm").setup,
   },

   -- git
   {
      "kdheepak/lazygit.nvim",
      version = "*",
   },

   {
      "sindrets/diffview.nvim",
      version = "*",
      dependencies = { "nvim-lua/plenary.nvim" },
      config = require("nitintf.plugins.diffview").setup,
   },

   {
      "lewis6991/gitsigns.nvim",
      branch = "main",
      event = "BufEnter",
      config = require("nitintf.plugins.gitsigns").setup,
   },

   -- search/replace
   {
      "nvim-pack/nvim-spectre",
      version = "*",
      config = require("nitintf.plugins.spectre").setup,
   },

   -- comments
   {
      "numToStr/Comment.nvim",
      version = "*",
      event = "BufEnter",
      config = require("nitintf.plugins.comment").setup,
   },

   {
      "folke/todo-comments.nvim",
      version = "*",
      event = "BufEnter",
      dependencies = { "nvim-lua/plenary.nvim" },
      config = require("nitintf.plugins.todo-comments").setup,
   },

   -- markdown
   {
      "iamcco/markdown-preview.nvim",
      version = "*",
      build = require("nitintf.plugins.markdown-preview").setup,
   },

   {
      "mzlogin/vim-markdown-toc",
      version = "*",
   },

   -- misc
   {
      "tenxsoydev/tabs-vs-spaces.nvim",
      version = "*",
      config = require("nitintf.plugins.tabs-vs-spaces").setup,
   },

   {
      "norcalli/nvim-colorizer.lua",
      version = "*",
      lazy = true,
      config = require("nitintf.plugins.colorizer").setup,
   },
}
