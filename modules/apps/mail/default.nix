{ config, lib, pkgs, inputs, ... }:
{
  home-manager.users.stefan = {
    home.file = {
      ".signature.work" = { source = ./signature.work; };
      ".signature.prv" = { source = ./signature.prv; };
    };
  };
}
