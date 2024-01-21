if filereadable("./.nvim/local.vim")
    source ./.nvim/local.vim
endif

source $HOME/.config/nvim/plugins.vim
source $HOME/.config/nvim/config.vim

lua require("main-setup")
