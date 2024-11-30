cd $(dirname $0)

cp -f .zshrc ~/
cp -f .zprofile ~/
cp -f .gitconfig ~/
cp -rf .oh-my-zsh ~/

PLATFORM="$(uname -o)-$(uname -m)"

mkdir -p ~/.nix
if [ $PLATFORM == 'Darwin-arm64' ]; then
    cp -rf .nix-mac/flake.nix ~/.nix
fi
