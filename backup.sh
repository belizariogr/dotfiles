cd $(dirname $0)

cp -f ~/.zshrc .
cp -f ~/.zprofile .
cp -f ~/.gitconfig .

mkdir -p .oh-my-zsh/themes/
cp -f ~/.oh-my-zsh/themes/belizario.zsh-theme ./.oh-my-zsh/themes/

cp -rf ~/.nix .