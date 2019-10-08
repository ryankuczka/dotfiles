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
- [homebrew](http://brew.sh/)
- [Input Mono Font](http://input.fontbureau.com/)

Use homebrew to install:

```bash
# Updated programs
brew install python
brew install python3
brew install git
brew install curl

# New programs
brew install node
brew install tmux
brew install reattach-to-user-namespace
brew install tree
brew install the_silver_searcher
brew install wget
brew install watch
brew install youtube-dl
brew install ctags
brew install direnv

# Vim/Neovim
brew install vim
brew tap neovim/neovim
brew install neovim

# Zsh
brew install zsh
# Then add /usr/local/bin/zsh to the end of /etc/shells and run:
chsh -s /usr/local/bin/zsh
```

## Symlink Files

```bash
# Vim Stuff
ln -sfv /repos/dotfiles/vim ~/.vim
ln -sfv /repos/dotfiles/vim ~/.config/nvim
ln -sfv /repos/dotfiles/vim/vimrc ~/.config/nvim/init.vim

# Git Stuff
ln -sfv /repos/dotfiles/git/git_template ~/.git_template
ln -sfv /repos/dotfiles/git/gitconfig ~/.gitconfig
ln -sfv /repos/dotfiles/git/gitignore ~/.gitignore

# Zsh Stuff
ln -sfv /repos/dotfiles/zsh/zshrc ~/.zshrc

# Miscellaneous
ln -sfv /repos/dotfiles/misc/agignore ~/.agignore
ln -sfv /repos/dotfiles/tmux/tmux.conf ~/.tmux.conf
ln -sfv /repos/dotfiles/misc/direnvrc ~/.direnvrc
ln -sfv /repos/dotfiles/misc/rgignore ~/.rgignore
```

## Install Vim Plugins
```bash
# Create neovim virtualenvs
pip install virtualenv virtualenvwrapper
mkvirtualenv neovim2
workon neovim2
pip install pynvim

mkvirtualenv -p python3 neovim
workon neovim
pip install pynvim

# Install vim preview markdown
npm install -g instant-markdown-d

# Install plugins
nvim +PlugInstall +qall
```

## Git Subtrees

```bash
# To update the subtrees in this repo
git subupd git@github.com:zsh-users/zsh-history-substring-search.git zsh/zsh-history-substring-search
git subupd git@github.com:zsh-users/zsh-syntax-highlighting.git zsh/zsh-syntax-highlighting
git subupd git@github.com:zsh-users/zsh-autosuggestions.git zsh/zsh-autosuggestions
```
