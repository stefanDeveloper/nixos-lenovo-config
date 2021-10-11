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
  ./gnome
  ./workspace
  ./workspace/gnome
  ./gnome

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

  ./workspace/gnome
  ./workspace
  ])