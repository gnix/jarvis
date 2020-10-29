#!/bin/sh


INSTALLDIR=$PWD
ZSH_CUSTOM=$HOME/.oh-my-zsh/custom


echo "---------------------------------------------------------"
echo "$(tput setaf 2)JARVIS: Greetings. Preparing to power up and begin diagnostics.$(tput sgr 0)"
echo "---------------------------------------------------------"



echo "---------------------------------------------------------"
echo "$(tput setaf 2)JARVIS: Installing system packages.$(tput sgr 0)"
echo "---------------------------------------------------------"

packages=(
  "curl"
  "nodejs"
  "npm"
  "powerline"
  "fonts-powerline"
  "ruby"
  "ruby-dev"
  "ruby-colorize"
  "tmux"
  "neovim"
  "python3-pip"
  "zsh"
  "ripgrep"
  "fzf"
  "ctags"
)

sudo apt update
for i in "${packages[@]}"
do
  sudo apt install $i -y
  echo "---------------------------------------------------------"
done



echo "---------------------------------------------------------"
echo "$(tput setaf 2)JARVIS: Installing Python packages.$(tput sgr 0)"
echo "---------------------------------------------------------"

packages=(
  "neovim"     # Python Neovim client
  "vim-vint"   # vim linter (vint)
  "yapf"       # Google's YAPF linter
  "pylint"     # PyLint
  "jedi"       # Jedi
)

for i in "${packages[@]}"
do
  pip3 install $i
  echo "---------------------------------------------------------"
done



echo "---------------------------------------------------------"
echo "$(tput setaf 2)JARVIS: Installing npm packages.$(tput sgr 0)"
echo "---------------------------------------------------------"

packages=(
  "neovim"                  # NodeJS client API for Neovim
  "bash-language-server"    # bash language server
  "vtop"
)

for i in "${packages[@]}"
do
  sudo npm install -g $i
  echo "---------------------------------------------------------"
done



echo "---------------------------------------------------------"
echo "$(tput setaf 2)JARVIS: Backing up old Neovim, ZSH, and tmux config files (Backup dir=$BACKUP_DIR).$(tput sgr 0)"
echo "---------------------------------------------------------"

BACKUP_DIR=$INSTALLDIR/backup
mkdir -p $BACKUP_DIR

files=("$HOME/.config/nvim" "$HOME/.zshrc" "$HOME/.tmux.conf")
for filename in "${files[@]}"; do
    if [ -f $filename -o -d $filename ]; then
      echo "---------------------------------------------------------"
      echo "$(tput setaf 2)JARVIS: Backing up $filename.$(tput sgr 0)"
      echo "---------------------------------------------------------"
      mv $filename $BACKUP_DIR 2>/dev/null
	else
      echo "---------------------------------------------------------"
      echo -e "$(tput setaf 3)JARVIS: $filename does not exist at this location or is a symlink.$(tput sgr 0)"
      echo "---------------------------------------------------------"
    fi
done

echo "---------------------------------------------------------"
echo "$(tput setaf 2)JARVIS: Backup completed.$(tput sgr 0)"
echo "---------------------------------------------------------"



echo "---------------------------------------------------------"
echo "$(tput setaf 2)JARVIS: Installing Z (https://github.com/rupa/z).$(tput sgr 0)"
echo "---------------------------------------------------------"

wget https://raw.githubusercontent.com/rupa/z/master/z.sh
chmod 775 z.sh
sudo mv z.sh /usr/local/bin

# Attention: If you change the z.sh location, you need to update the zshrc file as well.
source /usr/local/bin/z.sh




echo "---------------------------------------------------------"
echo "$(tput setaf 2)JARVIS: Installing colorls$(tput sgr 0)"
echo "---------------------------------------------------------"

sudo gem install colorls


echo "---------------------------------------------------------"
echo "$(tput setaf 2)JARVIS: Installing system fonts.$(tput sgr 0)"
echo "---------------------------------------------------------"

wget https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/Hack.zip
unzip Hack.zip -d ~/.fonts
fc-cache -fv
rm Hack.zip


# Create backup folder if it doesn't exist
mkdir -p ~/.local/share/nvim/backup

echo "---------------------------------------------------------"
echo "$(tput setaf 2)JARVIS: Installing oh-my-zsh.$(tput sgr 0)"
echo "---------------------------------------------------------"

if [ ! -d "$HOME/.oh-my-zsh" ]; then
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
else
  echo "---------------------------------------------------------"
  echo "$(tput setaf 2)JARVIS: oh-my-zsh already installed.$(tput sgr 0)"
  echo "---------------------------------------------------------"
fi



echo "---------------------------------------------------------"
echo "$(tput setaf 2)JARVIS: Installing spaceship prompt$(tput sgr 0)"
echo "---------------------------------------------------------"

git clone https://github.com/denysdovhan/spaceship-prompt.git "$ZSH_CUSTOM/themes/spaceship-prompt"
ln -s "$ZSH_CUSTOM/themes/spaceship-prompt/spaceship.zsh-theme" "$ZSH_CUSTOM/themes/spaceship.zsh-theme"



echo "---------------------------------------------------------"
echo "$(tput setaf 2)JARVIS: Installing zsh-autosuggestions.$(tput sgr 0)"
echo "---------------------------------------------------------"

git clone https://github.com/zsh-users/zsh-autosuggestions ~/.zsh/zsh-autosuggestions



echo "---------------------------------------------------------"
echo "$(tput setaf 2)JARVIS: Linking symlink files.$(tput sgr 0)"
echo "---------------------------------------------------------"

linkables=$( find -H "$INSTALLDIR" -maxdepth 3 -name '*.symlink' )
for file in $linkables ; do
  target="$HOME/.$( basename $file '.symlink' )"
  if [ -e $target ]; then
    echo "---------------------------------------------------------"
    echo "$(tput setaf 3)JARVIS: ~${target#$HOME} already exists... Skipping.$(tput sgr 0)"
    echo "---------------------------------------------------------"
  else
    echo "---------------------------------------------------------"
    echo "$(tput setaf 2)JARVIS: Creating symlink for $file.$(tput sgr 0)"
    echo "---------------------------------------------------------"
    ln -s $file $target
  fi
done



echo "---------------------------------------------------------"
echo "$(tput setaf 2)JARVIS: Installing config files.$(tput sgr 0)"
echo "---------------------------------------------------------"

if [ ! -d $HOME/.config ]; then
    echo "Creating ~/.config"
    mkdir -p $HOME/.config
fi

for config in $INSTALLDIR/config/*; do
  target=$HOME/.config/$( basename $config )
  if [ -e $target ]; then
    echo "---------------------------------------------------------"
    echo "$(tput setaf 3)JARVIS: ~${target#$HOME} already exists... Skipping.$(tput sgr 0)"
    echo "---------------------------------------------------------"
  else
    echo "---------------------------------------------------------"
    echo "$(tput setaf 2)JARVIS: Creating symlink for ${config}.$(tput sgr 0)"
    echo "---------------------------------------------------------"
    ln -s $config $target
  fi
done



echo "---------------------------------------------------------"
echo "$(tput setaf 2)JARVIS: Installing Neovim plugins and linking dotfiles.$(tput sgr 0)"
echo "---------------------------------------------------------"

nvim +PlugInstall +qall
nvim +UpdateRemotePlugins +qall



echo "---------------------------------------------------------"
echo "$(tput setaf 2)JARVIS: Installing Space vim-airline theme.$(tput sgr 0)"
echo "---------------------------------------------------------"

cp ~/.config/nvim/space.vim ~/.config/nvim/autoload/plugged/vim-airline-themes/autoload/airline/themes/space.vim



echo "---------------------------------------------------------"
echo "$(tput setaf 2)JARVIS: Installing tmux plugin manager.$(tput sgr 0)"
echo "---------------------------------------------------------"

if [ ! -d "$HOME/.tmux/plugins/tpm" ]; then
  git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
  ~/.tmux/plugins/tpm/scripts/install_plugins.sh
fi



echo "---------------------------------------------------------"
echo "$(tput setaf 2)JARVIS: Switching shell to zsh. You may need to logout.$(tput sgr 0)"
echo "---------------------------------------------------------"

# sudo sh -c "echo $(which zsh) >> /etc/shells"
chsh -s $(which zsh)



echo "---------------------------------------------------------"
echo "$(tput setaf 2)JARVIS: System update complete. Enjoy!$(tput sgr 0)"
echo "---------------------------------------------------------"

exit 0

