{ pkgs, inputs, ... }:

{

  environment.systemPackages = with pkgs; [
    tmux
  ];

  #home-manager.users.stefan = {
  #  home.file = {
  #    ".tmux/plugins/tpm" = { source = inputs.tpm; };
  #    ".config/tmux/tmux.conf" = { source = "${inputs.tmux-config}/tmux.conf"; };
  #  };
  #};
}
