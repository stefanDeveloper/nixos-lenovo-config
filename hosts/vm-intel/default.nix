{ inputs, ... }: {
  imports = with inputs.self.nixosModules; [
    ./hardware
    ./network.nix
    inputs.self.nixosProfiles.vm-i3
  ];
}
