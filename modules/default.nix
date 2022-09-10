builtins.listToAttrs (builtins.map
  (path: {
    name = builtins.head (
      let
        b = builtins.baseNameOf path;
        m = builtins.match "(.*)\\.nix" b;
      in
      if isNull m then [ b ] else m
    );
    value = import path;
  }) [
  # Default imports
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
  ./keyboard-layout/us-de.nix

  ./apps
  
  ./apps/mail
  # Development
  ./apps/dev
  ./apps/dev/git.nix
  # Editors
  ./apps/editor
  ./apps/editor/vscode.nix
  ./apps/editor/vim.nix
  # Media
  ./apps/media

  ./overlay.nix

  ./security.nix

  ./apps/messaging

  ./apps/web
  ./apps/web/firefox.nix
  ./apps/web/tor.nix
  ./apps/web/google-chrome.nix

  ./apps/office

  ./apps/shell/zsh.nix
  ./apps/shell/fish.nix

  ./apps/terminal
  ./apps/terminal/alacritty.nix

  ./apps/fm

  ./apps/tools

  ./apps/monitoring

  ./apps/pentest

  ./apps/reading

  ./themes.nix

  ./workspace/cursor.nix
  ./workspace/gtk.nix
  ./workspace/qt.nix
  ./workspace/x11
  ./workspace/gnome
  ./workspace/i3
  ./workspace/sway
  ./workspace
])
