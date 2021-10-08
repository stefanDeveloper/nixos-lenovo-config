{ config, pkgs, ... }:
let
  unstable = import <nixos-unstable> { config = config.nixpkgs.config; };
in
{
  # boot.extraModulePackages = [ unstable.config.boot.kernelPackages.rtw89 ];
  boot.extraModulePackages = [ unstable.linuxPackages.rtw89 ];
}
