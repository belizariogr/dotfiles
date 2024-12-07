cd $(dirname $0)
./restore.sh

sh <(curl -L https://nixos.org/nix/install)

./build-nix-mac.sh