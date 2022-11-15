{
  description = "NixOS configuration with flakes";

  inputs = {
    home-manager.url = "github:nix-community/home-manager/release-22.05";

    # NixOS profiles covering hardware quirks:
    # https://github.com/NixOS/nixos-hardware
    nixos-hardware = {
      type = "github";
      owner = "NixOS";
      repo = "nixos-hardware";
      flake = false;
    };

    nix-zsh-completions = {
      type = "github";
      owner = "spwhitt";
      repo = "nix-zsh-completions";
      flake = false;
    };

    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    nixpkgs.url = "github:NixOS/nixpkgs/nixos-22.05";

    # Nix-flakes deployment tool
    deploy-rs.url = "github:serokell/deploy-rs";

    nixpkgs-fmt = {
      url = "github:nix-community/nixpkgs-fmt";
      flake = false;
    };

    nixos-artwork = {
      type = "github";
      owner = "nixos";
      repo = "artwork";
      flake = false;
    };

    gpg-config = {
      url = "github:stefanDeveloper/gpg-conf";
      flake = false;
    };

    mail-signature = {
      url = "git+ssh://git@github.com/stefanDeveloper/mail-signature.git";
      flake = false;
    };

    # A few Nix expressions suitable for inclusion in Nix User Repository
    rycee = {
      url = "gitlab:rycee/nur-expressions";
      flake = false;
    };

    # NUR community for FireFox, and other apps
    nur.url = github:nix-community/NUR;
  };

  outputs = { nixpkgs, nixpkgs-unstable, nix, self, deploy-rs, nur, home-manager, nixpkgs-fmt, mail-signature, ... } @ inputs: {
    nixosModules = import ./modules;
    nixosProfiles = import ./profiles;

    nixosConfigurations = with nixpkgs.lib;
      let
        hosts = builtins.attrNames (builtins.readDir ./hosts);
        mkHost = name:
          nixosSystem {
            system = removeSuffix "\n" (builtins.readFile (./hosts + "/${name}/system"));
            modules =
              let
                defaults = { pkgs, ... }: {
                  _module.args.nixpkgs-unstable = import inputs.nixpkgs-unstable { inherit (pkgs.stdenv.targetPlatform) system; };
                };
              in
              [
                defaults
                (import (./hosts + "/${name}"))
                { nixpkgs.overlays = [ nur.overlay ]; }
              ];
            specialArgs = { inherit inputs; };
          };
      in
      genAttrs hosts mkHost;

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
