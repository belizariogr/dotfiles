cd $(dirname $0)

mkdir -p .config

cp -f $HOME/.zshrc .
cp -f $HOME/.gitconfig .

mkdir -p .oh-my-zsh/themes/
cp -f $HOME/.oh-my-zsh/themes/belizario.zsh-theme ./.oh-my-zsh/themes/
cp -rf $HOME/.config/nix ./.config

PLATFORM="$(uname -o)-$(uname -m)"
if [ $PLATFORM == 'Darwin-arm64' ]; then

    mkdir -p "mac/Library/Preferences"
    mkdir -p "mac/Library/Application Support/Sublime Text/Packages/User/"

    cp -f $HOME/Library/Preferences/com.pilotmoon.scroll-reverser.plist \
        mac/Library/Preferences/
    cp -f $HOME/Library/Preferences/com.colliderli.iina.plist \
        mac/Library/Preferences/
    cp -f $HOME/Library/Application\ Support/Sublime\ Text/Packages/User/Preferences.sublime-settings \
        mac/Library/Application\ Support/Sublime\ Text/Packages/User/
    cp -f $HOME/.zprofile \
        mac/

fi