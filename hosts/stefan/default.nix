{ inputs, ... }: {
  imports = with inputs.self.nixosModules; [
    ./hardware

    inputs.self.nixosProfiles.desktop-gnome
  ];
}