builtins.listToAttrs (builtins.map (path: {
  name = builtins.head (let
    b = builtins.baseNameOf path;
    m = builtins.match "(.*)\\.nix" b;
  in if isNull m then [ b ] else m);
  value = import path;
}) [
  ./hardware
  ./boot
  ./system.nix
  ./network.nix
  ./nix.nix
  ./overlay.nix
  ./nixpkgs.nix
  ./services.nix
  ./locale.nix
  ./virtualisation.nix
  ./home.nix
  ./users

  ./workspace
  ./workspace/gnome

  ./apps
  ./apps/dev
  ./apps/messaging
  ./apps/web
  ./apps/web/firefox.nix
  ./apps/web/google-chrome.nix
  ./apps/web/tor.nix
  ./apps/media
])