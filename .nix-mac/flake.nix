{
    description = "Belizário nix-darwin system flake";

    inputs = {
        nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
        nix-darwin.url = "github:LnL7/nix-darwin";
        nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
        nix-homebrew.url = "github:zhaofengli-wip/nix-homebrew";
    };

    outputs = inputs@{ self, nix-darwin, nixpkgs, nix-homebrew }:
    let
        configuration = { pkgs, config, ... }: {

            nixpkgs.config.allowUnfree = true;

            environment.systemPackages = [
                pkgs.mkalias
                pkgs.vscode
                pkgs.docker
                pkgs.nodejs_20
                pkgs.google-chrome
                pkgs.redis
            ];

            homebrew = {
                enable = true;

                brews = [
                    "mas"
                    "zsh-syntax-highlighting"
                ];

                casks = [
                    "sublime-text"
                    "iina"
                    "the-unarchiver"
                    "scroll-reverser"
                    "iterm2"
                ];

                masApps = {
                    "Action" = 1322446807;
                    "Proton Pass For Safari" = 6502835663;
                    "New Terminal Here" = 1067646949;
                    "WhatsApp" = 310633997;
                    "xcode" = 497799835;
                };

                onActivation.cleanup = "zap";
                onActivation.autoUpdate = true;
                onActivation.upgrade = true;
            };

            # Fonts
            fonts.packages = [
                pkgs.fira-code
                pkgs.nerd-fonts.jetbrains-mono
            ];

            system.activationScripts.applications.text = let
            env = pkgs.buildEnv {
                name = "system-applications";
                paths = config.environment.systemPackages;
                pathsToLink = "/Applications";
            };

        in
            pkgs.lib.mkForce ''
               
            '';

            system.defaults = {
                # GlobalPreferences = {
                #     # "com.apple.mouse.scaling" = -1.0
                # };

                NSGlobalDomain = {
                    AppleICUForce24HourTime = true;
                    AppleInterfaceStyle = "Dark";
                    AppleInterfaceStyleSwitchesAutomatically = false;
                    AppleSpacesSwitchOnActivate = true;
                    KeyRepeat = 2;
                };

                trackpad.Clicking = true;

                controlcenter = {
                    BatteryShowPercentage = true;
                    Sound = true;
                };

                dock = {
                    mineffect = "scale";
                    minimize-to-application = true;
                    show-recents = false;
                    # persistent-apps = [ ];
                    # persistent-others = [];
                    tilesize = 48;
                };

                finder = {
                    FXPreferredViewStyle = "Nlsv";
                    NewWindowTarget = "Home";
                    ShowHardDrivesOnDesktop = true;
                    ShowMountedServersOnDesktop = true;
                    ShowPathbar = true;
                    _FXSortFoldersFirst = true;
                };

                loginwindow = {
                    GuestEnabled = false;
                };
            };

            networking = {
                knownNetworkServices = [
                    "Wi-Fi"
                    "Ethernet Adaptor"
                    "Thunderbolt Ethernet"
                ];
                dns = [
                    "1.1.1.1"
                    "8.8.8.8"
                    "8.8.4.4"
                ];
            };

            services.redis.enable = true;

            # Necessary for using flakes on this system.
            nix.settings.experimental-features = "nix-command flakes";

            # Enable alternative shell support in nix-darwin.
            # programs.fish.enable = true;

            # Set Git commit hash for darwin-version.
            system.configurationRevision = self.rev or self.dirtyRev or null;

            # Used for backwards compatibility, please read the changelog before changing.
            # $ darwin-rebuild changelog
            system.stateVersion = 5;

            # The platform the configuration will be used on.
            nixpkgs.hostPlatform = "aarch64-darwin";
        };
    in {
        # Build darwin flake using:
        # $ darwin-rebuild build --flake .#simple
        darwinConfigurations."belizario" = nix-darwin.lib.darwinSystem {
            modules = [
                configuration
                nix-homebrew.darwinModules.nix-homebrew  {
                    nix-homebrew = {
                        # Install Homebrew under the default prefix
                        enable = true;

                        # Apple Silicon Only: Also install Homebrew under the default Intel prefix for Rosetta 2
                        enableRosetta = true;

                        # User owning the Homebrew prefix
                        user = "belizario";
                    };
                }
            ];
        };

        # Expose the package set
        darwinPackages = self.darwinConfigurations."belizario".pkgs;
    };
}
