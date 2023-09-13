{ inputs, ... }: {
  imports = with inputs.self.nixosModules; [
    ./hardware
    "${modulesPath}/installer/cd-dvd/installation-cd-minimal.nix"
    inputs.self.nixosProfiles.vm-i3
  ];
}
