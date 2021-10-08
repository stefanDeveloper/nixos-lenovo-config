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

  };
  
  outputs = { self, nixpkgs, ... }: {
    nixosModules = import ./system;

    nixosConfigurations = with nixpkgs.lib;
      let
        hosts = builtins.attrNames (builtins.readDir ./hosts);
        mkHost = name:
            nixosSystem {
              system = removeSuffix "\n" (builtins.readFile (./hosts + "/${name}/system"));
              modules = [(import (./hosts + "/${name}"))];
              specialArgs = { inherit inputs; };
            };
      in genAttrs hosts mkHost;
  };

}