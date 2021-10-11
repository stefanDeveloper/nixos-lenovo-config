{ inputs, pkgs, ... }:

{
  home-manager.users.stefan = {
    programs.git = {
      enable = true;
      userName  = "Stefan Machmeier";
      userEmail = "stefan-machmeier@outlook.com";
      # Enable delta syntax highlighter
      delta.enable = true;
    };

    home.packages = with pkgs; [ delta ];

    #home.file = {
    #  ".gitconfig" = { source = "${inputs.git-config}/gitconfig"; };
    #  ".gitignore" = { source = "${inputs.git-config}/gitignore"; };
    #  ".gitmessage" = { source = "${inputs.git-config}/gitmessage"; };
    #};
  };
}