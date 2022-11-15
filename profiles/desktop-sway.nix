{ inputs, ... }: {
  imports = with inputs.self.nixosModules; [
    ./desktop.nix

    overlay
    sway
  ];
}
