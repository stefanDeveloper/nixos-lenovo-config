builtins.listToAttrs (builtins.map (path: {
  name = builtins.head (let
    b = builtins.baseNameOf path;
    m = builtins.match "(.*)\\.nix" b;
  in if isNull m then [ b ] else m);
  value = import path;
})[
  ./hardware
  ./boot
  ./system.nix
  ./network.nix
  ./nixpkgs.nix
  ./services.nix
  ./locale.nix
  ./virtualisation.nix
  ./home.nix
  ./nix.nix
  ./users

  ./apps
  ./apps/dev
  ./apps/dev/git.nix
  ./apps/media
  ./apps/messaging
  ./apps/web
  ./apps/web/firefox.nix
  ./apps/web/tor.nix
  ./apps/web/google-chrome.nix
  ./apps/office
  ./apps/shell/zsh.nix
  ./apps/shell/alacritty.nix
  ./apps/shell/fish.nix
  ./apps/fm
  ./apps/tools
  ./apps/terminal/kitty.nix
  ./apps/monitoring

  ./workspace/gnome
  ./workspace/i3
  ./workspace
  ])