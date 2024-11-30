cd
sh <(curl -L https://nixos.org/nix/install)
mkdir .nix
cd .nix
nix flake init -t nix-darwin --extra-experimental-features "nix-command flakes"
nix run nix-darwin --extra-experimental-features "nix-command flakes" -- switch --flake ~/.nix#belizario
darwin-rebuild switch --flake ~/.nix#belizario