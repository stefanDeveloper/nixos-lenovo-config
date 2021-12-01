{ pkgs, lib, ... }: 
{

  environment.sessionVariables = {
    XCURSOR_PATH = lib.mkForce "/home/stefan/.icons";
  };

  home-manager.users.stefan = {
    xsession.pointerCursor = {
      package = pkgs.breeze-qt5;
      name = "Breeze";
    };
  };
}
