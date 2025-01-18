_user="$(whoami)"

############################################################################################## MOUSE

# Reduce the mouse speed
defaults write -g "com.apple.mouse.scaling" -float 0.5

# Remove mouse acceleration
defaults write -g "com.apple.mouse.linear" -bool true

# Enable tap to click
defaults write "com.apple.driver.AppleBluetoothMultitouch.trackpad" Clicking -bool true
defaults write "com.apple.AppleMultitouchTrackpad" Clicking -bool true
defaults -currentHost write -g com.apple.mouse.tapBehavior -int 1
defaults write -g com.apple.mouse.tapBehavior -int 1

# USB mouse stops trackpad
defaults write "com.apple.driver.AppleBluetoothMultitouch.trackpad" USBMouseStopsTrackpad -bool true
defaults write "com.apple.driver.AppleMultitouchTrackpad" USBMouseStopsTrackpad -bool true

############################################################################################## KEYBOARD

# Reduce the keyboard repeat delay
defaults write -g "KeyRepeat" -int 2

# Reduce the keyboard initial repeat rate
defaults write -g "InitialKeyRepeat" -int 15

# Enabled Function Keys
defaults write -g "com.apple.keyboard.fnState" -bool true

# Enabled Function Keys
defaults write com.apple.HIToolbox AppleFnUsageType -bool false

############################################################################################## SYSTEM UI

# Enable dark mode
defaults write -g "AppleInterfaceStyle" -string "Dark"

# Show battery percentage
sudo -u $_user defaults write /Users/$_user/Library/Preferences/ByHost/com.apple.controlcenter.plist BatteryShowPercentage -bool true

# Dock - Size
defaults write com.apple.dock tilesize -int 45

# Dock - minimize effect
defaults write com.apple.dock mineffect -string "scale"

# Dock - minimize to application
defaults write com.apple.dock minimize-to-application -bool true

# Dock - Show recent apps
defaults write com.apple.dock show-recents -bool false

# Hot corners
# Top left screen corner → Mission Control
defaults write com.apple.dock wvous-tl-corner -int 1
defaults write com.apple.dock wvous-tl-modifier -int 0

# Top right screen corner → Desktop
defaults write com.apple.dock wvous-tr-corner -int 1
defaults write com.apple.dock wvous-tr-modifier -int 0

# Bottom left screen corner → Start screen saver
defaults write com.apple.dock wvous-bl-corner -int 1
defaults write com.apple.dock wvous-bl-modifier -int 0

# Bottom right screen corner → Start screen saver
defaults write com.apple.dock wvous-br-corner -int 1
defaults write com.apple.dock wvous-br-modifier -int 0

############################################################################################## FINDER 

# Finder - View > as list
defaults write com.apple.finder FXPreferredViewStyle -string "nlsv"

# Finder - View > show path bar
defaults write com.apple.finder ShowPathbar -bool true

# Finder - View > show status bar
defaults write com.apple.finder ShowStatusBar -bool false

# Finder - New window on home
defaults write com.apple.finder NewWindowTarget -string "PfHm"

# Finder - Show external hard drives on desktop
defaults write com.apple.finder ShowExternalHardDrivesOnDesktop -bool true

# Finder - Show hard drives on desktop
defaults write com.apple.finder ShowHardDrivesOnDesktop -bool true

# Finder - Show mounted servers on desktop
defaults write com.apple.finder ShowMountedServersOnDesktop -bool true

# Finder - Show removable media on desktop
defaults write com.apple.finder ShowRemovableMediaOnDesktop -bool true

# Finder - Show folders first
defaults write com.apple.finder _FXSortFoldersFirst -bool true

# Finder - Show folders first on Desktop
defaults write com.apple.finder _FXSortFoldersFirstOnDesktop -bool true

# Show expaneded save panel by default
defaults write -g "NSNavPanelExpandedStateForSaveMode" -bool true

# Expand print panel by default
defaults write -g PMPrintingExpandedStateForPrint -bool true

# Enable snap-to-grid for desktop icons
/usr/libexec/PlistBuddy -c "Set :DesktopViewSettings:IconViewSettings:arrangeBy grid" ~/Library/Preferences/com.apple.finder.plist

############################################################################################## OTHERS

# Disable the "Are you sure you want to open this application?" dialog
defaults write com.apple.LaunchServices LSQuarantine -bool false

# Avoid creating .DS_Store files on network volumes
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true

# Terminal - Set columns to 120
/usr/libexec/PlistBuddy -c "Set :Window\ Settings:Basic:columnCount 110" ~/Library/Preferences/com.apple.terminal.plist
/usr/libexec/PlistBuddy -c "Set :Window\ Settings:Basic:rowCount 30" ~/Library/Preferences/com.apple.terminal.plist
/usr/libexec/PlistBuddy -c "Set :Window\ Settings:Basic:UseBrightBold 1" ~/Library/Preferences/com.apple.terminal.plist
/usr/libexec/PlistBuddy -c "Set :Window\ Settings:Basic:shellExitAction 0" ~/Library/Preferences/com.apple.terminal.plist
/usr/libexec/PlistBuddy -c "Set :Window\ Settings:Basic:warnOnShellCloseAction 0" ~/Library/Preferences/com.apple.terminal.plist

############################################################################################## APPLY CHANGES

killall SystemUIServer
killall Dock
killall Finder
pkill "Touch Bar agent"
pkill "Keyboard agent"
killall "ControlStrip"