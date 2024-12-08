{
    description = "Belizário nix-darwin system flake";

    inputs = {
        nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
        nix-darwin.url = "github:LnL7/nix-darwin";
        nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
        nix-homebrew.url = "github:zhaofengli-wip/nix-homebrew";

        homebrew-bundle = {
            url = "github:homebrew/homebrew-bundle";
            flake = false;
        };
        homebrew-core = {
            url = "github:homebrew/homebrew-core";
            flake = false;
        };
        homebrew-cask = {
            url = "github:homebrew/homebrew-cask";
            flake = false;
        };
        homebrew-services = {
            url = "github:homebrew/homebrew-services";
            flake = false;
        };
    };

    outputs = inputs@{ 
        self, nix-darwin, nixpkgs, 
        nix-homebrew,
        homebrew-bundle,
        homebrew-core,
        homebrew-cask,
        homebrew-services
    }:
    let
        user = "belizario";
        platform = "aarch64-darwin";

        configuration = { 
            pkgs, config, 
            nix-homebrew,
            homebrew-bundle,
            homebrew-core,
            homebrew-cask,
            homebrew-services,
            ... 
        }: {
            nixpkgs.config.allowUnfree = true;

            environment.systemPackages = [
                pkgs.mkalias
                pkgs.vscode
                pkgs.nodejs_20
                pkgs.google-chrome
            ];

            homebrew = {
                enable = true;

                brews = [
                    "mas"
                    "zsh-syntax-highlighting"
                    {
                        name = "mariadb@11.4";
                        link = true;
                        start_service = true;
                        conflicts_with = [ 
                            "mysql" 
                            "mariadb"
                        ];
                    }
                    {
                        name = "redis";
                        start_service = true;
                    } 
                ];

                casks = [
                    "sublime-text"
                    "iina"
                    "the-unarchiver"
                    "scroll-reverser"
                    "iterm2"
                    "docker"
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
                /opt/homebrew/opt/mariadb@11.4/bin/mariadb-admin password Jdfl4mr-Kdhe7++
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
                    InitialKeyRepeat = 15;
                    "com.apple.keyboard.fnState" = true;
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
                    persistent-apps = [ 
                        "/System/Applications/Launchpad.app"
                        "/${pkgs.google-chrome}/Applications/Google Chrome.app"   
                        "/System/Cryptexes/App/System/Applications/Safari.app"   
                        "/Applications/WhatsApp.app"   
                        "/System/Applications/Mail.app"   
                        "${pkgs.vscode}/Applications/Visual Studio Code.app"   
                        "/Applications/Navicat Premium Lite.app"   
                        "/Applications/GitHub Desktop.app"   
                        "/System/Applications/App Store.app"   
                        "/System/Applications/System Settings.app"
                        "/Applications/iTerm.app"
                    ];
                    persistent-others = [
                        "/Users/${user}/Downloads"
                    ];
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
            nixpkgs.hostPlatform = "${platform}";
        };

        homebrew-services-patched = nixpkgs.legacyPackages."${platform}".applyPatches {
            name = "homebrew-services-patched";
            src = homebrew-services;
            patches = [ ./homebrew-services.patch ];
        };
    in {
        # Build darwin flake using:
        # $ darwin-rebuild build --flake .#simple
        

        darwinConfigurations."belizario" = nix-darwin.lib.darwinSystem {
            modules = [
                (
                    { config, ... }:
                    {
                        homebrew.taps = builtins.attrNames config.nix-homebrew.taps;
                    }
                )
                configuration
                nix-homebrew.darwinModules.nix-homebrew  {
                    nix-homebrew = {
                        # Install Homebrew under the default prefix
                        enable = true;

                        # Apple Silicon Only: Also install Homebrew under the default Intel prefix for Rosetta 2
                        enableRosetta = true;

                        # User owning the Homebrew prefix
                        user = "${user}";

                        taps = {
                            "homebrew/homebrew-bundle" = homebrew-bundle;
                            "homebrew/homebrew-core" = homebrew-core;
                            "homebrew/homebrew-cask" = homebrew-cask;
                            "homebrew/homebrew-services" = homebrew-services-patched;
                        };
                        
                        mutableTaps = false;
                    };
                }
            ];
        };

        # Expose the package set
        darwinPackages = self.darwinConfigurations."belizario".pkgs;
    };
}