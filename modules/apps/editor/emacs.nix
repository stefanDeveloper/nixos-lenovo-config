{ pkgs, inputs, config, ... } :

{
  home-manager.users.stefan = {
    programs.emacs = {
      enable = true;
    };
    home.file = {
      ".emacs.d" = { source = inputs.nix-doom-emacs; };
      ".doom.d" = { source = inputs.doom-emacs-config; };
      ".doom.d/defaultencrypt" = { source = inputs.defaultencrypt; };
    };
  };
}