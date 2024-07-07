let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin()
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/cmp-nvim-lua'
Plug 'hrsh7th/cmp-calc'
Plug 'hrsh7th/cmp-nvim-lsp-signature-help'
Plug 'hrsh7th/cmp-nvim-lsp-document-symbol'
Plug 'hrsh7th/nvim-cmp'
Plug 'emilienlemaire/clang-tidy.nvim'
Plug 'nvim-tree/nvim-web-devicons'
Plug 'nvim-tree/nvim-tree.lua'
Plug 'nvim-lua/plenary.nvim'
Plug 'akinsho/toggleterm.nvim'
Plug 'nvim-telescope/telescope.nvim/'
Plug 'jedrzejboczar/toggletasks.nvim'
Plug 'skywind3000/vim-quickui'
Plug 'sidebar-nvim/sidebar.nvim'
Plug 'akinsho/bufferline.nvim', { 'tag': '*' }
Plug 'habamax/vim-godot'
Plug 'CRAG666/code_runner.nvim'
Plug 'jghauser/mkdir.nvim'
Plug 'alec-gibson/nvim-tetris'
Plug 'startup-nvim/startup.nvim'
Plug 'Shatur/neovim-session-manager'
Plug 'nvim-telescope/telescope-ui-select.nvim'
Plug 'neovim/nvim-lspconfig'
Plug 'nvim-lualine/lualine.nvim'
Plug 'simrat39/symbols-outline.nvim'
Plug 'MunifTanjim/nui.nvim'
Plug 'Mythos-404/xmake.nvim', {'branch': 'v1'}
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'qwfy/doc-browser-nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'famiu/bufdelete.nvim'
Plug 'theHamsta/nvim_rocks', {'do': 'pip3 install --user --break-system-packages hererocks && python3 -mhererocks . -j2.1.0-beta3 -r3.0.0 && cp nvim_rocks.lua lua'}
Plug 'mfussenegger/nvim-dap'
Plug 'rcarriga/nvim-dap-ui'
Plug 'QuickGD/quickgd.nvim'
Plug 'williamboman/mason.nvim'
Plug 'williamboman/mason-lspconfig.nvim'
Plug 'echasnovski/mini.clue',
Plug 'ellisonleao/glow.nvim'
Plug 'linux-cultist/venv-selector.nvim', {'branch': 'regexp' }
Plug 'lukas-reineke/headlines.nvim'
Plug 'nvim-neotest/nvim-nio'
Plug 'lewis6991/gitsigns.nvim'
call plug#end()
