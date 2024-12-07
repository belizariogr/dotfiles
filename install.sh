cd

sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

cd $(dirname $0)

./restore.sh


sh -c "$(curl -L https://nixos.org/nix/install)"

nix run nix-darwin -- switch --flake ~/.nix/flake.nix#belizario

./build-nix-mac.sh