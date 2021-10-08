builtins.listToAttrs (builtins.map (path: {
  name = builtins.head (let
    b = builtins.baseNameOf path;
    m = builtins.match "(.*)\\.nix" b;
  in if isNull m then [ b ] else m);
  value = import path;
}) [
  ./hardware
  ./boot
  ./system.nix
  ./network.nix
  ./nix.nix
  ./overlay.nix
  ./nixpkgs.nix
  ./services.nix
  ./locale.nix
  ./security.nix
  ./virtualisation.nix
  ./home.nix
  ./users
  
  <nixos-hardware/lenovo/thinkpad/t14/amd/gen1>
])