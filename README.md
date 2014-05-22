### Setup

1. Clone this repo

    ```bash
    cd ~
    git clone git@github.com:ryankuczka/dotfiles.git
    ```

1. Symlink files from `~/dotfiles/filename` to `~/.filename`

    ```bash
    ./dotfiles/create_symlinks.sh
    ```

1. Install vim plugins

    ```bash
    vim +PluginInstall +qall
    ```

1. Compile a few vim plugins

    ```bash
    cd ~/dotfiles/vim/bundle/YouCompleteMe
    ./install.sh
    cd ~/dotfiles/vim/bundle/ctrlp-cmatcher
    env CFLAGS=-Qunused-arguments CPPFLAGS=-Qunused-arguments ./install.sh
    ```
