{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    ranger
    pcmanfm
    # An alternative for w3mimgdisplay
    python39Packages.ueberzug
  ];

  home-manager.users.stefan = {
    programs = {

      broot = {
        enable = true;
      };

      direnv = {
        enable = true;
        # enableFishIntegration = true;
        nix-direnv = {
          enable = true;
        };
      };
    };
  };
}
