{ pkgs, ... }:

{
  imports = [
    ./sound.nix
    ./bluetooth.nix
    ./opengl.nix
    ./wifi.nix
  ];
}
