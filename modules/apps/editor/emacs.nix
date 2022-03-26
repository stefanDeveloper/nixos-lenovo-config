{ pkgs, inputs, config, ... } :

{
  home-manager.users.stefan = {
    programs.emacs = {
      enable = true;
    };
  };
}