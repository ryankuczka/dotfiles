# Setup

## Clone The Repo

```bash
# Make /repos directory
sudo mkdir /repos
sudo chown ryan:staff /repos
cd /repos

# Clone it!
git clone git@github.com:ryankuczka/dotfiles.git
```

## Install Necessary Programs
Install these programs first:
- [slate](https://github.com/jigish/slate)
- [homebrew](http://brew.sh/)
- [USB Overdrive](http://www.usboverdrive.com/USBOverdrive/News.html)

Use homebrew to install:

```bash
# Updated programs
brew install python
brew install python3
brew install git
brew install curl

# New programs
brew install tmux
brew install reattach-to-user-namespace
brew install tree
brew install the_silver_searcher
brew install wget
brew install watch
brew install youtube-dl
brew install ctags

# Vim/Neovim
brew install vim
brew install macvim
brew tap neovim/homebrew-neovim
brew install neovim --HEAD

# Zsh
brew install zsh
# Then add /usr/local/bin/zsh to the end of /etc/shells and run:
chsh -s /usr/local/bin/zsh
```

## Symlink Files

```bash
# Vim Stuff
ln -sfv /repos/dotfiles/vim ~/.vim
ln -sfv /repos/dotfiles/vim ~/.nvim
ln -sfv /repos/dotfiles/vim/vimrc ~/.nvimrc

# Git Stuff
ln -sfv /repos/dotfiles/git/git_template ~/.git_template
ln -sfv /repos/dotfiles/git/gitconfig ~/.gitconfig
ln -sfv /repos/dotfiles/git/gitignore ~/.gitignore

# Zsh Stuff
ln -sfv /repos/dotfiles/zsh/fzf ~/.fzf
ln -sfv /repos/dotfiles/zsh/zshrc ~/.zshrc

# Miscellaneous
ln -sfv /repos/dotfiles/misc/agignore ~/.agignore
ln -sfv /repos/dotfiles/misc/slate.js ~/.slate.js
ln -sfv /repos/dotfiles/tmux/tmux.conf ~/.tmux.conf
```

## Install Vim Plugins
```bash
vim +PlugInstall +qall

# Compile YouCompleteMe
cd ~/.vim/plugged/YouCompleteMe
./install.sh

# Compile CtrlP-Cmatcher
cd ~/.vim/plugged/ctrlp-cmatcher
env CFLAGS=-Qunused-arguments CPPFLAGS=-Qunused-arguments ./install.sh
```
