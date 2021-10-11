
{ pkgs, inputs, ... }:

let
  #initExtra = builtins.readFile "${inputs.zsh-config}/zshrc";
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
    nmap
    telnet
    niv
  ];
  #environment.sessionVariables.SHELL = "zsh";
  # Symlink /share/zsh
  #environment.pathsToLink = [ "/share/zsh" ];

  home-manager.users.stefan = {
    #home.file = {
    #  ".zshenv" = { source = "${inputs.zsh-config}/zshenv"; };
    #  ".zprofile" = { source = "${inputs.zsh-config}/zprofile"; };
    #  ".zlogin" = { source = "${inputs.zsh-config}/zlogin"; };
    #  ".zlogout" = { source = "${inputs.zsh-config}/zlogout"; };
    #  ".zconfig" = { source = "${inputs.zsh-config}/zconfig"; };
    #};

    home.packages = with pkgs; [git];

    programs.zsh = {
      enable = true;
      enableCompletion = true;

      oh-my-zsh = {
        enable = true;
        theme = "agnoster";
      };
      plugins = [
        {
          name = "zsh-syntax-highlighting";
          src = pkgs.fetchFromGitHub {
            owner = "zsh-users";
            repo = "zsh-syntax-highlighting";
            rev = "2d60a47cc407117815a1d7b331ef226aa400a344";
            sha256 = "1pnxr39cayhsvggxihsfa3rqys8rr2pag3ddil01w96kw84z4id2";
          };
        }
      ];
      history = rec {
        expireDuplicatesFirst = true;
        size = 1000000;
        save = size;
      };
      shellAliases = {
        ll = "ls -l";
        update = "sudo nixos-rebuild switch";
      };

      #inherit initExtra;
    };

    # Enable zsh integration for broot.
    # See: https://github.com/Canop/broot
    programs.broot.enableZshIntegration = true;
  };
}