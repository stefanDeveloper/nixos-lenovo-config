{
  description = "NixOS configuration with flakes";
  inputs.nixos-hardware.url = github:NixOS/nixos-hardware/master;
  
  inputs = {
    home-manager.url = "github:nix-community/home-manager";

  };
  
  outputs = { self, nixpkgs, nixos-hardware }: {
    # replace <your-hostname> with your actual hostname
    nixosConfigurations.nixos-stefan = nixpkgs.lib.nixosSystem {
      # ...
      modules = [
        # ...
        # add your model from this list: https://github.com/NixOS/nixos-hardware/blob/master/flake.nix
        nixos-hardware.lenovo.thinkpad.t14.amd.gen1
      ];
    };
  };

}