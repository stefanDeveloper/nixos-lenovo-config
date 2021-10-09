
{ pkgs, ... }:

let
  stefan = import ./stefan.nix { };
in {
  users = {

    defaultUserShell = pkgs.zsh;
    
    users = {
      stefan = stefan;
    };
  };
}