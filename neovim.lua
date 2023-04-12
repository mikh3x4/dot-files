
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.api.nvim_set_keymap('i', 'jk', '<Esc>', { noremap = true })
vim.api.nvim_set_keymap('t', 'jk', '<C-\\><C-n>', { noremap = true })

vim.wo.number = true
vim.opt.number = true

vim.opt.cursorline = true
vim.opt.syntax = 'on'

vim.opt.incsearch = true
vim.opt.hlsearch = true
vim.o.hlsearch = false

vim.cmd('command! W w')

-- Enable mouse mode
vim.o.mouse = 'a'

vim.o.clipboard = 'unnamedplus'

-- Enable break indent
vim.o.breakindent = true

-- Save undo history
vim.o.undofile = true

-- Case insensitive searching UNLESS /C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

-- Keep signcolumn on by default
vim.wo.signcolumn = 'yes'

-- Decrease update time
vim.o.updatetime = 250
vim.o.timeout = true
vim.o.timeoutlen = 300

-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menuone,noselect'

-- NOTE: You should make sure your terminal supports this
vim.o.termguicolors = true


-- Install package manager
--    https://github.com/folke/lazy.nvim
--    `:help lazy.nvim.txt` for more info
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system {
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', -- latest stable release
    lazypath,
  }
end
vim.opt.rtp:prepend(lazypath)


-- NOTE: Here is where you install your plugins.
--  You can configure plugins using the `config` key.
--  You can also configure plugins after the setup call,
--    as they will be available in your neovim runtime.
require('lazy').setup({

  { -- Theme inspired by Atom
    -- 'tomasr/molokai',
    'navarasu/onedark.nvim',
    priority = 1000,
    config = function()
      vim.cmd.colorscheme 'onedark'
    end,
  },

  -- Git related plugins
  'tpope/vim-fugitive',
  'tpope/vim-rhubarb',

  { -- Adds git releated signs to the gutter, as well as utilities for managing changes
    'lewis6991/gitsigns.nvim',
    opts = {
      signs = {
        add = { text = '+' },
        change = { text = '~' },
        delete = { text = '_' },
        topdelete = { text = '‾' },
        changedelete = { text = '~' },
      },
    },
  },

  -- Detect tabstop and shiftwidth automatically
  'tpope/vim-sleuth',

  { -- LSP Configuration & Plugins
    'neovim/nvim-lspconfig',
    dependencies = {
      -- Automatically install LSPs to stdpath for neovim
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',

      -- Useful status updates for LSP
      -- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
      { 'j-hui/fidget.nvim', opts = {} },

      -- Additional lua configuration, makes nvim stuff amazing!
      'folke/neodev.nvim',
    },
  },

  { -- Autocompletion
    'hrsh7th/nvim-cmp',
    dependencies = { 'hrsh7th/cmp-nvim-lsp',
                     'L3MON4D3/LuaSnip',
                     'saadparwaiz1/cmp_luasnip',
                     'hrsh7th/cmp-path',
                     'hrsh7th/cmp-buffer',
                    },
  },

  -- Useful plugin to show you pending keybinds.
  { 'folke/which-key.nvim', opts = {} },



  { -- Set lualine as statusline
    'nvim-lualine/lualine.nvim',
    opts = {
      options = {
        icons_enabled = true,
        theme = 'onedark',
        component_separators = '|',
        section_separators = '',
      },
    },
  },

  { -- Add indentation guides even on blank lines
    'lukas-reineke/indent-blankline.nvim',
    -- Enable `lukas-reineke/indent-blankline.nvim`
    -- See `:help indent_blankline.txt`
    opts = {
      char = '┊',
      show_trailing_blankline_indent = false,
    },
  },

  -- "gc" to comment visual regions/lines
  { 'numToStr/Comment.nvim', opts = {} },

  -- Fuzzy Finder (files, lsp, etc)
  { 'nvim-telescope/telescope.nvim', version = '*', dependencies = { 'nvim-lua/plenary.nvim' } },

  -- Fuzzy Finder Algorithm which requires local dependencies to be built.
  -- Only load if `make` is available. Make sure you have the system
  -- requirements installed.
  {
    'nvim-telescope/telescope-fzf-native.nvim',
    -- NOTE: If you are having trouble with this installation,
    --       refer to the README for telescope-fzf-native for more instructions.
    build = 'make',
    cond = function()
      return vim.fn.executable 'make' == 1
    end,
  },

  { -- Highlight, edit, and navigate code
    'nvim-treesitter/nvim-treesitter',
    dependencies = {
      'nvim-treesitter/nvim-treesitter-textobjects',
    },
    config = function()
      pcall(require('nvim-treesitter.install').update { with_sync = true })
    end,
  },


  -- folding
  { 'tmhedberg/SimpylFold',
    config = function()
      vim.api.nvim_exec([[
        autocmd BufWinEnter * silent! :%foldopen!
        set foldlevelstart=99
        au InsertLeave,TextChanged *.py set foldmethod=expr
      ]], false)
    end,
  },

-- delete operations no longer yank
  { 'svermeulen/vim-cutlass',
  config = function()
      vim.api.nvim_exec([[
        nnoremap m d
        xnoremap m d
        nnoremap mm dd
        nnoremap M D
      ]], false)
    end,
    },
  -- {
  -- "gbprod/cutlass.nvim",
  -- config = function()
  --   require("cutlass").setup({
  --     -- your configuration comes here
  --     -- or leave it empty to use the default settings
  --     -- refer to the configuration section below
  --   })
  -- end
  -- },

   'mg979/vim-visual-multi',

}, {})

-- [[ Basic Keymaps ]]
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })


-- [[ Configure Telescope ]]
-- See `:help telescope` and `:help telescope.setup()`
require('telescope').setup {
  defaults = {
    mappings = {
      i = {
        ['<C-u>'] = false,
        ['<C-d>'] = false,
      },
    },
  },
}




-- [[ Configure Treesitter ]]
-- See `:help nvim-treesitter`
require('nvim-treesitter.configs').setup {
  -- Add languages to be installed here that you want installed for treesitter
  ensure_installed = { 'c', 'cpp', 'go', 'lua', 'python', 'rust', 'tsx', 'typescript', 'vimdoc', 'vim' },

  -- Autoinstall languages that are not installed. Defaults to false (but you can change for yourself!)
  auto_install = false,

  highlight = { enable = true },
  indent = { enable = true, disable = { 'python' } },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = '<c-space>',
      node_incremental = '<c-space>',
      scope_incremental = '<c-s>',
      node_decremental = '<M-space>',
    },
  },
  textobjects = {
    select = {
      enable = true,
      lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
      keymaps = {
        -- You can use the capture groups defined in textobjects.scm
        ['aa'] = '@parameter.outer',
        ['ia'] = '@parameter.inner',
        ['af'] = '@function.outer',
        ['if'] = '@function.inner',
        ['ac'] = '@class.outer',
        ['ic'] = '@class.inner',
      },
    },
    move = {
      enable = true,
      set_jumps = true, -- whether to set jumps in the jumplist
      goto_next_start = {
        [']f'] = '@function.outer',
        [']c'] = '@class.outer',
      },
      -- goto_next_end = {
      --   [']F'] = '@function.outer',
      --   [']['] = '@class.outer',
      -- },
      goto_previous_start = {
        ['[f'] = '@function.outer',
        ['[c'] = '@class.outer',
      },
      -- goto_previous_end = {
      --   ['[F'] = '@function.outer',
      --   ['[]'] = '@class.outer',
      -- },
    },
    -- swap = {
    --   enable = false,
    --   swap_next = {
    --     ['<leader>a'] = '@parameter.inner',
    --   },
    --   swap_previous = {
    --     ['<leader>A'] = '@parameter.inner',
    --   },
    -- },
  },
}



-- Enable telescope fzf native, if installed
pcall(require('telescope').load_extension, 'fzf')

-- See `:help telescope.builtin`
-- space mode
vim.keymap.set({'n', 'v'}, '<leader>?', require('telescope.builtin').commands, { desc = '[?] Open command palette' })
vim.keymap.set({'n', 'v'}, '<leader>b', require('telescope.builtin').buffers, { desc = '[b] Find existing buffers' })
vim.keymap.set({'n', 'v'}, '<leader>f', require('telescope.builtin').git_files, { desc = '[f] Open file picker' })
vim.keymap.set({'n', 'v'}, '<leader>F', require('telescope.builtin').find_files, { desc = '[F] Open file picker at current working directory' })
vim.keymap.set({'n', 'v'}, '<leader>j', require('telescope.builtin').jumplist, { desc = '[j] Open jumplist picker' })
vim.keymap.set({'n', 'v'}, '<leader>/', require('telescope.builtin').live_grep, { desc = '[/] Global search in workspace folder' })

vim.keymap.set('n', 'ge', 'G' , { desc = 'Go to the end of the file' })
vim.keymap.set('n', 'gl', '$' , { desc = 'Go to the end of the line' })
vim.keymap.set('n', 'gh', '0' , { desc = 'Go to the start of the line' })
vim.keymap.set('n', 'gs', '^' , { desc = 'Go to first non-whitespace character of the line' })

vim.keymap.set('n', 'gt', 'H' , { desc = 'Go to the top of the screen' })
vim.keymap.set('n', 'gc', 'M' , { desc = 'Go to the center of the screen' })
vim.keymap.set('n', 'gb', 'L' , { desc = 'Go to the bottom of the screen' })

vim.keymap.set('n', 'gn', ':bn' , { desc = 'next buffer' })
vim.keymap.set('n', 'gp', ':bp' , { desc = 'previous buffer' })

vim.keymap.set('n', '<leader>w', '<C-w>' , { desc = 'Window Mode' })
vim.keymap.set('n', '<leader>wv', '<C-w>v' , { desc = 'Vertical right split' })
vim.keymap.set('n', '<leader>ws', '<C-w>s' , { desc = 'Horizontal bottom split' })
vim.keymap.set('n', '<leader>ww', '<C-w><C-w>' , { desc = 'Switch to next window' })

-- vim.keymap.set('n', 'miw', require('telescope.builtin').diagnostics, { desc = '[S]earch [D]iagnostics' })
--
vim.keymap.set('n', 'mm', '%', { desc = 'Goto matching bracket' })
--
-- vim.keymap.set('n', 'miw', 'viw', { desc = 'test' })
-- vim.keymap.set('n', 'miW', 'viW', { desc = 'test' })
-- vim.keymap.set('n', 'mi[', 'vi[', { desc = 'test' })
-- vim.keymap.set('n', 'mi(', 'vi(', { desc = 'test' })

-- Diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = "Go to previous diagnostic message" })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = "Go to next diagnostic message" })
-- vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = "Open floating diagnostic message" })
-- vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = "Open diagnostics list" })




-- LSP settings.
--  This function gets run when an LSP connects to a particular buffer.
local on_attach = function(_, bufnr)
  -- NOTE: Remember that lua is a real programming language, and as such it is possible
  -- to define small helper and utility functions so you don't have to repeat yourself
  -- many times.
  --
  -- In this case, we create a function that lets us more easily define mappings specific
  -- for LSP related items. It sets the mode, buffer and description for us each time.
  local nmap = function(keys, func, desc)
    if desc then
      desc = 'LSP: ' .. desc
    end

    vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
  end


  nmap('gd', vim.lsp.buf.definition, '[G]oto [D]efinition')
  nmap('gD', vim.lsp.buf.type_definition, '[G]oto [T]ype Definition')
  nmap('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
  nmap('gi', vim.lsp.buf.implementation, '[G]oto [I]mplementation')

  nmap('<leader>k', vim.lsp.buf.hover, 'Hover Documentation')
  nmap('<leader>r', vim.lsp.buf.rename, '[R]ename symbol')
  nmap('<leader>a', vim.lsp.buf.code_action, 'Code [A]ction')

  nmap('<leader>s', require('telescope.builtin').lsp_document_symbols, 'Open document [s]ymbol picker ')
  nmap('<leader>S', require('telescope.builtin').lsp_dynamic_workspace_symbols, 'Open workspace [S]ymbol picker ')

  -- nmap('<C-k>', vim.lsp.buf.signature_help, 'Signature Documentation')

  -- -- Lesser used LSP functionality
  -- nmap('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
  -- nmap('<leader>wa', vim.lsp.buf.add_workspace_folder, '[W]orkspace [A]dd Folder')
  -- nmap('<leader>wr', vim.lsp.buf.remove_workspace_folder, '[W]orkspace [R]emove Folder')
  -- nmap('<leader>wl', function()
  --   print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  -- end, '[W]orkspace [L]ist Folders')

  -- Create a command `:Format` local to the LSP buffer
  vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
    vim.lsp.buf.format()
  end, { desc = 'Format current buffer with LSP' })
end

-- Enable the following language servers
--  Feel free to add/remove any LSPs that you want here. They will automatically be installed.
--
--  Add any additional override configuration in the following tables. They will be passed to
--  the `settings` field of the server config. You must look up that documentation yourself.
local servers = {
  clangd = {},
  -- gopls = {},
  pyright = {},
  pylsp = {},
  rust_analyzer = {},
  -- tsserver = {},

  lua_ls = {
    Lua = {
      workspace = { checkThirdParty = false },
      telemetry = { enable = false },
    },
  },
}

-- Setup neovim lua configuration
require('neodev').setup()

-- nvim-cmp supports additional completion capabilities, so broadcast that to servers
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

-- Setup mason so it can manage external tooling
require('mason').setup()

-- Ensure the servers above are installed
local mason_lspconfig = require 'mason-lspconfig'

mason_lspconfig.setup {
  ensure_installed = vim.tbl_keys(servers),
}

mason_lspconfig.setup_handlers {
  function(server_name)
    require('lspconfig')[server_name].setup {
      capabilities = capabilities,
      on_attach = on_attach,
      settings = servers[server_name],
    }
  end,
}

-- nvim-cmp setup
local cmp = require 'cmp'
local luasnip = require 'luasnip'

luasnip.config.setup {}

cmp.setup {
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert {
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete {},
    ['<CR>'] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    },
    ['<Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end, { 'i', 's' }),
    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { 'i', 's' }),
  },
  sources = {
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
    { name = 'buffer' },
    { name = 'path', option = {
         trailing_slash = true,
      }},
  },
}

---- CUSTOM CODE
--
-- Highlight on yank
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = '*',
})

-- makes it remember the fold state and location in file
vim.api.nvim_exec([[
augroup remember_folds
  autocmd!
  " view files are about 500 bytes
  " bufleave but not bufwinleave captures closing 2nd tab
  " nested is needed by bufwrite* (if triggered via other autocmd)
  " BufHidden for compatibility with `set hidden`
  autocmd BufWinLeave,BufLeave,BufWritePost,BufHidden,QuitPre ?* nested silent! mkview!
  autocmd BufWinEnter ?* silent! loadview
augroup END
]], false)

-- makes return highlight word under curser
vim.api.nvim_exec([[
let g:highlighting = 0
function! Highlighting()
  if g:highlighting == 1 && @/ =~ '^\\<'.expand('<cword>').'\\>$'
    let g:highlighting = 0
    return ":silent nohlsearch\<CR>"
  endif
  let @/ = '\<'.expand('<cword>').'\>'
  let g:highlighting = 1
  return ":silent set hlsearch\<CR>"
endfunction
nnoremap <silent> <expr> <CR> Highlighting()
]], false)

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
