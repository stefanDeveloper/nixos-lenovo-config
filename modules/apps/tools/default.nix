{ pkgs, ... }:

{
  imports = [
    ./base.nix
    ./compression.nix
    ./http.nix
    ./websocket.nix
    ./disk.nix
    ./network.nix
  ];
}