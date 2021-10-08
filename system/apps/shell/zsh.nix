
{ pkgs, inputs, ... }:

let
  initExtra = builtins.readFile "${inputs.zsh-config}/zshrc";
in {
  environment.systemPackages = with pkgs; [
    # Terminal/CLI
    vim
    wget
    zip
    unzip
    htop
    killall
    pciutils
    zsh
    oh-my-zsh
    nmap
    telnet
    niv
  ];
  environment.sessionVariables.SHELL = "zsh";
  # Symlink /share/zsh
  environment.pathsToLink = [ "/share/zsh" ];

  home-manager.users.stefan = {
    home.file = {
      ".zshenv" = { source = "${inputs.zsh-config}/zshenv"; };
      ".zprofile" = { source = "${inputs.zsh-config}/zprofile"; };
      ".zlogin" = { source = "${inputs.zsh-config}/zlogin"; };
      ".zlogout" = { source = "${inputs.zsh-config}/zlogout"; };
      ".zconfig" = { source = "${inputs.zsh-config}/zconfig"; };
    };

    programs.zsh = {
      enable = true;
      enableCompletion = true;

      history = rec {
        expireDuplicatesFirst = true;
        size = 1000000;
        save = size;
      };
      shellAliases = {
        ll = "ls -l";
        update = "sudo nixos-rebuild switch";
      };
      ohMyZsh = {
        enable = true;
        plugins = [ "git" "python" "man" ];
        theme = "agnoster";
        customPkgs = [
          pkgs.nix-zsh-completions
        ];
      };

      inherit initExtra;
    };

    # Enable zsh integration for broot.
    # See: https://github.com/Canop/broot
    programs.broot.enableZshIntegration = true;
  };
}