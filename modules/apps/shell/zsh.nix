
{ pkgs, inputs, ... }:

{
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
  
  home-manager.users.stefan = {

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
        ltex-ls = "/home/stefan/Downloads/ltex-ls-15.1.0/bin/ltex-ls";
        update = "sudo nixos-rebuild switch";
      };

    };
  };
}