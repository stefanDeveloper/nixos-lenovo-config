{ pkgs, inputs, config, ... } :

{
  services.emacs = {
    enable = true;
  };

  home-manager.users.stefan = {

    programs.emacs = {
      enable = true;
    };
  };
}