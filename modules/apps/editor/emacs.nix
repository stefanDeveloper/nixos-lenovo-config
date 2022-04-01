{ pkgs, inputs, config, ... } :

{
  home-manager.users.stefan = {
    programs.emacs = {
      enable = true;
    };
    home.file = {
      ".doom.d/config.el" =  { source = "${inputs.doom-emacs-config}/config.el"; };
      ".doom.d/init.el" =  { source = "${inputs.doom-emacs-config}/init.el"; };
      ".doom.d/packages.el" =  { source = "${inputs.doom-emacs-config}/packages.el"; };
      ".doom.d/defaultencrypt" = { source = inputs.defaultencrypt; };
      ".doom.d/gnus-alias" = { source = inputs.gnus-alias; };
    };
  };
}