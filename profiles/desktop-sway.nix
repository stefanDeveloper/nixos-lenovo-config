{ inputs, ... }: {
  imports = with inputs.self.nixosModules; [
    ./desktop.nix

    sway
  ];
}