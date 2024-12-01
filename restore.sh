cd $(dirname $0)

cp -f .zshrc $HOME/
cp -f .gitconfig $HOME/
cp -rf .oh-my-zsh $HOME/

mkdir -p $HOME/.config/
cp -rf .config/nix $HOME/.config/


PLATFORM="$(uname -o)-$(uname -m)"
mkdir -p $HOME/.nix
if [ $PLATFORM == 'Darwin-arm64' ]; then
    cp -rf .nix-mac/flake.nix $HOME/.nix

    # Restore Apps Preferences
    mkdir -p "$HOME/Library/Preferences/"
    mkdir -p "$HOME/Library/Application Support/Sublime Text/Packages/User/"

    cp -f ./mac/Library/Preferences/com.pilotmoon.scroll-reverser.plist \
        $HOME/Library/Preferences/
    cp -f ./mac/Library/Preferences/com.colliderli.iina.plist \
        $HOME/Library/Preferences/
    cp -f ./mac/Library/Application\ Support/Sublime\ Text/Packages/User/Preferences.sublime-settings \
        $HOME/Library/Application\ Support/Sublime\ Text/Packages/User/
    cp -f ./mac/.zprofile \
        $HOME


fi
