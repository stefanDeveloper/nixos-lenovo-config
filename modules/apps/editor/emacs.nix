{ pkgs, inputs, config, doom-emacs, ... } :

{
  
  services.pcscd.enable = true;
  
  programs.gnupg.agent = {
    enable = true;
    pinentryFlavor = "curses";
    enableSSHSupport = true;
  };

  home-manager.users.stefan = {

    programs.emacs = {
      enable = true;
    };

    #home.file = {
    #  "emacs-doom" = {
    #    source = "${inputs.nix-doom-emacs}/test/doom.d";
    #    target = ".doom.d";
    #  };
    #};

    
    imports = [ inputs.nix-doom-emacs.hmModule ];

    programs.doom-emacs = {
      enable = true;
      doomPrivateDir = "${config.users.users.stefan.home}/doom.d";
      # emacsPackagesOverlay = self: super: {
          # fixes https://github.com/vlaci/nix-doom-emacs/issues/394
      #   gitignore-mode = pkgs.emacsPackages.git-modes;
      #   gitconfig-mode = pkgs.emacsPackages.git-modes;
      # };
    };
  };
}