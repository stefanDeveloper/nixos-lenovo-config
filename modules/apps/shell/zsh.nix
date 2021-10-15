
{ pkgs, inputs, config, ... }:

{
  environment.pathsToLink = [ "/share/zsh" ];
  environment.shells = with pkgs; [ bashInteractive zsh ];
  
  home-manager.users.stefan = {

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
        update = "sudo nixos-rebuild switch --upgrade";
      };

    };

    # Enable zsh integration for broot.
    # See: https://github.com/Canop/broot
    programs.broot.enableZshIntegration = true;
  };
}