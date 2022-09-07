{ pkgs, inputs, lib, ... }:

{
  environment.systemPackages = with pkgs; [
    # Terminal/CLI
    vim
    killall
    niv
    zplug
  ];

  environment.pathsToLink = [ "/share/zsh" ];
  environment.shells = with pkgs; [ bashInteractive zsh ];

  home-manager.users.stefan = {

    home.packages = with pkgs; [ git ];

    programs.zsh = {
      enable = true;
      enableCompletion = true;
      enableAutosuggestions = true;

      oh-my-zsh = {
        enable = true;
        theme = "agnoster";
      };

      zplug = {
        enable = true;
        plugins = [
          { name = "zsh-users/zsh-autosuggestions"; } # Simple plugin installation
          { name = "zdharma-continuum/fast-syntax-highlighting"; }
          #{ name = "romkatv/powerlevel10k"; tags = [ as:theme depth:1 ]; } # Installations with additional options. For the list of options, please refer to Zplug README.
        ];
      };
      history = rec {
        expireDuplicatesFirst = true;
        size = 1000000;
        save = size;
      };
      shellAliases = {
        ll = "ls -l";
        update = "sudo nixos-rebuild switch";
      };

    };
  };
}
