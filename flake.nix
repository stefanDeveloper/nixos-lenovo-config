{
  description = "NixOS configuration with flakes";

  inputs = {
    home-manager.url = "github:nix-community/home-manager/release-23.05";

    # NixOS profiles covering hardware quirks:
    # https://github.com/NixOS/nixos-hardware
    nixos-hardware = {
      type = "github";
      owner = "NixOS";
      repo = "nixos-hardware";
      flake = false;
    };

    # Zsh completion
    nix-zsh-completions = {
      type = "github";
      owner = "spwhitt";
      repo = "nix-zsh-completions";
      flake = false;
    };

    # nixpkgs versions
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.05";
    nixpkgs-old.url = "github:NixOS/nixpkgs/nixos-23.05";

    # Nix formatter
    nixpkgs-fmt = {
      url = "github:nix-community/nixpkgs-fmt";
      flake = false;
    };

    # NixOS Artwork for background
    nixos-artwork = {
      type = "github";
      owner = "nixos";
      repo = "artwork";
      flake = false;
    };

    # Personal config
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

    # NixOS Generator for vBox, ISO, ... images
    nixos-generators = {
      url = "github:nix-community/nixos-generators";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # NUR community for FireFox, and other apps
    nur.url = github:nix-community/NUR;
  };

  outputs = { nixpkgs, nixpkgs-unstable, nixpkgs-old, self, nur, home-manager, nixpkgs-fmt, mail-signature, nixos-artwork, nixos-generators, ... } @ inputs: {
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
                  _module.args.nixpkgs-old = import inputs.nixpkgs-old { inherit (pkgs.stdenv.targetPlatform) system; };
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
    
    # For vBox, ISO and VMWare generation
    packages.x86_64-linux = {
      iso = nixos-generators.nixosGenerate {
        system = "x86_64-linux";

        customFormats = {
          install-iso-minimal = {
            imports = [
              "${nixpkgs}/nixos/modules/installer/cd-dvd/installation-cd-minimal.nix"
            ];

            systemd.services.sshd.wantedBy = nixpkgs.lib.mkForce ["multi-user.target"];

            isoImage.squashfsCompression = "zstd -Xcompression-level 3";
            
            # EFI booting
            isoImage.makeEfiBootable = true;

            # USB booting
            isoImage.makeUsbBootable = true;

            formatAttr = "isoImage";
            fileExtension = "*.iso";
          };
        };
        format = "install-iso-minimal";

        modules =
          let
            defaults = { pkgs, ... }: {
              _module.args.nixpkgs-unstable = import inputs.nixpkgs-unstable { inherit (pkgs.stdenv.targetPlatform) system; };
              _module.args.nixpkgs-old = import inputs.nixpkgs-old { inherit (pkgs.stdenv.targetPlatform) system; };
            };
          in
          [
            defaults
            { nixpkgs.overlays = [ nur.overlay ]; }
            inputs.self.nixosProfiles.vm-i3
          ];
        specialArgs = { inherit inputs; };

      };
      vm = nixos-generators.nixosGenerate {
        system = "x86_64-linux";
        format = "vm";
        modules =
          let
            defaults = { pkgs, ... }: {
              _module.args.nixpkgs-unstable = import inputs.nixpkgs-unstable { inherit (pkgs.stdenv.targetPlatform) system; };
              _module.args.nixpkgs-old = import inputs.nixpkgs-old { inherit (pkgs.stdenv.targetPlatform) system; };
            };
          in
          [
            defaults
            { nixpkgs.overlays = [ nur.overlay ]; }
            inputs.self.nixosProfiles.vm-sway
          ];
        specialArgs = { inherit inputs; };

      };
    };
  };
}
