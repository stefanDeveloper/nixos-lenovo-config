{ inputs, ... }:

{
  imports = [
    "${inputs.nixos-hardware}/lenovo/thinkpad/t14/amd/gen1"

    ./boot.nix
    ./fs.nix
  ];
}
