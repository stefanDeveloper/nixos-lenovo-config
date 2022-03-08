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

    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    nixpkgs-21-11 = {
      type = "github";
      owner = "nixos";
      repo = "nixpkgs";
      ref = "nixos-21.11";
      flake = false;
    };

    #zsh-config = {
    #  type = "github";
    #  owner = "stefanDeveloper";
    #  repo = "zshrc";
    #  flake = false;
    #};
    
    #tpm = {
    #  type = "github";
    #  owner = "tmux-plugins";
    #  repo = "tpm";
    #  flake = false;
    #};

    #tmux-config = {
    #  type = "github";
    #  owner = "stefanDeveloper";
    #  repo = "tmux.conf";
    #  flake = false;
    #};

    # Nix-flakes deployment tool
    deploy-rs.url = "github:serokell/deploy-rs";

    nixos-artwork = {
      type = "github";
      owner = "nixos";
      repo = "artwork";
      flake = false;
    };
    nur.url = github:nix-community/NUR;

  };

  outputs = { nixpkgs, nix, self, deploy-rs, nur, ... }@inputs:  {
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

    #defaultApp = deploy-rs.defaultApp;

    #deploy = {
    #  user = "root";
    #  nodes.thinkpad = {
    #    hostname =
    #      self.nixosConfigurations.thinkpad.config.networking.hostName;
    #    profiles.system.path = deploy-rs.x86_64-linux.activate.nixos
    #      self.nixosConfigurations.thinkpad;
    #  };
    #};
  };

}