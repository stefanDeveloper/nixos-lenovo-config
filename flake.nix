{
  description = "NixOS configuration with flakes";
  
  inputs = {
    home-manager.url = "github:nix-community/home-manager";

    # NixOS profiles covering hardware quirks:
    # https://github.com/NixOS/nixos-hardware
    nixos-hardware = {
      type = "github";
      owner = "NixOS";
      repo = "nixos-hardware";
      flake = false;
    };

    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    nixpkgs.url = "github:NixOS/nixpkgs/nixos-22.05";

    kitty-themes = {
      type = "github";
      owner = "dexpota";
      repo = "kitty-themes";
      flake = false;
    };

    # Nix-flakes deployment tool
    deploy-rs.url = "github:serokell/deploy-rs";

    emacs-overlay = {
      url = "github:nix-community/emacs-overlay";
      flake = false;
    };

    nixpkgs-fmt = {
      url = "github:nix-community/nixpkgs-fmt";
      flake = false;
    };

    nix-doom-emacs = {
      url = "github:hlissner/doom-emacs";
      flake = false;
    };

    defaultencrypt = {
      url = "gitlab:lechten/defaultencrypt";
      flake = false;
    };

    doom-emacs-config = {
      url = "github:stefanDeveloper/.doom.d-conf";
      flake = false;
    };

    gpg-config = {
      url = "github:stefanDeveloper/gpg-conf";
      flake = false;
    };
    
    gnus-alias = {
      url = "github:altruizine/gnus-alias";
      flake = false;
    };
    
    nixos-artwork = {
      type = "github";
      owner = "nixos";
      repo = "artwork";
      flake = false;
    };

    # NUR community for FireFox, and other apps
    nur.url = github:nix-community/NUR;
  };

  outputs = { nixpkgs, nixpkgs-unstable, nix, self, deploy-rs, nur, nix-doom-emacs, home-manager, emacs-overlay, nixpkgs-fmt, defaultencrypt, doom-emacs-config, gpg-config, gnus-alias, ... } @ inputs:  {
    nixosModules = import ./modules;
    nixosProfiles = import ./profiles;

    nixosConfigurations = with nixpkgs.lib;
      let
        hosts = builtins.attrNames (builtins.readDir ./hosts);
        mkHost = name:
            nixosSystem {
              system = removeSuffix "\n" (builtins.readFile (./hosts + "/${name}/system"));
              modules = [
                (import (./hosts + "/${name}"))
                { nixpkgs.overlays = [ nur.overlay ]; }
              ];
              specialArgs = { inherit inputs; };
            };
      in genAttrs hosts mkHost;

    legacyPackages.x86_64-linux =
      (builtins.head (builtins.attrValues self.nixosConfigurations)).pkgs;

    defaultApp = deploy-rs.defaultApp;

    deploy = {
      user = "root";
      nodes.stefan = {
        hostname = self.nixosConfigurations.stefan.config.networking.hostName;
        profiles.system.path = deploy-rs.x86_64-linux.activate.nixos self.nixosConfigurations.stefan;
      };

      nodes.work = {
        hostname = self.nixosConfigurations.work.config.networking.hostName;
        profiles.system.path = deploy-rs.x86_64-linux.activate.nixos self.nixosConfigurations.work;
      };
    };
  };
}