nvm install node
cd $HOME

git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

git clone --depth=1 https://github.com/romkatv/powerlevel10k.git $HOME/.oh-my-zsh/themes/powerlevel10k

git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install

cd ~/.oh-my-zsh/custom/plugins
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git

cp $HOME/Projects/usr-local-bin/.zshrc $HOME/.zshrc

brew install nvm
mkdir ~/.nvm

echo "export NVM_DIR=~/.nvm\nsource \$(brew --prefix nvm)/nvm.sh" >> .zshrc
source ~/.zshrc

brew install node

brew install 

