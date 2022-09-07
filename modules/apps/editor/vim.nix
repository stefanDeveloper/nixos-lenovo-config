{ inputs, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    vim
  ];
  home-manager.users.stefan = {
    programs.neovim = {
      enable = true;
      vimAlias = true;
      viAlias = true;
      vimdiffAlias = true;
      withNodeJs = true;
    };

    home.packages = with pkgs; [
      python39Packages.pynvim
    ];
  };
}
