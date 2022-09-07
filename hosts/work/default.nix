{ inputs, ... }: {
  imports = with inputs.self.nixosModules; [
    ./hardware
    ./network.nix
    inputs.self.nixosProfiles.desktop-sway
  ];
}
