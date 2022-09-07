{ pkgs, inputs, ... }:

{
  home-manager.users.stefan.home.packages = with pkgs; [
    wl-clipboard
    grim
    slurp
    pass-wayland
    wf-recorder
    swaylock-effects
  ];
}