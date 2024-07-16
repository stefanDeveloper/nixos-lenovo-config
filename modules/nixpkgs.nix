{ pkgs, ... }:
{
  nixpkgs.config = {
    allowUnfree = true;
  };
  environment.systemPackages = [
    (pkgs.writeShellScriptBin "nixFlakes" ''
      exec ${pkgs.nixFlakes}/bin/nix --experimental-features "nix-command flakes" "$@"
    '')
  ];
}
