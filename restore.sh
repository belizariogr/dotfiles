cd $(dirname $0)

rm -rf $HOME/.zshrc
rm -rf $HOME/.gitconfig
rm -rf $HOME/.oh-my-zsh/themes/belizaro.zsh-theme
rm -rf $HOME/.config

ln -s $PWD/.zshrc $HOME/.zshrc
ln -s $PWD/.gitconfig $HOME/.gitconfig

rm -rf $HOME/.oh-my-zsh/themes/belizario.zsh-theme
ln -s $PWD/.oh-my-zsh/themes/belizario.zsh-theme $HOME/.oh-my-zsh/themes/belizario.zsh-theme

ln -s $PWD/.config $HOME/.config 

PLATFORM="$(uname -o)-$(uname -m)"
if [ $PLATFORM == 'Darwin-arm64' ]; then
    
    # Restore Apps Preferences
    mkdir -p "$HOME/Library/Preferences/"
    mkdir -p "$HOME/Library/Application Support/Sublime Text/Packages/User/"

    # Sublime Text
    cp -f $PWD/.config/sublime/config.json "$HOME/Library/Application Support/Sublime Text/Packages/User/Preferences.sublime-settings"

    # Scroll Reverser
    rm -rf $HOME/Library/Preferences/com.pilotmoon.scroll-reverser.plist
    ln -s $PWD/mac/Library/Preferences/com.pilotmoon.scroll-reverser.plist \
        $HOME/Library/Preferences/com.pilotmoon.scroll-reverser.plist

    # IINA
    rm -rf $HOME/Library/Preferences/com.colliderli.iina.plist
    ln -s $PWD/mac/Library/Preferences/com.colliderli.iina.plist \
        $HOME/Library/Preferences/com.colliderli.iina.plist

fi

rm -rf $HOME/Library/Application\ Scripts/com.mac-application.ActionApp
mkdir -p $HOME/Library/Application\ Scripts/com.mac-application.ActionApp
cp -rf $HOME/Library/Mobile\ Documents/com\~apple\~Automator/Documents/* $HOME/Library/Application\ Scripts/com.mac-application.ActionApp