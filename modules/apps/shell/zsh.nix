
{ pkgs, inputs, lib,... }:

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

  environment.pathsToLink = [ "/share/zsh" ];
  environment.shells = with pkgs; [ bashInteractive zsh ];
  
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
          name = "zsh-autosuggestions";
          src = pkgs.fetchFromGitHub {
            owner = "zsh-users";
            repo = "zsh-autosuggestions";
            rev = "v0.6.4";
            sha256 = "0h52p2waggzfshvy1wvhj4hf06fmzd44bv6j18k3l9rcx6aixzn6";
          };
        }
        {
          name = "fast-syntax-highlighting";
          src = pkgs.fetchFromGitHub {
            owner = "zdharma";
            repo = "fast-syntax-highlighting";
            rev = "v1.55";
            sha256 = "0h7f27gz586xxw7cc0wyiv3bx0x3qih2wwh05ad85bh2h834ar8d";
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
        #ltex-ls = "/home/stefan/Downloads/ltex-ls-15.1.0/bin/ltex-ls";
        update = "sudo nixos-rebuild switch";
      };

    };
  };
}