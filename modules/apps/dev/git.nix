{ inputs, pkgs, ... }:

{
  home-manager.users.stefan = {
    programs.git = {
      enable = true;
      userName = "Stefan Machmeier";
      userEmail = "stefan-machmeier@outlook.com";
      # Enable delta syntax highlighter
      delta.enable = true;
      lfs.enable = true;
    };

    home.packages = with pkgs; [ delta ];
  };
}
